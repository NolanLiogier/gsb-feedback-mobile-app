import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_spacing.dart';
import 'package:frontend/core/constants/app_text_styles.dart';

class GsbAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GsbAppBar({
    super.key,
    required this.title,
    this.logoutLabel,
    this.onLogout,
  });

  final String title;
  final String? logoutLabel;
  final VoidCallback? onLogout;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Image.asset(
          'assets/images/logo-no-name-removebg-preview.png',
          fit: BoxFit.contain,
        ),
      ),
      title: Text(
        title,
        style: AppTextStyles.headlineSmall,
      ),
      centerTitle: true,
      actions: [
        if (onLogout != null)
          IconButton(
            icon: Icon(Icons.logout, color: AppColors.falseBlack),
            onPressed: onLogout,
            tooltip: logoutLabel,
          ),
      ],
    );
  }
}
