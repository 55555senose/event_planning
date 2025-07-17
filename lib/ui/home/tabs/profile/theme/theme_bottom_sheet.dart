import 'package:event_planning/l10n/app_localizations.dart';
import 'package:event_planning/providers/app_theme_provider.dart';
import 'package:event_planning/utils/app_colors.dart';
import 'package:event_planning/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeBottomSheet extends StatelessWidget {
  const ThemeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final themeProvider = Provider.of<AppThemeProvider>(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.02,
        vertical: height * 0.02,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Light Theme
          InkWell(
            onTap: () {
              themeProvider.changeTheme('light');
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.light,
                  style: AppStyles.bold20Primary,
                ),
                themeProvider.appTheme == ThemeMode.light
                    ? const Icon(Icons.check,
                    color: AppColors.primaryLight, size: 30)
                    : const SizedBox(width: 30),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Dark Theme
          InkWell(
            onTap: () {
              //themeProvider.setTheme(ThemeMode.dark);
              themeProvider.changeTheme('dark');

            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.dark,
                  style: AppStyles.bold20Black,
                ),
                themeProvider.appTheme == ThemeMode.dark
                    ? const Icon(Icons.check,
                    color: AppColors.primaryLight, size: 30)
                    : const SizedBox(width: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
