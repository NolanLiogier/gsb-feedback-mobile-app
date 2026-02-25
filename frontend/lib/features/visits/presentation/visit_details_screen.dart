import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_spacing.dart';
import 'package:frontend/core/constants/app_text_styles.dart';
import 'package:frontend/core/services/api_service.dart';
import 'package:frontend/features/visits/domain/visit_details.dart';
import 'package:frontend/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class VisitDetailsScreen extends StatefulWidget {
  const VisitDetailsScreen({super.key, required this.visitId});

  final int visitId;

  @override
  State<VisitDetailsScreen> createState() => _VisitDetailsScreenState();
}

class _VisitDetailsScreenState extends State<VisitDetailsScreen> {
  VisitDetails? _data;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
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

  Future<void> _confirmDelete(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext ctx) => AlertDialog(
        title: Text(l10n.visitDetailsDeleteConfirmTitle),
        content: Text(l10n.visitDetailsDeleteConfirmMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(l10n.newVisitCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: FilledButton.styleFrom(backgroundColor: AppColors.danger),
            child: Text(l10n.visitDetailsDeleteBtn),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    final result = await ApiService.deleteVisit(widget.visitId);
    if (!mounted) return;
    if (result.statusCode == 200) {
      context.go('/visits', extra: 'delete_success');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            result.body?['message'] as String? ?? l10n.visitDetailsDeleteError,
          ),
          backgroundColor: AppColors.danger,
        ),
      );
    }
  }

  VisitDetails? _parseVisitDetails(dynamic data) {
    if (data is! Map<String, dynamic>) return null;
    final visitId = _parseInt(data['visit_id']);
    if (visitId == null) return null;
    final statusId = _parseInt(data['status_id']) ?? _parseInt(data['fk_status_id']);
    if (statusId == null) return null;
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

  static String _formatDate(String? isoDate) {
    if (isoDate == null || isoDate.isEmpty) return '—';
    try {
      final parsedDate = DateTime.parse(isoDate);
      return DateFormat('d MMMM yyyy', 'fr_FR').format(parsedDate);
    } catch (exception) {
      return isoDate;
    }
  }

  static String _formatDateTime(String? isoDate) {
    if (isoDate == null || isoDate.isEmpty) return '—';
    try {
      final parsedDate = DateTime.parse(isoDate);
      return DateFormat('dd/MM/yyyy \'à\' HH:mm', 'fr_FR').format(parsedDate);
    } catch (exception) {
      return isoDate;
    }
  }

  static String _formatTime(String? isoDate) {
    if (isoDate == null || isoDate.isEmpty) return '—';
    try {
      final parsedDate = DateTime.parse(isoDate);
      return DateFormat('HH:mm', 'fr_FR').format(parsedDate);
    } catch (exception) {
      return '—';
    }
  }

  static Color _statusColor(String statusName) {
    final statusLower = statusName.toLowerCase();
    if (statusLower.contains('planifi') || statusLower.contains('attente')) {
      return AppColors.accentPurple;
    }
    if (statusLower.contains('cours') || statusLower.contains('valid')) {
      return AppColors.primaryBlue;
    }
    return AppColors.textSecondary;
  }

  @override
  Widget build(BuildContext context) {
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
          AppLocalizations.of(context)!.visitDetailsTitle,
          style: AppTextStyles.headlineSmall,
        ),
        centerTitle: true,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null || _data == null) {
      final l10n = AppLocalizations.of(context)!;
      final message = _error == 'invalidData'
          ? l10n.visitDetailsInvalidData
          : (_error == 'loadError'
              ? l10n.visitDetailsLoadError
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
          Text(
            visitDetails.visitTitle,
            style: AppTextStyles.headlineMedium,
          ),
          const SizedBox(height: AppSpacing.md),
          _buildStatusCard(context, visitDetails),
          const SizedBox(height: AppSpacing.md),
          _buildGeneralInfoCard(context, visitDetails),
          const SizedBox(height: AppSpacing.md),
          _buildCommentCard(context, visitDetails),
          const SizedBox(height: AppSpacing.md),
          _buildClientCard(context, visitDetails),
          if (visitDetails.statusId == 3 && visitDetails.rate != null) ...[
            const SizedBox(height: AppSpacing.lg),
            _buildRatingCard(context, visitDetails),
          ],
          const SizedBox(height: AppSpacing.lg),
          if (visitDetails.statusId != 3) ...[
            SizedBox(
              height: 52,
              child: OutlinedButton.icon(
                onPressed: () => context.push('/visits/${widget.visitId}/feedback'),
                icon: const Icon(Icons.rate_review_outlined, size: 22),
                label: Text(AppLocalizations.of(context)!.visitDetailsFeedbackBtn),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.accentPurple,
                  side: const BorderSide(color: AppColors.accentPurple),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
          SizedBox(
            height: 52,
            child: OutlinedButton.icon(
              onPressed: () => _confirmDelete(context),
              icon: const Icon(Icons.delete_outline, size: 22),
              label: Text(AppLocalizations.of(context)!.visitDetailsDeleteBtn),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.danger,
                side: const BorderSide(color: AppColors.danger),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCard(BuildContext context, VisitDetails visitDetails) {
    final l10n = AppLocalizations.of(context)!;
    final statusColor = _statusColor(visitDetails.statusName);
    return _Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.info_outline,
                color: statusColor,
                size: 22,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                l10n.visitDetailsCurrentStatus,
                style: AppTextStyles.labelMedium.copyWith(
                  color: statusColor,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          Text(
            visitDetails.statusName,
            style: AppTextStyles.titleMedium.copyWith(
              color: statusColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGeneralInfoCard(BuildContext context, VisitDetails visitDetails) {
    final l10n = AppLocalizations.of(context)!;
    return _Card(
      title: l10n.visitDetailsGeneralInfo,
      child: Column(
        children: [
          _InfoRow(
            icon: Icons.calendar_today_outlined,
            value: _formatDate(visitDetails.scheduledDate),
            label: l10n.visitDetailsVisitDate,
            iconColor: AppColors.primaryBlue,
          ),
          const SizedBox(height: AppSpacing.md),
          _InfoRow(
            icon: Icons.access_time_outlined,
            value: _formatTime(visitDetails.scheduledDate),
            label: l10n.visitDetailsTimeSlot,
            iconColor: AppColors.primaryBlue,
          ),
          const SizedBox(height: AppSpacing.md),
          _InfoRow(
            icon: Icons.location_on_outlined,
            value: visitDetails.companyAddress,
            label: l10n.visitDetailsPracticeLocation,
            iconColor: AppColors.primaryBlue,
          ),
          const SizedBox(height: AppSpacing.md),
          _InfoRow(
            icon: Icons.schedule_outlined,
            value: _formatDateTime(visitDetails.creationDate),
            label: l10n.visitDetailsCreationDate,
            iconColor: AppColors.primaryBlue,
          ),
        ],
      ),
    );
  }

  Widget _buildCommentCard(BuildContext context, VisitDetails visitDetails) {
    final l10n = AppLocalizations.of(context)!;
    return _Card(
      title: l10n.visitDetailsComment,
      child: Text(
        visitDetails.comment?.isNotEmpty == true
            ? visitDetails.comment!
            : '—',
        style: AppTextStyles.bodyMedium.copyWith(
          color: visitDetails.comment?.isNotEmpty == true
              ? AppColors.falseBlack
              : AppColors.textSecondary,
        ),
      ),
    );
  }

  Widget _buildClientCard(BuildContext context, VisitDetails visitDetails) {
    final l10n = AppLocalizations.of(context)!;
    final phoneUri = Uri(scheme: 'tel', path: visitDetails.clientPhone);
    return _Card(
      title: l10n.visitDetailsClient,
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
                  visitDetails.clientFunction,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Material(
            color: AppColors.primaryBlue.withOpacity(0.15),
            shape: const CircleBorder(),
            child: InkWell(
              onTap: () => launchUrl(phoneUri),
              customBorder: const CircleBorder(),
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.sm),
                child: Icon(Icons.phone, color: AppColors.primaryBlue, size: 24),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingCard(BuildContext context, VisitDetails visitDetails) {
    final l10n = AppLocalizations.of(context)!;
    final rate = visitDetails.rate!;
    return _Card(
      title: l10n.visitDetailsRatingLabel,
      child: Row(
        children: [
          ...List.generate(5, (index) {
            final filled = index < rate;
            return Padding(
              padding: const EdgeInsets.only(right: AppSpacing.xs),
              child: Icon(
                filled ? Icons.star : Icons.star_border,
                size: 28,
                color: filled ? AppColors.warning : AppColors.greyUi,
              ),
            );
          }),
          const SizedBox(width: AppSpacing.sm),
          Text(
            '$rate/5',
            style: AppTextStyles.titleMedium.copyWith(
              color: AppColors.falseBlack,
            ),
          ),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.child, this.title});

  final String? title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(
              title!,
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.textMuted,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
          child,
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.value,
    required this.label,
    Color? iconColor,
  }) : iconColor = iconColor ?? AppColors.textSecondary;

  final IconData icon;
  final String value;
  final String label;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, size: 20, color: iconColor),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(value, style: AppTextStyles.bodyMedium),
              Text(
                label,
                style: AppTextStyles.caption,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
