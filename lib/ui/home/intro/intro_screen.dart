import 'package:event_planning/ui/home/intro/intro_settings_page.dart';
import 'package:event_planning/ui/home/intro/intro_content_page.dart';
import 'package:event_planning/utils/app_routes.dart';
import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import 'intro_content_page.dart';
import 'intro_settings_page.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      //  الصفحة التفاعلية الأولى
      IntroSettingsPage(
        onNext: () {
          _controller.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
      ),

      //  باقي صفحات المحتوى
      IntroContentPage(
        image: 'assets/images/intro2.png.png',
        title: AppLocalizations.of(context)!.intro1Title,
        description: AppLocalizations.of(context)!.intro1Description,
      ),
      IntroContentPage(
        image: 'assets/images/intro3.png.png',
        title: AppLocalizations.of(context)!.intro2Title,
        description: AppLocalizations.of(context)!.intro2Description,
      ),
      IntroContentPage(
        image: 'assets/images/intro4.png.png',
        title: AppLocalizations.of(context)!.intro3Title,
        description: AppLocalizations.of(context)!.intro3Description,
      ),

    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),
            Image.asset('assets/images/evently_logo_intro.png', height: 40),
            const SizedBox(height: 16),

            //  PageView
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: pages.length,
                itemBuilder: (_, index) => pages[index],
                onPageChanged: (index) => setState(() => _currentIndex = index),
              ),
            ),

            //  مؤشر الصفحات (Dots)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                    (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  width: _currentIndex == index ? 20 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentIndex == index ? Colors.indigo : Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            //  أزرار التنقل
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    if (_currentIndex > 0) {
                      _controller.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_currentIndex < pages.length - 1) {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      Navigator.pushReplacementNamed(context, AppRoutes.loginRouteName);
                    }
                  },
                  child: Text(
                    _currentIndex == pages.length - 1
                        ? AppLocalizations.of(context)!.letsStart
                        : AppLocalizations.of(context)!.next,
                  ),
                ),

              ],
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
