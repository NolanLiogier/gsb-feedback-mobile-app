import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_spacing.dart';
import 'package:frontend/core/constants/app_text_styles.dart';
import 'package:frontend/core/services/api_service.dart';
import 'package:frontend/core/services/user_preferences.dart';
import 'package:frontend/shared/app_notification.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }

  Future<void> _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final l10n = AppLocalizations.of(context)!;
    if (email.isEmpty || password.isEmpty) {
      showAppNotification(
        context,
        message: l10n.loginErrorRequired,
        type: AppNotificationType.error,
      );
      return;
    }
    final result = await ApiService.login(email: email, password: password);
    if (!mounted) return;
    if (result.statusCode == 200) {
      final message = result.body?['message'] as String? ?? l10n.loginSuccessDefault;
      showAppNotification(
        context,
        message: message,
        type: AppNotificationType.success,
      );
      final data = result.body?['data'];
      if (data is Map<String, dynamic>) {
        final userId = _parseInt(data['user_id']);
        final companyId = _parseInt(data['fk_company_id']);
        final functionId = _parseInt(data['fk_function_id']);
        if (userId != null && companyId != null && functionId != null) {
          await UserPreferences.setUserSession(
            userId: userId,
            userCompanyId: companyId,
            userFunctionId: functionId,
          );
          if (!context.mounted) return;
          context.go('/visits');
        }
      }
    } else {
      final message = result.body?['message'] as String? ?? l10n.loginErrorDefault;
      showAppNotification(
        context,
        message: message,
        type: AppNotificationType.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.pageAlt,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _LoginLogo(),
                const SizedBox(height: AppSpacing.xl),
                Text(
                  l10n.loginTitle,
                  style: AppTextStyles.displayMedium,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  l10n.loginSubtitle,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                _buildLabel(l10n.loginEmailLabel),
                const SizedBox(height: AppSpacing.sm),
                _EmailField(controller: _emailController, hint: l10n.loginEmailHint),
                const SizedBox(height: AppSpacing.lg),
                _buildLabel(l10n.loginPasswordLabel),
                const SizedBox(height: AppSpacing.sm),
                _PasswordField(
                  controller: _passwordController,
                  hint: l10n.loginPasswordHint,
                  obscure: _obscurePassword,
                  onToggle: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                ),
                const SizedBox(height: AppSpacing.xl),
                _LoginButton(label: l10n.loginButton, onPressed: _handleLogin),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: AppTextStyles.loginFormLabel,
      ),
    );
  }
}

class _LoginLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo-app-removebg-preview.png',
      height: 120,
      fit: BoxFit.contain,
    );
  }
}

class _EmailField extends StatelessWidget {
  const _EmailField({required this.controller, required this.hint});

  final TextEditingController controller;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTextStyles.placeholder,
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primaryBlueAlt),
        ),
        prefixIcon: Icon(
          Icons.email_outlined,
          size: 22,
          color: AppColors.greyUi,
        ),
      ),
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField({
    required this.controller,
    required this.hint,
    required this.obscure,
    required this.onToggle,
  });

  final TextEditingController controller;
  final String hint;
  final bool obscure;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      autocorrect: false,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTextStyles.placeholder,
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primaryBlueAlt),
        ),
        prefixIcon: Icon(
          Icons.lock_outline,
          size: 22,
          color: AppColors.greyUi,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
            size: 22,
            color: AppColors.greyUi,
          ),
          onPressed: onToggle,
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primaryBlueAlt,
          foregroundColor: AppColors.surface,
          elevation: 2,
          shadowColor: AppColors.falseBlack.withOpacity(0.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: AppTextStyles.titleMedium.copyWith(
                color: AppColors.surface,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            const Icon(Icons.arrow_forward, size: 20),
          ],
        ),
      ),
    );
  }
}
