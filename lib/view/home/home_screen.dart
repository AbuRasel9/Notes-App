import 'package:bloc_clean_architecture/config/routes/route_name.dart';
import 'package:bloc_clean_architecture/config/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dummyNotes = [
      {'title': 'Meeting Notes', 'content': 'Discuss project timeline', 'date': 'Today'},
      {'title': 'Shopping List', 'content': 'Milk, Eggs, Bread', 'date': 'Yesterday'},
      {'title': 'Ideas', 'content': 'New app feature ideas', 'date': 'Mar 15'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.go('/login');
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: dummyNotes.length,
        itemBuilder: (context, index) {
          final note = dummyNotes[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              title: Text(note['title']!),
              subtitle: Text(note['content']!),
              trailing: Text(note['date']!),
              onTap: () {
                // Navigate to edit page
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(RoutesName.addNewNotes);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
