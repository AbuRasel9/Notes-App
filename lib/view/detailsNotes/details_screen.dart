import 'package:bloc_clean_architecture/config/extensions/context_ext.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen(
      {super.key,
      required this.title,
      required this.content,
      t,
      this.createdAt,
      this.updatedAt});

  final String title;
  final String content;
  final String? createdAt;
  final String? updatedAt;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Details Note"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Title",
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.title,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "Description",
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.content,
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
