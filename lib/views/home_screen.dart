import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notesapp/controller/note_controller.dart';
import 'package:notesapp/models/get_all_notes_model.dart';

import 'package:notesapp/views/constants/colors/colors.dart';
import 'package:notesapp/views/constants/widgets/card.dart';
import 'package:notesapp/views/constants/widgets/text.dart';
import 'package:notesapp/gen/assets.gen.dart';
import 'package:notesapp/views/settings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NoteController _noteController = NoteController();
  List<Note> _notes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    try {
      print('Loading notes...');
      final notes = await _noteController.getNotes();
      print('Received notes: $notes');
      setState(() {
        _notes = notes;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading notes: $e');
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading notes: $e')),
      );
    }
  }

  Widget _buildNotesList() {
    return GridView.builder(
      padding: EdgeInsets.all(16.w),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10.w,
        mainAxisSpacing: 10.h,
        // Increase height by adjusting the aspect ratio
        childAspectRatio: 0.7, // Decrease this number to increase height
      ),
      itemCount: _notes.length,
      itemBuilder: (context, index) {
        final note = _notes[index];
        // Format the date as dd/mm
        String formattedDate =
            "${note.createdAt.day.toString().padLeft(2, '0')}/${note.createdAt.month.toString().padLeft(2, '0')}";

        return Container(
          decoration: BoxDecoration(
            color: blackBg2,
            borderRadius: BorderRadius.circular(15.r),
          ),
          padding: EdgeInsets.all(12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Main content area
              Expanded(
                child: Text(
                  note.content,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines:
                      10, // Adjust this number to control how many lines show before cutting off
                ),
              ),
              // Bottom title area
              SizedBox(height: 8.h),
              Text(
                note.title.isNotEmpty
                    ? note.title
                    : "Text note ${formattedDate}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Column(
      children: [
        SizedBox(height: 150.h),
        Center(
          child: Assets.images.rafiki.image(
            width: 350.w,
            height: 350.h,
          ),
        ),
        reusableText(
          'Create your first note!',
          Colors.white,
          20.sp,
          FontWeight.normal,
          0.0,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SafeArea(
        child: SizedBox(
          width: 70.w,
          height: 70.h,
          child: FloatingActionButton(
            elevation: 15,
            onPressed: () {},
            backgroundColor: blackBg,
            shape: const CircleBorder(),
            child: const Icon(
              size: 40,
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
      backgroundColor: blackBg,
      appBar: AppBar(
        backgroundColor: blackBg,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            reusableText(
              'Notes',
              white,
              43,
              FontWeight.w400,
              0.0,
            ),
            Row(
              children: [
                reusableCenteredCard(
                  50.h,
                  50.w,
                  blackBg2,
                  15.r,
                  const Icon(
                    size: 25,
                    weight: 500,
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 21.w),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Settings(),
                      ),
                    );
                  },
                  child: reusableCenteredCard(
                    50.h,
                    50.w,
                    blackBg2,
                    15.r,
                    const Icon(
                      size: 25,
                      weight: 500,
                      Icons.settings_outlined,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _notes.isEmpty
              ? _buildEmptyState()
              : _buildNotesList(),
    );
  }
}
