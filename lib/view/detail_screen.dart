import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';

@RoutePage()
class DetailScreen extends StatelessWidget {
  final String title;
  final String description;
  final double lat;
  final double long;

  const DetailScreen({
    super.key,
    required this.title,
    required this.description,
    required this.lat,
    required this.long,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('info'.tr()),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red),
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 12),
            Text(
              '${'location'.tr()}: (${'latitude'.tr()}: $lat, ${'longitude'.tr()}: $long)',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
