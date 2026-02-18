import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';

abstract final class AppTextStyles {
  AppTextStyles._();

  static const TextStyle displayLarge = TextStyle(
    color: AppColors.falseBlack,
    fontSize: 32,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle displayMedium = TextStyle(
    color: AppColors.falseBlack,
    fontSize: 28,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle headlineLarge = TextStyle(
    color: AppColors.falseBlack,
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle headlineMedium = TextStyle(
    color: AppColors.falseBlack,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle headlineSmall = TextStyle(
    color: AppColors.falseBlack,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle titleLarge = TextStyle(
    color: AppColors.falseBlack,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle titleMedium = TextStyle(
    color: AppColors.falseBlack,
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle titleSmall = TextStyle(
    color: AppColors.falseBlack,
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle bodyLarge = TextStyle(
    color: AppColors.falseBlack,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle bodyMedium = TextStyle(
    color: AppColors.falseBlack,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle bodySmall = TextStyle(
    color: AppColors.falseBlack,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle labelLarge = TextStyle(
    color: AppColors.textSecondary,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle labelMedium = TextStyle(
    color: AppColors.textSecondary,
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle labelSmall = TextStyle(
    color: AppColors.textSecondary,
    fontSize: 10,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle caption = TextStyle(
    color: AppColors.textSecondary,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle placeholder = TextStyle(
    color: AppColors.textTertiary,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle muted = TextStyle(
    color: AppColors.textMuted,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle link = TextStyle(
    color: AppColors.primaryBlue,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle linkSmall = TextStyle(
    color: AppColors.primaryBlue,
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle accentPurple = TextStyle(
    color: AppColors.accentPurpleDark,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle success = TextStyle(
    color: AppColors.success,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle danger = TextStyle(
    color: AppColors.danger,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle warning = TextStyle(
    color: AppColors.warning,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle loginFormLabel = TextStyle(
    color: AppColors.primaryBlueAlt,
    fontSize: 12,
    fontWeight: FontWeight.w700,
  );
}
