import 'package:event_planning/l10n/app_localizations.dart';
import 'package:event_planning/models/event_model.dart';
import 'package:event_planning/providers/app_language_provider.dart';
import 'package:event_planning/providers/app_theme_provider.dart';
import 'package:event_planning/ui/home/widgets/event_card.dart';
import 'package:event_planning/utils/app_colors.dart';
import 'package:event_planning/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  final List<EventModel> events;
  final Function(EventModel event) onToggleFavorite;

  const HomeTab({
    super.key,
    required this.events,
    required this.onToggleFavorite,
  });

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String selectedCategory = 'all';

  final List<Map<String, dynamic>> _categories = [
    {'key': 'all', 'icon': Icons.filter_list},
    {'key': 'sport', 'icon': Icons.directions_bike},
    {'key': 'birthday', 'icon': Icons.cake},
    {'key': 'meeting', 'icon': Icons.business_center},
    {'key': 'exhibition', 'icon': Icons.museum},
  ];

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    final filteredEvents = selectedCategory == 'all'
        ? widget.events
        : widget.events
              .where(
                (e) => e.type.toLowerCase() == selectedCategory.toLowerCase(),
              )
              .toList();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          /// 🔹 Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 48, 16, 24),
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.primaryDark
                  : AppColors.primaryLight,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(24),
              ),
            ),
            child: _buildHeader(context),
          ),

          const SizedBox(height: 16),

          /// 🔹 Categories
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final category = _categories[index];
                final key = category['key'];
                final icon = category['icon'];
                final isSelected = selectedCategory == key;
                final label = key;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = key;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primaryLight
                          : Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.primaryLight),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          icon,
                          size: 18,
                          color: isSelected
                              ? Colors.white
                              : AppColors.primaryLight,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          {
                                'all': t.all,
                                'sport': t.sport,
                                'birthday': t.birthday,
                                'meeting': t.meeting,
                                'exhibition': t.exhibition,
                              }[label.toLowerCase()] ??
                              label,
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : AppColors.primaryLight,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          /// 🔹 Event List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filteredEvents.length,
              itemBuilder: (context, index) {
                final event = filteredEvents[index];
                return EventCard(
                  title: event.title,
                  description: event.description,
                  imagePath: event.imagePath,
                  date: event.date,
                  isSaved: event.isSaved,
                  onToggleFavorite: () => widget.onToggleFavorite(event),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final langProvider = Provider.of<AppLanguageProvider>(context);
    final themeProvider = Provider.of<AppThemeProvider>(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${t.welcomeBack} ✨", style: AppStyles.bold16White),
              const SizedBox(height: 4),
              Text("ENG SENOSI", style: AppStyles.bold20White),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 18,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 4),
                  Text("Cairo, Egypt", style: AppStyles.medium14White),
                ],
              ),
            ],
          ),
        ),

        /// Theme Toggle
        IconButton(
          onPressed: () => themeProvider.toggleTheme(),
          icon: Icon(
            themeProvider.appTheme == ThemeMode.dark
                ? Icons.dark_mode
                : Icons.wb_sunny_outlined,
            color: Colors.white,
          ),
        ),

        /// Language Toggle
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(8),
          ),
          child: GestureDetector(
            onTap: () {
              langProvider.changeLanguage(
                langProvider.appLanguage == 'en' ? 'ar' : 'en',
              );
            },
            child: Text(
              langProvider.appLanguage.toUpperCase(),
              style: AppStyles.medium14White,
            ),
          ),
        ),
      ],
    );
  }
}
