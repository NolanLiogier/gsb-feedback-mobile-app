import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_spacing.dart';
import 'package:frontend/core/constants/app_text_styles.dart';
import 'package:frontend/core/navigation/route_observer.dart';
import 'package:frontend/core/services/api_service.dart';
import 'package:frontend/core/services/user_preferences.dart';
import 'package:frontend/features/visits/domain/visit.dart';
import 'package:frontend/features/visits/presentation/widgets/visit_card.dart';
import 'package:frontend/l10n/app_localizations.dart';
import 'package:frontend/shared/app_bar.dart';
import 'package:frontend/shared/app_nav_bar.dart';
import 'package:frontend/shared/app_notification.dart';
import 'package:go_router/go_router.dart';

class VisitsScreen extends StatefulWidget {
  const VisitsScreen({super.key, this.showCreateSuccess = false, this.showFeedbackSuccess = false, this.showDeleteSuccess = false});

  final bool showCreateSuccess;
  final bool showFeedbackSuccess;
  final bool showDeleteSuccess;

  @override
  State<VisitsScreen> createState() => _VisitsScreenState();
}

class _VisitsScreenState extends State<VisitsScreen> with RouteAware {
  List<Visit> _visits = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadVisits();
    _showPendingSnackBar();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route is ModalRoute<void>) {
      appRouteObserver.subscribe(this, route);
    }
  }

  @override
  void dispose() {
    appRouteObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant VisitsScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    final hadSuccess = oldWidget.showCreateSuccess ||
        oldWidget.showFeedbackSuccess ||
        oldWidget.showDeleteSuccess;
    final hasSuccess = widget.showCreateSuccess ||
        widget.showFeedbackSuccess ||
        widget.showDeleteSuccess;
    if (hasSuccess && !hadSuccess) {
      _loadVisits();
      _showPendingSnackBar();
    }
  }

  @override
  void didPopNext() {
    _loadVisits();
  }

  void _showPendingSnackBar() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final l10n = AppLocalizations.of(context)!;
      if (widget.showCreateSuccess) {
        showAppNotification(
          context,
          message: l10n.newVisitCreateSuccess,
          type: AppNotificationType.success,
        );
      }
      if (widget.showFeedbackSuccess) {
        showAppNotification(
          context,
          message: l10n.visitsFeedbackSuccess,
          type: AppNotificationType.success,
        );
      }
      if (widget.showDeleteSuccess) {
        showAppNotification(
          context,
          message: l10n.visitDetailsDeleteSuccess,
          type: AppNotificationType.success,
        );
      }
    });
  }

  Future<void> _loadVisits() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    final userId = await UserPreferences.getUserId();
    if (userId == null) {
      final l10n = AppLocalizations.of(context)!;
      setState(() {
        _loading = false;
        _error = l10n.visitsUserNotFound;
      });
      return;
    }
    final result = await ApiService.getVisitsByUserId(userId);
    if (!mounted) return;
    if (result.statusCode == 200) {
      final data = result.body?['data'];
      final list = _parseVisits(data);
      setState(() {
        _visits = list;
        _loading = false;
        _error = null;
      });
    } else {
      final l10n = AppLocalizations.of(context)!;
      setState(() {
        _loading = false;
        _error = result.body?['message'] as String? ?? l10n.visitsLoadError;
      });
    }
  }

  List<Visit> _parseVisits(dynamic data) {
    if (data is! List) return [];
    final list = <Visit>[];
    for (final entry in data) {
      if (entry is! Map<String, dynamic>) continue;
      final visitId = _parseInt(entry['visit_id']);
      if (visitId == null) continue;
      list.add(Visit(
        visitId: visitId,
        visitTitle: _str(entry['visit_title']) ?? '',
        scheduledDate: _str(entry['scheduled_date']) ?? '',
        closureDate: _str(entry['closure_date']),
        comment: _str(entry['comment']),
        statusName: _str(entry['status_name']) ?? '',
        companyName: _str(entry['company_name']) ?? '',
      ));
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

  Future<void> _handleLogout() async {
    await UserPreferences.clearSession();
    if (!mounted) return;
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.page,
      appBar: GsbAppBar(
        title: l10n.visitsTitle,
        logoutLabel: l10n.appBarLogout,
        onLogout: _handleLogout,
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: _onNewVisit,
        backgroundColor: AppColors.primaryBlue,
        child: const Icon(Icons.add, color: AppColors.surface),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildBody() {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return Center(
        child: Text(
          _error!,
          style: AppTextStyles.bodyMedium.copyWith(color: AppColors.danger),
          textAlign: TextAlign.center,
        ),
      );
    }
    if (_visits.isEmpty) {
      final l10n = AppLocalizations.of(context)!;
      return Center(
        child: Text(
          l10n.visitsEmpty,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: _visits.length,
      separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.md),
      itemBuilder: (context, index) => VisitCard(visit: _visits[index]),
    );
  }

  void _onNewVisit() {
    context.push('/visits/new');
  }

  Widget _buildBottomNav(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AppNavBar(
      visitsLabel: l10n.navVisits,
      planningLabel: l10n.navPlanning,
      selectedIndex: 0,
      onTap: (index) {
        if (index == 1) {}
      },
    );
  }
}
