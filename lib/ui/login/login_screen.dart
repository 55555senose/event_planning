import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:event_planning/l10n/app_localizations.dart';
import 'package:event_planning/providers/app_theme_provider.dart';
import 'package:event_planning/utils/app_colors.dart';
import 'package:event_planning/utils/app_styles.dart';
import 'package:event_planning/utils/app_assets.dart';
import 'package:event_planning/services/auth_service.dart';

import '../../providers/app_language_provider.dart';
import '../../utils/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final AuthService _authService = AuthService();
  bool _loading = false;

  void _login() async {
    final t = AppLocalizations.of(context)!;

    setState(() => _loading = true);
    try {
      await _authService.loginWithEmail(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      _showSnackBar(t.loginSuccess);

      // Navigate to home screen
      Navigator.pushReplacementNamed(context, AppRoutes.homeRouteName);
    } catch (e) {
      _showSnackBar(e.toString());
    } finally {
      setState(() => _loading = false);
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final themeProvider = Provider.of<AppThemeProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.scaffoldLight,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              Center(
                child: Column(
                  children: [
                    Image.asset(AppAssets.logo, height: 100),
                    const SizedBox(height: 8),
                    //Text("Evently", style: AppStyles.bold24Primary),
                  ],
                ),
              ),
              const SizedBox(height: 48),

              /// Email Field
              _buildInputField(
                context,
                controller: _emailController,
                icon: Icons.email_outlined,
                hint: t.email,
              ),

              const SizedBox(height: 16),

              /// Password Field
              _buildInputField(
                context,
                controller: _passwordController,
                icon: Icons.lock_outline,
                hint: t.password,
                obscure: true,
                suffix: const Icon(Icons.visibility_off),
              ),

              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.forgetPasswordRouteName);
                  },
                  child: Text(
                    t.forgetPassword,
                    style: AppStyles.medium14Primary.copyWith(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),

              ElevatedButton(
                onPressed: _loading ? null : _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryLight,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(t.login, style: AppStyles.bold16White),
              ),

              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(t.dontHaveAccount, style: AppStyles.medium14Grey),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.registerRouteName);
                    },
                    child: Text(
                      t.createAccount,
                      style: AppStyles.medium14Primary.copyWith(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  )
                ],
              ),

              const SizedBox(height: 8),
              Row(
                children: const [
                  Expanded(child: Divider(thickness: 1)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text("or"),
                  ),
                  Expanded(child: Divider(thickness: 1)),
                ],
              ),

              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () {
                  // TODO: ربط Google Sign-In هنا لاحقًا
                },
                icon: Image.asset(AppAssets.googleIcon, height: 24),
                label: Text(t.loginWithGoogle, style: AppStyles.medium16Primary),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.primaryDark),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),

              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _flagButton(context, 'en', '🇺🇸'),
                  const SizedBox(width: 12),
                  _flagButton(context, 'ar', '🇪🇬'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(
    BuildContext context, {
    required TextEditingController controller,
    required IconData icon,
    required String hint,
    bool obscure = false,
    Widget? suffix,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon),
        suffixIcon: suffix,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget _flagButton(BuildContext context, String code, String emoji) {
    final lang = Provider.of<AppLanguageProvider>(context);
    return GestureDetector(
      onTap: () => lang.changeLanguage(code),
      child: CircleAvatar(
        radius: 16,
        child: Text(emoji, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
