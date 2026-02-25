import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_spacing.dart';
import 'package:frontend/core/constants/app_text_styles.dart';
import 'package:frontend/core/services/api_service.dart';
import 'package:frontend/features/visits/domain/visit_details.dart';
import 'package:frontend/l10n/app_localizations.dart';

class VisitFeedbackScreen extends StatefulWidget {
  const VisitFeedbackScreen({super.key, required this.visitId});

  final int visitId;

  @override
  State<VisitFeedbackScreen> createState() => _VisitFeedbackScreenState();
}

class _VisitFeedbackScreenState extends State<VisitFeedbackScreen> {
  VisitDetails? _data;
  bool _loading = true;
  String? _error;
  int _rate = 0;
  final TextEditingController _commentController = TextEditingController();
  bool _submitting = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    final result = await ApiService.getVisitDatasById(widget.visitId);
    if (!mounted) return;
    if (result.statusCode == 200) {
      final data = result.body?['data'];
      final parsed = _parseVisitDetails(data);
      setState(() {
        _data = parsed;
        _loading = false;
        _error = parsed == null ? 'invalidData' : null;
      });
    } else {
      setState(() {
        _loading = false;
        _error = result.body?['message'] as String? ?? 'loadError';
      });
    }
  }

  VisitDetails? _parseVisitDetails(dynamic data) {
    if (data is! Map<String, dynamic>) return null;
    final visitId = _parseInt(data['visit_id']);
    if (visitId == null) return null;
    final statusId = _parseInt(data['status_id']) ?? _parseInt(data['fk_status_id']) ?? 1;
    return VisitDetails(
      visitId: visitId,
      visitTitle: _toString(data['visit_title']) ?? '',
      scheduledDate: _toString(data['scheduled_date']) ?? '',
      closureDate: _toString(data['closure_date']),
      creationDate: _toString(data['creation_date']),
      comment: _toString(data['comment']),
      statusId: statusId,
      statusName: _toString(data['status_name']) ?? '',
      rate: _parseInt(data['feedback']),
      companyName: _toString(data['company_name']) ?? '',
      companyAddress: _toString(data['company_address']) ?? '',
      clientName: _toString(data['client_name']) ?? '',
      clientPhone: _toString(data['client_phone']) ?? '',
      clientFunction: _toString(data['client_function']) ?? '',
    );
  }

  int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }

  String? _toString(dynamic value) {
    if (value == null) return null;
    if (value is String) return value;
    return value.toString();
  }

  static String _formatDateTime(String? isoDate) {
    if (isoDate == null || isoDate.isEmpty) return '—';
    try {
      final parsedDate = DateTime.parse(isoDate);
      return DateFormat('d MMMM yyyy \'à\' HH:mm', 'fr_FR').format(parsedDate);
    } catch (exception) {
      return isoDate;
    }
  }

  Future<void> _submit() async {
    if (_rate < 1 || _rate > 5) return;
    setState(() => _submitting = true);
    final comment = _commentController.text.trim();
    final result = await ApiService.submitFeedback(
      visitId: widget.visitId,
      rate: _rate,
      comment: comment.isEmpty ? null : comment,
    );
    if (!mounted) return;
    setState(() => _submitting = false);
    if (result.statusCode == 200) {
      context.go('/visits', extra: 'feedback_success');
    } else {
      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            result.body?['message'] as String? ?? l10n.visitFeedbackSubmitError,
          ),
          backgroundColor: AppColors.danger,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.page,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          l10n.visitFeedbackTitle,
          style: AppTextStyles.headlineSmall,
        ),
        centerTitle: true,
      ),
      body: _buildBody(l10n),
    );
  }

  Widget _buildBody(AppLocalizations l10n) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null || _data == null) {
      final message = _error == 'invalidData'
          ? l10n.visitDetailsInvalidData
          : (_error == 'loadError'
              ? l10n.visitFeedbackLoadError
              : (_error ?? l10n.visitDetailsError));
      return Center(
        child: Text(
          message,
          style: AppTextStyles.bodyMedium.copyWith(color: AppColors.danger),
          textAlign: TextAlign.center,
        ),
      );
    }
    final visitDetails = _data!;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildVisitorCard(visitDetails, l10n),
          const SizedBox(height: AppSpacing.lg),
          _buildFeedbackSection(l10n),
          const SizedBox(height: AppSpacing.xl),
          SizedBox(
            height: 52,
            child: FilledButton(
              onPressed: _submitting || _rate < 1
                  ? null
                  : _submit,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.accentPurple,
                foregroundColor: AppColors.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: _submitting
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.surface,
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(l10n.visitFeedbackSendBtn),
                        const SizedBox(width: AppSpacing.xs),
                        const Icon(Icons.arrow_forward, size: 18),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVisitorCard(VisitDetails visitDetails, AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.falseBlack.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: AppColors.primaryBlue.withOpacity(0.15),
            child: Icon(Icons.person, color: AppColors.primaryBlue, size: 32),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(visitDetails.clientName, style: AppTextStyles.titleMedium),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  l10n.visitDetailsClient,
                  style: AppTextStyles.caption,
                ),
                const SizedBox(height: AppSpacing.xs),
                Row(
                  children: [
                    Icon(Icons.calendar_today_outlined,
                        size: 14, color: AppColors.textSecondary),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      _formatDateTime(visitDetails.scheduledDate),
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedbackSection(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: 20,
              decoration: BoxDecoration(
                color: AppColors.accentPurple,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              l10n.visitFeedbackYourOpinion,
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.accentPurpleDark,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          l10n.visitFeedbackRateLabel,
          style: AppTextStyles.labelMedium.copyWith(
            color: AppColors.textMuted,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(5, (index) {
            final starIndex = index + 1;
            final selected = _rate >= starIndex;
            return Padding(
              padding: const EdgeInsets.only(right: AppSpacing.sm),
              child: GestureDetector(
                onTap: () => setState(() => _rate = starIndex),
                child: Icon(
                  selected ? Icons.star : Icons.star_border,
                  size: 40,
                  color: selected ? AppColors.warning : AppColors.greyUi,
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          '$_rate/5',
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          l10n.visitFeedbackAdditionalComments,
          style: AppTextStyles.labelMedium.copyWith(
            color: AppColors.textMuted,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        TextField(
          controller: _commentController,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: l10n.visitFeedbackCommentHint,
            hintStyle: AppTextStyles.placeholder,
            filled: true,
            fillColor: AppColors.input,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.all(AppSpacing.md),
          ),
          style: AppTextStyles.bodyMedium,
        ),
      ],
    );
  }
}
