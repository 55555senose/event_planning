import 'package:event_planning/l10n/app_localizations.dart';
import 'package:event_planning/providers/app_language_provider.dart';
import 'package:event_planning/utils/app_colors.dart';
import 'package:event_planning/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var languageProvider = Provider.of<AppLanguageProvider>(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.02,
        vertical: height * 0.02,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // English
          InkWell(
            onTap: () {
              languageProvider.changeLanguage('en');
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.english,
                  style: AppStyles.bold20Primary,
                ),
                languageProvider.appLanguage == 'en'
                    ? const Icon(
                  Icons.check,
                  color: AppColors.primaryLight,
                  size: 30,
                )
                    : const SizedBox(width: 30), // space placeholder
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Arabic
          InkWell(
            onTap: () {
              languageProvider.changeLanguage('ar');
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.arabic,
                  style: AppStyles.bold20Black,
                ),
                languageProvider.appLanguage == 'ar'
                    ? const Icon(
                  Icons.check,
                  color: AppColors.primaryLight,
                  size: 30,
                )
                    : const SizedBox(width: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
