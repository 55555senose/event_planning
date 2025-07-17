import 'package:event_planning/l10n/app_localizations.dart';
import 'package:event_planning/providers/app_language_provider.dart';
import 'package:event_planning/utils/app_assets.dart';
import 'package:event_planning/utils/app_colors.dart';
import 'package:event_planning/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final lang = Provider.of<AppLanguageProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.scaffoldLight,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: AppColors.blackColor),
        title: Text(t.register, style: AppStyles.bold20Black),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              Image.asset(AppAssets.logo, height: 100),
              const SizedBox(height: 8),
              Text("Evently", style: AppStyles.bold24Primary),
              const SizedBox(height: 32),

              /// 🔹 Name Field
              _buildInputField(
                context,
                hint: t.name,
                icon: Icons.person_outline,
              ),

              const SizedBox(height: 16),

              /// 🔹 Email Field
              _buildInputField(
                context,
                hint: t.email,
                icon: Icons.email_outlined,
              ),

              const SizedBox(height: 16),

              /// 🔹 Password Field
              _buildInputField(
                context,
                hint: t.password,
                icon: Icons.lock_outline,
                obscure: true,
                suffix: const Icon(Icons.visibility_off),
              ),

              const SizedBox(height: 16),

              /// 🔹 Re-Password Field
              _buildInputField(
                context,
                hint: t.rePassword,
                icon: Icons.lock_outline,
                obscure: true,
                suffix: const Icon(Icons.visibility_off),
              ),

              const SizedBox(height: 24),

              /// 🔹 Create Account Button
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryLight,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Center(
                  child: Text(t.createAccount, style: AppStyles.bold16White),
                ),
              ),

              const SizedBox(height: 16),

              /// 🔹 Login Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(t.alreadyHaveAccount, style: AppStyles.medium14Grey),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      t.login,
                      style: AppStyles.medium14PrimaryUnderline,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              /// 🔹 Language Flags
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
        required String hint,
        required IconData icon,
        bool obscure = false,
        Widget? suffix,
      }) {
    return TextField(
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
