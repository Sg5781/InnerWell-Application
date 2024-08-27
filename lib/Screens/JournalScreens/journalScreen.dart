import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mental_health_app1/Screens/JournalScreens/modalbottomsheet.dart';

class JournalScreen extends StatefulWidget {
  @override
  _JournalScreenState createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  final String databaseUrl =
      "https://mental-health-app-75d57-default-rtdb.firebaseio.com/notes.json";
  List<Map<dynamic, dynamic>> notes = [];
  TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchNotes();
  }

  Future<void> fetchNotes() async {
    try {
      final response = await http.get(Uri.parse(databaseUrl));
      final data = json.decode(response.body) as Map<String, dynamic>;

      if (data != null) {
        setState(() {
          notes = data.entries
              .map((entry) => {"key": entry.key, ...entry.value})
              .toList();
        });
      } else {
        setState(() {
          notes = [];
        });
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  Future<void> addNote() async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return NoteModalBottomSheet(
          noteController: _noteController,
          onSave: () async {
            if (_noteController.text.isNotEmpty) {
              try {
                final response = await http.post(
                  Uri.parse(databaseUrl),
                  body: json.encode({"note": _noteController.text}),
                );

                if (response.statusCode == 200) {
                  fetchNotes();
                }
              } catch (error) {
                print('Error adding note: $error');
              }
            }
            _noteController.clear();
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  Future<void> deleteNote(String key) async {
    try {
      final response = await http.delete(
        Uri.parse(
            "https://mental-health-app-75d57-default-rtdb.firebaseio.com/notes/$key.json"),
      );

      if (response.statusCode == 200) {
        fetchNotes();
      }
    } catch (error) {
      print('Error deleting note: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Journal"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 88.0, 16.0, 16.0),
            child: notes.isEmpty
                ? Center(child: CircularProgressIndicator())
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16.0,
                      crossAxisSpacing: 16.0,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: notes.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.black,
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Stack(
                            children: [
                              Text(
                                notes[index]['note'],
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.delete_sharp,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    deleteNote(notes[index]['key']);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: addNote,
        label: Text('Add Note'),
        icon: Icon(Icons.edit),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
