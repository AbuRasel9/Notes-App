import 'package:bloc_clean_architecture/view/detailsNotes/details_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../provider/notesProvider/notes_provider.dart';
import '../addNotes/add_notes_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  Future<void> _deleteNote(String noteId, BuildContext context,
      WidgetRef ref) async {
    try {
      final noteService = ref.read(noteServiceProvider);
      await noteService.deleteNote(noteId);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Note deleted')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error deleting note: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notesAsync = ref.watch(notesStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddNoteScreen()),
            ),
        child: const Icon(Icons.add),
      ),
      body: notesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (snapshot) {
          if (snapshot.docs.isEmpty) {
            return const Center(
              child: Text('No notes yet', style: TextStyle(fontSize: 18)),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: snapshot.docs.length,
            itemBuilder: (context, index) {
              final note = snapshot.docs[index];
              final data = note.data();
              final createdAt = (data['createdAt'] as Timestamp).toDate();
              final updatedAt = (data['updatedAt'] as Timestamp?)?.toDate();

              return InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => DetailsScreen(title: data['title'],
                      content: data['content'],
                      createdAt: createdAt.toLocal().toString().split('.')[0]
                          .toString(),
                    updatedAt: updatedAt?.toLocal()
                        .toString()
                        .split('.')[0],

                    ),));
                },
                child: Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 2,
                  child: ListTile(
                    title: Text(
                      data['title'] ?? 'No title',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(data['content'] ?? 'No content'),
                        const SizedBox(height: 8),
                        Text(
                          updatedAt != null
                              ? 'Updated: ${updatedAt.toLocal()
                              .toString()
                              .split('.')[0]}'
                              : 'Created: ${createdAt.toLocal()
                              .toString()
                              .split('.')[0]}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () =>
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      AddNoteScreen(
                                        noteId: note.id,
                                        initialTitle: data['title'],
                                        initialContent: data['content'],
                                      ),
                                ),
                              ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteNote(note.id, context, ref),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

}