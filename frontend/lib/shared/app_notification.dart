import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_spacing.dart';
import 'package:frontend/core/constants/app_text_styles.dart';

enum AppNotificationType { success, error, info }

class AppNotificationMessage extends StatelessWidget {
  const AppNotificationMessage({
    super.key,
    required this.message,
    this.type = AppNotificationType.info,
  });

  final String message;
  final AppNotificationType type;

  static Color _backgroundColor(AppNotificationType notificationType) {
    switch (notificationType) {
      case AppNotificationType.success:
        return AppColors.success;
      case AppNotificationType.error:
        return AppColors.danger;
      case AppNotificationType.info:
        return AppColors.primaryBlueAlt;
    }
  }

  static IconData _icon(AppNotificationType notificationType) {
    switch (notificationType) {
      case AppNotificationType.success:
        return Icons.check_circle_outline;
      case AppNotificationType.error:
        return Icons.error_outline;
      case AppNotificationType.info:
        return Icons.info_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = _backgroundColor(type);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.falseBlack.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_icon(type), color: AppColors.surface, size: 22),
          const SizedBox(width: AppSpacing.sm),
          Flexible(
            child: Text(
              message,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.surface,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void showAppNotification(
  BuildContext context, {
  required String message,
  AppNotificationType type = AppNotificationType.info,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: AppNotificationMessage(message: message, type: type),
      backgroundColor: Colors.transparent,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(AppSpacing.md),
    ),
  );
}
