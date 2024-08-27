import 'package:flutter/material.dart';

class ArtTherapy extends StatelessWidget {
  const ArtTherapy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final exercises = [
      {
        "title": "Color Your Mood",
        "description":
            "Use colors that resonate with your current mood to fill a blank page."
      },
      {
        "title": "Sculpt Your Emotions",
        "description":
            "Use clay or play-dough to sculpt an abstract representation of your emotions."
      },
      {
        "title": "Draw Your Safe Space",
        "description":
            "Illustrate a place where you feel safe, calm, and happy."
      },
      {
        "title": "Collage Your Values",
        "description":
            "Create a collage that represents your core values using magazine clippings or printed pictures."
      },
      {
        "title": "Paint Your Dream",
        "description":
            "Paint a scene or abstract representation of a memorable or recurring dream."
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Art Therapy Exercises',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pinkAccent, Colors.white],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: exercises.map((exercise) {
              return Card(
                color: Colors.black,
                elevation: 4,
                margin: EdgeInsets.symmetric(vertical: 10),
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  leading: CircleAvatar(
                    child: Icon(
                      Icons.brush,
                      color: Colors.white,
                    ),
                    backgroundColor: Colors.blue,
                  ),
                  title: Text(
                    exercise['title']!,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    exercise['description']!,
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
