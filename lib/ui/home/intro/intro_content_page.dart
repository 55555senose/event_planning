import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IntroContentPage extends StatelessWidget {
  final String image, title, description;

  const IntroContentPage({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          Image.asset(image, height: 250),
          const SizedBox(height: 300),

          //Spacer(), // يأخذ كل المساحة المتاحة
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge, // يستخدم الثيم
          ),
          //  const SizedBox(height: 12),
          Text(description, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
