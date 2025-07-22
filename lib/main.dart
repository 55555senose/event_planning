import 'package:event_planning/firebase_options.dart';
import 'package:event_planning/providers/app_language_provider.dart';
import 'package:event_planning/providers/app_theme_provider.dart';
import 'package:event_planning/ui/home/tabs/home/home_screen.dart';
import 'package:event_planning/ui/home/intro/intro_screen.dart';
import 'package:event_planning/ui/home/splash/splash_screen.dart';
import 'package:event_planning/ui/home/tabs/profile/profile_tab.dart';
import 'package:event_planning/ui/login/forget_password_screen.dart';
import 'package:event_planning/ui/login/login_screen.dart';
import 'package:event_planning/ui/login/register_screen.dart';
import 'package:event_planning/utils/app_routes.dart';
import 'package:event_planning/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
Future<void> main() async {
WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase with the default options for the current platform
 await
 Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);


  runApp(MultiProvider( 
    providers: [
      ChangeNotifierProvider(create: (context) => AppLanguageProvider()),
      ChangeNotifierProvider(create: (context) => AppThemeProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splashRouteName,
      routes: {
        AppRoutes.splashRouteName: (context) => const SplashScreen(),
        AppRoutes.introRouteName: (context) => const IntroScreen(),
        AppRoutes.loginRouteName: (context) => const LoginScreen(),
        AppRoutes.registerRouteName: (context) => const RegisterScreen(),
        AppRoutes.forgetPasswordRouteName: (context) => const ForgetPasswordScreen(),
        AppRoutes.homeRouteName: (context) => const HomeScreen(),

      },


      locale: Locale(languageProvider.appLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.appTheme,
    );
  }
}
