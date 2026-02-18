import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_spacing.dart';
import 'package:frontend/core/constants/app_text_styles.dart';
import 'package:frontend/features/visits/domain/visit.dart';

class VisitCard extends StatelessWidget {
  const VisitCard({super.key, required this.visit});

  final Visit visit;

  static String _formatDisplayDate(Visit visit) {
    final dateString = visit.closureDate ?? visit.scheduledDate;
    try {
      final parsedDate = DateTime.parse(dateString);
      return DateFormat('d MMMM yyyy', 'fr_FR').format(parsedDate);
    } catch (_) {
      return dateString;
    }
  }

  static Color _statusBackground(String statusName) {
    final statusLower = statusName.toLowerCase();
    if (statusLower.contains('planifi') || statusLower.contains('attente')) {
      return AppColors.accentPurple;
    }
    if (statusLower.contains('cours') || statusLower.contains('valid')) {
      return AppColors.primaryBlue;
    }
    return AppColors.border;
  }

  static Color _statusForeground(String statusName) {
    final statusLower = statusName.toLowerCase();
    if (statusLower.contains('planifi') || statusLower.contains('attente')) {
      return AppColors.surface;
    }
    if (statusLower.contains('cours') || statusLower.contains('valid')) {
      return AppColors.surface;
    }
    return AppColors.falseBlack;
  }

  @override
  Widget build(BuildContext context) {
    final displayDate = _formatDisplayDate(visit);
    final statusBackground = _statusBackground(visit.statusName);
    final statusForeground = _statusForeground(visit.statusName);
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  visit.companyName.toUpperCase(),
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  visit.visitTitle,
                  style: AppTextStyles.titleLarge,
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 16,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      displayDate,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                if (visit.comment != null && visit.comment!.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.description_outlined,
                        size: 16,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Expanded(
                        child: Text(
                          visit.comment!,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: statusBackground,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              visit.statusName.toUpperCase(),
              style: AppTextStyles.labelSmall.copyWith(
                color: statusForeground,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
