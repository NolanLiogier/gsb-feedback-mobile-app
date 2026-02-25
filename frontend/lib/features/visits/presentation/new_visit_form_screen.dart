import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_spacing.dart';
import 'package:frontend/core/constants/app_text_styles.dart';
import 'package:frontend/core/services/api_service.dart';
import 'package:frontend/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class GsbVisitorItem {
  const GsbVisitorItem({
    required this.userId,
    required this.userName,
    required this.function,
  });

  final int userId;
  final String userName;
  final String function;
}

class EmployeeItem {
  const EmployeeItem({
    required this.id,
    required this.name,
    required this.function,
  });

  final int id;
  final String name;
  final String function;
}

class StockItem {
  const StockItem({
    required this.productId,
    required this.productName,
  });

  final int productId;
  final String productName;
}

class NewVisitFormScreen extends StatefulWidget {
  const NewVisitFormScreen({super.key, required this.companyId});

  final int companyId;

  @override
  State<NewVisitFormScreen> createState() => _NewVisitFormScreenState();
}

class _NewVisitFormScreenState extends State<NewVisitFormScreen> {
  List<GsbVisitorItem> _gsbVisitors = [];
  List<EmployeeItem> _employees = [];
  List<StockItem> _stockList = [];
  bool _loading = true;
  String? _error;
  bool _submitting = false;

  final TextEditingController _titleController = TextEditingController();
  DateTime? _scheduledDate;
  final TextEditingController _commentController = TextEditingController();
  int? _selectedVisitorId;
  int? _selectedEmployeeId;
  int? _selectedProductId;

  static const int _defaultStatusId = 1;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    final result = await ApiService.getNewVisitDatas(widget.companyId);
    if (!mounted) return;
    if (result.statusCode == 200) {
      final data = result.body?['data'];
      if (data is! Map<String, dynamic>) {
        setState(() {
          _loading = false;
          _error = AppLocalizations.of(context)!.newVisitLoadDataError;
        });
        return;
      }
      final visitors = _parseGsbVisitors(data['gsbVisitors']);
      final employees = _parseEmployees(data['employeesByCompanyId']);
      final stock = _parseStockList(data['stockList']);
      setState(() {
        _gsbVisitors = visitors;
        _employees = employees;
        _stockList = stock;
        _loading = false;
        _error = null;
        if (visitors.isNotEmpty) _selectedVisitorId = visitors.first.userId;
        if (employees.isNotEmpty) _selectedEmployeeId = employees.first.id;
        if (stock.isNotEmpty) _selectedProductId = stock.first.productId;
      });
    } else {
      final l10n = AppLocalizations.of(context)!;
      setState(() {
        _loading = false;
        _error = result.body?['message'] as String? ?? l10n.newVisitLoadDataError;
      });
    }
  }

  List<GsbVisitorItem> _parseGsbVisitors(dynamic data) {
    if (data is! List) return [];
    final list = <GsbVisitorItem>[];
    for (final entry in data) {
      if (entry is! Map<String, dynamic>) continue;
      final id = _parseInt(entry['user_id']);
      final name = _str(entry['user_name']);
      final fn = _str(entry['function']);
      if (id == null || name == null) continue;
      list.add(GsbVisitorItem(
        userId: id,
        userName: name,
        function: fn ?? '',
      ));
    }
    return list;
  }

  List<EmployeeItem> _parseEmployees(dynamic data) {
    if (data is! List) return [];
    final list = <EmployeeItem>[];
    for (final entry in data) {
      if (entry is! Map<String, dynamic>) continue;
      final id = _parseInt(entry['id']);
      final name = _str(entry['name']);
      final fn = _str(entry['function']);
      if (id == null || name == null) continue;
      list.add(EmployeeItem(
        id: id,
        name: name,
        function: fn ?? '',
      ));
    }
    return list;
  }

  List<StockItem> _parseStockList(dynamic data) {
    if (data is! List) return [];
    final list = <StockItem>[];
    for (final entry in data) {
      if (entry is! Map<String, dynamic>) continue;
      final id = _parseInt(entry['product_id']);
      final name = _str(entry['product_name']);
      if (id == null || name == null) continue;
      list.add(StockItem(productId: id, productName: name));
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

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _scheduledDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
    );
    if (picked != null && mounted) {
      setState(() => _scheduledDate = picked);
    }
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context)!;
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.newVisitTitleRequired)),
      );
      return;
    }
    if (_selectedVisitorId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.newVisitVisitorRequired)),
      );
      return;
    }
    if (_selectedEmployeeId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.newVisitEmployeeRequired)),
      );
      return;
    }
    setState(() => _submitting = true);
    final scheduledDateStr = _scheduledDate != null
        ? DateFormat('yyyy-MM-dd').format(_scheduledDate!)
        : null;
    final comment = _commentController.text.trim();
    final result = await ApiService.createVisit(
      visitTitle: title,
      fkClientId: _selectedEmployeeId!,
      fkGsbVisitorId: _selectedVisitorId!,
      fkStatusId: _defaultStatusId,
      fkProductId: _selectedProductId,
      scheduledDate: scheduledDateStr,
      comment: comment.isEmpty ? null : comment,
    );
    if (!mounted) return;
    setState(() => _submitting = false);
    if (result.statusCode == 201) {
      context.go('/visits', extra: true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            result.body?['message'] as String? ?? l10n.newVisitCreateError,
          ),
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
          Text(
            l10n.newRequestHeading,
            style: AppTextStyles.headlineMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            l10n.newRequestSubtitle,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            l10n.newVisitFormTitleLabel,
            style: AppTextStyles.labelLarge,
          ),
          const SizedBox(height: AppSpacing.sm),
          _titleField(),
          const SizedBox(height: AppSpacing.md),
          Text(
            l10n.newVisitGsbVisitorLabel,
            style: AppTextStyles.labelLarge,
          ),
          const SizedBox(height: AppSpacing.sm),
          _dropdown<int>(
            value: _selectedVisitorId,
            hint: l10n.newVisitSelectVisitor,
            items: _gsbVisitors
                .map(
                  (v) => DropdownMenuItem<int>(
                    value: v.userId,
                    child: Text(
                      '${v.userName} (${v.function})',
                      style: AppTextStyles.bodyMedium,
                    ),
                  ),
                )
                .toList(),
            onChanged: (value) => setState(() => _selectedVisitorId = value),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            l10n.newVisitEmployeeLabel,
            style: AppTextStyles.labelLarge,
          ),
          const SizedBox(height: AppSpacing.sm),
          _dropdown<int>(
            value: _selectedEmployeeId,
            hint: l10n.newVisitSelectEmployee,
            items: _employees
                .map(
                  (e) => DropdownMenuItem<int>(
                    value: e.id,
                    child: Text(
                      '${e.name} (${e.function})',
                      style: AppTextStyles.bodyMedium,
                    ),
                  ),
                )
                .toList(),
            onChanged: (value) => setState(() => _selectedEmployeeId = value),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            l10n.newVisitVisitDate,
            style: AppTextStyles.labelLarge,
          ),
          const SizedBox(height: AppSpacing.sm),
          _dateField(l10n),
          const SizedBox(height: AppSpacing.md),
          Text(
            l10n.newVisitObjective,
            style: AppTextStyles.labelLarge,
          ),
          const SizedBox(height: AppSpacing.sm),
          _commentField(l10n),
          const SizedBox(height: AppSpacing.md),
          Text(
            l10n.newVisitProductLabel,
            style: AppTextStyles.labelLarge,
          ),
          const SizedBox(height: AppSpacing.sm),
          _dropdown<int>(
            value: _selectedProductId,
            hint: l10n.newVisitSelectProduct,
            items: _stockList
                .map(
                  (s) => DropdownMenuItem<int>(
                    value: s.productId,
                    child: Text(s.productName, style: AppTextStyles.bodyMedium),
                  ),
                )
                .toList(),
            onChanged: (value) => setState(() => _selectedProductId = value),
          ),
          const SizedBox(height: AppSpacing.xxl),
          FilledButton(
            onPressed: _submitting ? null : _submit,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              foregroundColor: AppColors.surface,
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: _submitting
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(l10n.newVisitSendRequest),
          ),
          const SizedBox(height: AppSpacing.md),
          OutlinedButton(
            onPressed: _submitting ? null : () => context.pop(),
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

  Widget _dropdown<T>({
    required T? value,
    required String hint,
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T?> onChanged,
  }) {
    return Container(
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
        child: DropdownButton<T>(
          value: value,
          isExpanded: true,
          hint: Text(hint, style: AppTextStyles.placeholder),
          items: items,
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _dateField(AppLocalizations l10n) {
    final label = _scheduledDate != null
        ? DateFormat('MM/dd/yyyy').format(_scheduledDate!)
        : null;
    return InkWell(
      onTap: _pickDate,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.input,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label ?? '',
                style: label != null
                    ? AppTextStyles.bodyMedium
                    : AppTextStyles.placeholder,
              ),
            ),
            Icon(Icons.calendar_today, size: 20, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }

  Widget _titleField() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.input,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: TextField(
        controller: _titleController,
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          counterText: '',
        ),
        style: AppTextStyles.bodyMedium,
        maxLength: 255,
      ),
    );
  }

  Widget _commentField(AppLocalizations l10n) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.input,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: TextField(
        controller: _commentController,
        maxLines: 4,
        decoration: InputDecoration(
          hintText: l10n.newVisitObjectiveHint,
          hintStyle: AppTextStyles.placeholder,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(AppSpacing.md),
        ),
        style: AppTextStyles.bodyMedium,
      ),
    );
  }
}
