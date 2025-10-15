import 'package:flutter/material.dart';
import 'package:event_planning/l10n/app_localizations.dart';
import 'package:event_planning/ui/home/tabs/home/home_tab.dart';
import 'package:event_planning/ui/home/tabs/profile/profile_tab.dart';
import 'package:event_planning/ui/home/widgets/event_card.dart';
import 'package:event_planning/utils/app_colors.dart';
import 'package:event_planning/utils/app_styles.dart';
import 'add_event_page.dart';
import 'package:event_planning/models/event_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<EventModel> _savedEvents = [];

  void _toggleFavorite(EventModel event) {
    setState(() {
    });
  }

  @override
Widget build(BuildContext context) {
  final t = AppLocalizations.of(context)!;

  final List<EventModel> events = [
    EventModel(
      title: t.birthday,
      description: t.desc_birthday,
      imagePath: 'assets/images/birthday.png',
      date: DateTime(2023, 11, 21),
      type: 'Birthday',
      isSaved: _savedEvents.any((e) => e.title == t.birthday), id: '', ownerId: '',
    ),
    EventModel(
      title: t.meeting,
      description: t.desc_meeting,
      imagePath: 'assets/images/meeting.png',
      date: DateTime(2023, 11, 22),
      type: 'Meeting',
      isSaved: _savedEvents.any((e) => e.title == t.meeting), id: '', ownerId: '',
    ),
    EventModel(
      title: t.exhibition,
      description: t.desc_exhibition,
      imagePath: 'assets/images/exhibition.png',
      date: DateTime(2023, 11, 23),
      type: 'Exhibition',
      isSaved: _savedEvents.any((e) => e.title == t.exhibition), id: '', ownerId: '',
    ),
    EventModel(
      title: t.sport,
      description: t.desc_sport,
      imagePath: 'assets/images/sport.png',
      date: DateTime(2025, 8, 24),
      type: 'Sport',
      isSaved: _savedEvents.any((e) => e.title == t.sport), id: '', ownerId: '',
    ),
  ];


    final List<Widget> _pages = [
HomeTab(onToggleFavorite: _toggleFavorite),
      Center(
        child: Text(
          t.map,
          style: AppStyles.bold20.copyWith(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ),
      ListView(
        padding: const EdgeInsets.all(16),
        children: events
            .where((event) => event.isSaved)
            .map(
              (event) => EventCard(
                title: event.title,
                description: event.description,
                imagePath: event.imagePath,
                date: event.date,
                isSaved: true,
                onToggleFavorite: () => _toggleFavorite(event),
                  eventId: event.id,

              ),
            )
            .toList(),
      ),
      const ProfileTab(),
    ];

    return Scaffold(
      body: _pages[_currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newEvent = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddEventPage()),
          );
          if (newEvent != null && newEvent is EventModel) {
            setState(() {
              _savedEvents.add(newEvent);
            });
          }
        },
        backgroundColor: Colors.white,
        elevation: 4,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.blue, size: 32),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        color: AppColors.primaryLight,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(Icons.home_outlined, t.home, 0),
              _navItem(Icons.map_outlined, t.map, 1),
              const SizedBox(width: 40),
              _navItem(Icons.favorite, t.love, 2),
              _navItem(Icons.person_outline, t.profile, 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, int index) {
    final isSelected = _currentIndex == index;

    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
