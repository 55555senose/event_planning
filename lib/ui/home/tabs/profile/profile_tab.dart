import 'package:event_planning/l10n/app_localizations.dart';
import 'package:event_planning/ui/home/tabs/profile/theme/theme_bottom_sheet.dart';
import 'package:event_planning/utils/app_assets.dart';
import 'package:event_planning/utils/app_colors.dart';
import 'package:event_planning/utils/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/app_language_provider.dart';
import '../../../../providers/app_theme_provider.dart';
import 'language/language_bottom_sheet.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryLight,
        toolbarHeight: height * 0.18,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(65),
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(bottom: height * 0.01),
          child: Row(
            children: [
              Image.asset(AppAssets.routeImage),
              SizedBox(width: width * 0.04), // بديل نظيف لـ Padding فاضية
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Eng Senosi',
                    style: AppStyles.bold24White,
                  ),
                  Text(
                    '55555senose@gmail.com',
                    style: AppStyles.medium16White,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      body:Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width*0.04,
          vertical: height*0.04,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
              Text(AppLocalizations.of(context)!.language,
              style: Theme.of(context).textTheme.headlineLarge,
              ),
            //Text('Language',
            //style: Theme.of(context).textTheme.headlineLarge,
           //),
            Container(
              margin: EdgeInsets.symmetric(
                //horizontal: width*0.02,
                vertical: height*0.02,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: width*0.02,
                vertical: height*0.02,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.primaryLight,
                  width: 2
                )
              ),
                child: InkWell(
                  onTap: () {
                    _showLanguageBottomSheet(); },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(languageProvider.appLanguage == 'en'?
                    AppLocalizations.of(context)!.english:
                    AppLocalizations.of(context)!.arabic,
                  style: AppStyles.bold20Primary,
                  ),
                  Icon(Icons.arrow_drop_down_outlined,size: 35,
                  color: AppColors.primaryLight,
                  ),
                ],
              ),
            ),
          ),

            SizedBox(
              height: height*0.02,),

            Text(AppLocalizations.of(context)!.theme,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Container(
                margin: EdgeInsets.symmetric(
                  //horizontal: width*0.02,
                  vertical: height*0.02,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: width*0.02,
                  vertical: height*0.02,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                        color: AppColors.primaryLight,
                        width: 2
                    )
                ),
                child:InkWell(
                  onTap: (){
                    showThemeBottomSheet();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        themeProvider.appTheme == ThemeMode.light
                            ? AppLocalizations.of(context)!.light
                            : AppLocalizations.of(context)!.dark,
                        style: AppStyles.bold20Primary,
                      ),
                      Icon(Icons.arrow_drop_down_outlined,size: 35,
                        color: AppColors.primaryLight,
                      ),
                    ],
                  ),
                ),
            ),
            Spacer(),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.redColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: height*0.02,
                    horizontal: width*0.02,
                  )
                ),
                onPressed: (){
            },
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,color: AppColors.whiteColor,size: 30,),
                    SizedBox(width:width*0.02,),
                    Text(AppLocalizations.of(context)!.logout,
                    style: AppStyles.regular20White,
                    ),
                  ],
                ) )
          ],
        ),
      ),
    );
  }

  void _showLanguageBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => const LanguageBottomSheet(),
    );
  }
  void showThemeBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => const ThemeBottomSheet(),
    );
  }
}
