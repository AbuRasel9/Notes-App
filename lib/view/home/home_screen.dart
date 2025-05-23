import 'package:bloc_clean_architecture/bloc/auth/auth_bloc.dart';
import 'package:bloc_clean_architecture/bloc/auth/auth_event.dart';
import 'package:bloc_clean_architecture/bloc/auth/auth_state.dart';
import 'package:bloc_clean_architecture/config/routes/route_name.dart';
import 'package:bloc_clean_architecture/config/routes/routes.dart';
import 'package:bloc_clean_architecture/utils/enum/font_option.dart';
import 'package:bloc_clean_architecture/view/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../provider/notesProvider/notes_provider.dart';
import '../addNotes/add_notes_screen.dart';
import '../detailsNotes/details_screen.dart';
import 'package:intl/intl.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  Future<void> _deleteNote(
      String noteId, BuildContext context, WidgetRef ref) async {
    try {
      final noteService = ref.read(noteServiceProvider);
      await noteService.deleteNote(noteId);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Note moved to trash'),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.all(10),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error deleting note: $e'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.all(10),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notesAsync = ref.watch(notesStreamProvider);
    final colors = [
      Colors.blue.shade100,
      Colors.green.shade100,
      Colors.purple.shade100,
      Colors.orange.shade100,
      Colors.pink.shade100,
    ];

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('My Notes',
            style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          BlocListener<AuthBloc, AuthState>(
            listenWhen: (previous, current) =>
                previous.apiStatus != current.apiStatus,
            listener: (context, state) {
              if (state.apiStatus == ApiStatus.logout) {

                context.go(RoutesName.loginScreen);
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Logout Successfull")));
              } else if(state.apiStatus==ApiStatus.error) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Logout Successfull")));
              }
            },
            child:
                context.watch<AuthBloc>().state.apiStatus == ApiStatus.loading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : IconButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(LogoutEvent());
                        },
                        icon: const Icon(
                          Icons.logout,
                        ),
                      ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AddNoteScreen()),
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Iconsax.add),
      ),
      body: notesAsync.when(
        loading: () => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
              ),
              const SizedBox(height: 16),
              Text(
                'Loading your thoughts...',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Iconsax.warning_2, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                'Something went wrong',
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  error.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ),
            ],
          ),
        ),
        data: (snapshot) {
          if (snapshot.docs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/empty_notes.png',
                    // Add your own empty state illustration
                    height: 200,
                    color: Colors.grey.shade300,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'No notes yet',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap the + button to create your first note',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
              itemCount: snapshot.docs.length,
              itemBuilder: (context, index) {
                final note = snapshot.docs[index];
                final data = note.data();
                final createdAt = (data['createdAt'] as Timestamp).toDate();
                final updatedAt = (data['updatedAt'] as Timestamp?)?.toDate();
                final colorIndex = index % colors.length;
                final cardColor = colors[colorIndex];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(
                          title: data['title'],
                          content: data['content'],
                          createdAt:
                              createdAt.toLocal().toString().split('.')[0],
                          updatedAt:
                              updatedAt?.toLocal().toString().split('.')[0],
                        ),
                      ),
                    );
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data['title'] ?? 'No title',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 1,
                          ),
                          const SizedBox(height: 8),
                          Expanded(
                            child: Text(
                              data['content'] ?? 'No content',
                              style: TextStyle(
                                color: Colors.grey.shade800,
                                fontSize: 14,
                              ),
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  updatedAt != null
                                      ? 'Updated: ${_formatDate(updatedAt)}'
                                      : 'Created: ${_formatDate(createdAt)}',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ),
                              PopupMenuButton(
                                icon: Icon(Iconsax.more,
                                    color: Colors.grey.shade700, size: 20),
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    child: const Row(
                                      children: [
                                        Icon(Iconsax.edit, size: 18),
                                        SizedBox(width: 8),
                                        Text('Edit'),
                                      ],
                                    ),
                                    onTap: () => Future(() {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => AddNoteScreen(
                                            isEdit: true,
                                            noteId: note.id,
                                            initialTitle: data['title'],
                                            initialContent: data['content'],
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                  PopupMenuItem(
                                    child: const Row(
                                      children: [
                                        Icon(Iconsax.trash,
                                            size: 18, color: Colors.red),
                                        SizedBox(width: 8),
                                        Text('Delete',
                                            style:
                                                TextStyle(color: Colors.red)),
                                      ],
                                    ),
                                    onTap: () => Future(() =>
                                        _deleteNote(note.id, context, ref)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final dateToCheck = DateTime(date.year, date.month, date.day);

    if (dateToCheck == today) {
      return 'Today, ${DateFormat.format(date, "yyyy-MMM-dd")}';
    } else if (dateToCheck == yesterday) {
      return 'Yesterday, ${DateFormat.format(date, "yyyy-MMM-dd")}';
    } else {
      return DateFormat.format(date, "yyyy-MMM-dd");
    }
  }
}

class DateFormat {
  static String format(DateTime date, String format) {
    // Implement your date formatting logic here
    // For simplicity, using basic formatting
    return '${date.day}/${date.month}/${date.year}';
  }
}
