import 'package:event_planning/utils/app_colors.dart';
import 'package:event_planning/utils/app_styles.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final DateTime date;
  final bool isSaved;
  final VoidCallback onToggleFavorite; // ✅ بقت required مش nullable

  const EventCard({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.date,
    required this.isSaved,
    required this.onToggleFavorite, // ✅
  });

  @override
  Widget build(BuildContext context) {
    final day = date.day;
    final month = _monthString(date.month);

    final onBackground = Theme.of(context).colorScheme.onBackground;
    final onSurfaceVariant = Theme.of(context).colorScheme.onSurfaceVariant;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          if (Theme.of(context).brightness == Brightness.light)
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Column(
        children: [
          /// 🔹 Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(imagePath, height: 160, width: double.infinity, fit: BoxFit.cover),
          ),

          /// 🔹 Date + Title + Heart
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                /// Date Box
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.primaryLight.withOpacity(0.1),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        day.toString(),
                        style: AppStyles.bold16.copyWith(color: onBackground),
                      ),
                      Text(
                        month,
                        style: AppStyles.medium14.copyWith(color: onSurfaceVariant),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                /// Title + Description
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppStyles.bold16.copyWith(color: onBackground),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: AppStyles.medium14.copyWith(color: onSurfaceVariant),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                /// Heart
                GestureDetector(
                  onTap: onToggleFavorite, // ✅ شغالة دلوقتي
                  child: Icon(
                    isSaved ? Icons.favorite : Icons.favorite_border,
                    color: isSaved ? AppColors.redColor : AppColors.greyColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _monthString(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }
}
