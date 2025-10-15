import 'package:event_planning/l10n/app_localizations.dart';
import 'package:event_planning/providers/app_language_provider.dart';
import 'package:event_planning/providers/app_theme_provider.dart';
import 'package:event_planning/utils/app_assets.dart';
import 'package:event_planning/utils/app_colors.dart';
import 'package:event_planning/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IntroSettingsPage extends StatelessWidget {
  final VoidCallback onNext;
  const IntroSettingsPage({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<AppLanguageProvider>(context);
    final themeProvider = Provider.of<AppThemeProvider>(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.06,
          vertical: height * 0.04,
        ),
        child: Column(
          children: [
            Image.asset(AppAssets.logo, height: 40), // لوجو التطبيق
            const SizedBox(height: 24),

            Image.asset(AppAssets.intro1, height: height * 0.3), // صورة المقدمة
            const SizedBox(height: 24),
           // Spacer(), // يأخذ كل المساحة المتاحة

            Text(
              AppLocalizations.of(context)!.personalizeExperience,
              style: AppStyles.bold24.copyWith(
                fontSize: 22,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              textAlign: TextAlign.center,
            ),

            Text(
              AppLocalizations.of(context)!.personalizeDescription,
              textAlign: TextAlign.center,
              style: AppStyles.medium16.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),

            Text(
              AppLocalizations.of(context)!.theme,
              style: AppStyles.bold16.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),

            const SizedBox(height: 32),

            /// Language & Theme Selector Combined Container
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.primaryLight, width: 2),
              ),
              child: Column(
                children: [
                  ///  Language Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.language,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Row(
                        children: [
                          _flagButton(
                            context,
                            'en',
                            '🇺🇸',
                            languageProvider.appLanguage == 'en',
                          ),
                          const SizedBox(width: 8),
                          _flagButton(
                            context,
                            'ar',
                            '🇪🇬',
                            languageProvider.appLanguage == 'ar',
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  /// Theme Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.theme,
                        style: AppStyles.bold16Primary,
                      ),
                      Row(
                        children: [
                          _themeButton(
                            context,
                            ThemeMode.light,
                            Icons.light_mode,
                            themeProvider.appTheme == ThemeMode.light,
                          ),
                          const SizedBox(width: 8),
                          _themeButton(
                            context,
                            ThemeMode.dark,
                            Icons.dark_mode,
                            themeProvider.appTheme == ThemeMode.dark,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 36),

            /// Let's Start Button
            ElevatedButton(
              onPressed: onNext,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryLight,
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.3,
                  vertical: height * 0.02,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                AppLocalizations.of(context)!.letsStart,
                style: AppStyles.bold20White,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _flagButton(
    BuildContext context,
    String code,
    String emoji,
    bool isSelected,
  ) {
    final languageProvider = Provider.of<AppLanguageProvider>(
      context,
      listen: false,
    );
    return GestureDetector(
      onTap: () => languageProvider.changeLanguage(code),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryLight : Colors.grey[200],
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(emoji, style: const TextStyle(fontSize: 20)),
      ),
    );
  }

  Widget _themeButton(
    BuildContext context,
    ThemeMode mode,
    IconData icon,
    bool isSelected,
  ) {
    final themeProvider = Provider.of<AppThemeProvider>(context, listen: false);
    return GestureDetector(
      onTap: () => themeProvider.changeTheme(mode.name),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryLight : Colors.grey[200],
          borderRadius: BorderRadius.circular(30),
        ),
        child: Icon(icon, color: const Color.fromARGB(255, 52, 50, 50)),
      ),
    );
  }
}
