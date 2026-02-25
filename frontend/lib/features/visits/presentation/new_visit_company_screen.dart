import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_spacing.dart';
import 'package:frontend/core/constants/app_text_styles.dart';
import 'package:frontend/core/services/api_service.dart';
import 'package:frontend/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class CompanyItem {
  const CompanyItem({required this.companyId, required this.companyName});

  final int companyId;
  final String companyName;
}

class NewVisitCompanyScreen extends StatefulWidget {
  const NewVisitCompanyScreen({super.key});

  @override
  State<NewVisitCompanyScreen> createState() => _NewVisitCompanyScreenState();
}

class _NewVisitCompanyScreenState extends State<NewVisitCompanyScreen> {
  List<CompanyItem> _companies = [];
  bool _loading = true;
  String? _error;
  int? _selectedCompanyId;

  @override
  void initState() {
    super.initState();
    _loadCompanies();
  }

  Future<void> _loadCompanies() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    final result = await ApiService.getCompaniesList();
    if (!mounted) return;
    if (result.statusCode == 200) {
      final data = result.body?['data'];
      final list = _parseCompanies(data);
      setState(() {
        _companies = list;
        _loading = false;
        _error = null;
      });
    } else {
      final l10n = AppLocalizations.of(context)!;
      setState(() {
        _loading = false;
        _error = result.body?['message'] as String? ?? l10n.newVisitLoadCompaniesError;
      });
    }
  }

  List<CompanyItem> _parseCompanies(dynamic data) {
    if (data is! List) return [];
    final list = <CompanyItem>[];
    for (final entry in data) {
      if (entry is! Map<String, dynamic>) continue;
      final id = _parseInt(entry['company_id']);
      final name = _str(entry['company_name']);
      if (id == null || name == null) continue;
      list.add(CompanyItem(companyId: id, companyName: name));
    }
    return list;
  }

  int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }

  String? _str(dynamic value) {
    if (value == null) return null;
    if (value is String) return value;
    return value.toString();
  }

  void _onContinue() {
    final l10n = AppLocalizations.of(context)!;
    if (_selectedCompanyId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.newVisitSelectCompanyFirst)),
      );
      return;
    }
    context.push('/visits/new/form', extra: _selectedCompanyId);
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
          onPressed: () => context.pop(),
        ),
        title: Text(
          l10n.newVisitTitle,
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
    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Text(
            _error!,
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.danger),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppSpacing.lg),
          Text(
            l10n.newVisitCompanyLabel,
            style: AppTextStyles.labelLarge,
          ),
          const SizedBox(height: AppSpacing.sm),
          Container(
            decoration: BoxDecoration(
              color: AppColors.input,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                value: _selectedCompanyId,
                isExpanded: true,
                hint: Text(
                  l10n.newVisitSelectCompanyHint,
                  style: AppTextStyles.placeholder,
                ),
                items: _companies
                    .map(
                      (c) => DropdownMenuItem<int>(
                        value: c.companyId,
                        child: Text(
                          c.companyName,
                          style: AppTextStyles.bodyMedium,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() => _selectedCompanyId = value);
                },
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          FilledButton(
            onPressed: _onContinue,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              foregroundColor: AppColors.surface,
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(l10n.newVisitContinue),
          ),
          const SizedBox(height: AppSpacing.md),
          OutlinedButton(
            onPressed: () => context.pop(),
            style: OutlinedButton.styleFrom(
              backgroundColor: AppColors.cancelButtonBg,
              foregroundColor: AppColors.accentPurpleDark,
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(l10n.newVisitCancel),
          ),
        ],
      ),
    );
  }
}
