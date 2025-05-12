import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/routes/route_name.dart';
import '../../provider/notesProvider/notes_provider.dart';


class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notesStream = ref.watch(notesStreamProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("My Notes")),
      body: notesStream.when(
        data: (snapshot) {
          final notes = snapshot.docs;
          if (notes.isEmpty) {
            return const Center(child: Text("No notes yet"));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index].data();
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: ListTile(
                  title: Text(note['title']),
                  subtitle: Text(note['content']),
                  trailing: Text(note['date'].substring(0, 10)),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text("Error: $err")),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushNamed(RoutesName.addNewNotes),
        child: const Icon(Icons.add),
      ),
    );
  }
}
