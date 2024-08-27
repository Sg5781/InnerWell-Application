import 'package:flutter/material.dart';

class HelplineScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final helplines = [
      {"name": "Gujarat Helpline 1", "phone": "9152987821"},
      {"name": "Gujarat Helpline 2", "phone": "0261 6554050"},
      {"name": "National Helpline (ICare)", "phone": "9152987821"},
    ];

    return Theme(
      data: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xFF0D0D0D), // Custom darker color
        scaffoldBackgroundColor:
            Color.fromARGB(255, 26, 13, 46), // Custom darker color
      ),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Color.fromARGB(255, 26, 13, 46),
          leading: Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0)),
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                color: Colors.black, // This is the icon color
              ),
            ),
          ),
          leadingWidth: 70, // Adjust the width as per your requirement
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: helplines.length,
            itemBuilder: (context, index) {
              final helpline = helplines[index];
              return Card(
                color: Color.fromARGB(255, 157, 129, 46),
                margin: EdgeInsets.symmetric(vertical: 10),
                child: ListTile(
                  title: Text(helpline['name']!,
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  subtitle: Text(helpline['phone']!,
                      style: TextStyle(color: Colors.white70)),
                  onTap: () {},
                ),
              );
            },
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: Icon(Icons.home),
            ),
            SizedBox(height: 16),
            FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Icon(Icons.edit),
            ),
          ],
        ),
      ),
    );
  }
}
