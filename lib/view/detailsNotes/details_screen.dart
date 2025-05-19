import 'package:bloc_clean_architecture/config/extensions/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../addNotes/add_notes_screen.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    super.key,

    required this.title,
    required this.content,
    this.createdAt,
    this.updatedAt, this.id,
  });

  final String title;
  final String? id;
  final String content;
  final String? createdAt;
  final String? updatedAt;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool _isFavorite = false;
//date format
  String formatDate(String? dateString) {
    if (dateString == null) return 'No date';
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('MMM dd, yyyy').format(date);
    } catch (e) {
      return dateString;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isDarkMode = theme.brightness == Brightness.dark;
    final cardColor = isDarkMode
        ? Colors.grey.shade800.withOpacity(0.8)
        : Colors.white.withOpacity(0.9);

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Note Details"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? Colors.red : null,
            ),
            onPressed: () {
              setState(() {
                _isFavorite = !_isFavorite;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with date information
            const SizedBox(height: 24),

            // Note content card
            Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isDarkMode
                        ? Colors.grey.shade700
                        : Colors.grey.shade300,
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (widget.createdAt != null)
                          Expanded(
                            child: Text(
                              'Created: ${formatDate(widget.createdAt)}',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ),
                        if (widget.updatedAt != null)
                          Expanded(
                            child: Text(
                              'Updated: ${formatDate(widget.updatedAt)}',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    // Title with decorative underline
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: isDarkMode
                                ? Colors.white
                                : Colors.grey.shade800,
                          ),
                        ),
                        Container(
                          height: 4,
                          width: 60,
                          margin: const EdgeInsets.only(top: 8, bottom: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: theme.colorScheme.primary.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Content
                    Text(
                      widget.content,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        height: 1.6,
                        color: isDarkMode
                            ? Colors.grey.shade300
                            : Colors.grey.shade700,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Tags (example - you could make this dynamic)
                    Wrap(
                      spacing: 8,
                      children: [
                        Chip(
                          label:
                              const Text('Personal', style: TextStyle(fontSize: 12)),
                          backgroundColor: Colors.blue.shade100,
                        ),
                        Chip(
                          label: const Text('Ideas', style: TextStyle(fontSize: 12)),
                          backgroundColor: Colors.green.shade100,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Action buttons
            Center(
              child: Wrap(
                spacing: 16,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.delete, size: 18),
                    label: const Text('Delete'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.error,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              AddNoteScreen(
                                isEdit: true,
                                noteId: widget.id,
                                initialTitle: widget.title,
                                initialContent: widget.content,
                              ),
                        ),
                      );
                    },
                  ),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.share, size: 18),
                    label: const Text('Share'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      // Share functionality
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
