import 'package:flutter/material.dart';

class ResultCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback onTap;

  const ResultCard({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isCountry = item['type'] == 'country';
    final String title = item['name'] ?? '';
    final String subtitle = isCountry
        ? 'Country • ${item['code'] ?? ''}'
        : 'City • ${item['country_name'] ?? ''}';
    final String emoji = item['emoji'] ?? item['country_emoji'] ?? '📍';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: Text(
          emoji,
          style: const TextStyle(fontSize: 24),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Text(subtitle),
        trailing: Icon(
          isCountry ? Icons.public : Icons.location_city,
          color: Colors.blue,
        ),
        onTap: onTap,
      ),
    );
  }
}
