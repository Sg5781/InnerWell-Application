import 'package:flutter/material.dart';

import 'package:mental_health_app1/Screens/SingleScreens/KnowYourMedicine.dart';
import 'package:mental_health_app1/Screens/SingleScreens/MentalHealthNewsScreen.dart';
import 'package:mental_health_app1/Screens/SupportGroupScreens/ComSupScreen.dart';
import 'package:mental_health_app1/Screens/SingleScreens/Exercises.dart';
import 'package:mental_health_app1/Screens/ArtTherapy.dart';
import 'package:mental_health_app1/Screens/Test%20Screens/HelplineNumbers.dart';
import 'package:mental_health_app1/Screens/Test%20Screens/QuestSelectScreen.dart';
import 'package:mental_health_app1/Screens/YourTherapistScreens/TherapistMainScreen.dart';
import 'package:mental_health_app1/Screens/JournalScreens/journalScreen.dart';

import 'package:table_calendar/table_calendar.dart';

class MainScreen extends StatelessWidget {
  //
  //function for calendar
  void _showCalendarPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor:
            Colors.black, // Setting the background color of the dialog
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: DateTime.now(),
            calendarFormat: CalendarFormat.month,
            availableCalendarFormats: const {
              CalendarFormat.month: 'Month',
            },
            calendarStyle: CalendarStyle(
              outsideDaysVisible: false,
              defaultTextStyle: TextStyle(color: Colors.white),
              weekendTextStyle: TextStyle(color: Colors.red[300]),
              holidayTextStyle: TextStyle(color: Colors.blue[300]),
              selectedTextStyle: TextStyle(color: Colors.yellow),
              selectedDecoration: BoxDecoration(
                color: Colors.deepOrange,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              outsideTextStyle: TextStyle(color: Colors.grey[500]),
              outsideDecoration: BoxDecoration(
                color: Colors.black54,
              ),
              defaultDecoration: BoxDecoration(
                color: Colors
                    .black, // Setting the background color of the calendar
              ),
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekendStyle:
                  TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              weekdayStyle: TextStyle(color: Colors.white),
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
              leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
              rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Hello Nobody', style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            color: Colors.black,
            onPressed: () {
              _showCalendarPopup(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.tune),
            color: Colors.black,
            onPressed: () {
              // TODO: Handle settings button press
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[200]),
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.pets,
                    color: Colors.black,
                  ),
                  Expanded(
                    child: Text(
                      'Spend Time With Your Pet Cody',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0, // Adjust text size
                        color: Colors.black, // Text color
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
                    ), // Icon pointing to the right
                    onPressed: () {
                      // TODO: Navigate to the Cody screen
                    },
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics:
                  NeverScrollableScrollPhysics(), // Disable GridView's scrolling
              mainAxisSpacing: 20.0,
              crossAxisSpacing: 20.0,
              children: [
                _buildGridBox(
                  context,
                  'Journal',
                  Icons.book,
                  () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => JournalScreen()));
                  },
                ),
                _buildGridBox(
                  context,
                  'Latest News',
                  Icons.newspaper,
                  () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => NewsScreen()));
                  },
                ),
                _buildGridBox(
                  context,
                  'Take a Test!',
                  Icons.question_answer_outlined,
                  () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MentalHealthTestsScreen()));
                  },
                ),
                _buildGridBox(
                  context,
                  'Know Your Medicine',
                  Icons.medical_services,
                  () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => KnowYourMedicineScreen()));
                  },
                ),
                _buildGridBox(
                  context,
                  'Support Group',
                  Icons.group,
                  () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CommunitySupportScreen(),
                    ));
                  },
                ),
                _buildGridBox(
                  context,
                  'Exercise',
                  Icons.fitness_center,
                  () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ExercisesScreen()));
                  },
                ),
                _buildGridBox(
                  context,
                  'Art Therapy',
                  Icons.palette,
                  () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ArtTherapy()));
                  },
                ),
                _buildGridBox(
                  context,
                  'Your Therapist',
                  Icons.person,
                  () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => TherapistScreen()));
                  },
                ),
                _buildGridBox(
                  context,
                  'Helpline Numbers',
                  Icons.call,
                  () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HelplineScreen()));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridBox(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 48.0,
              color: Colors.black,
            ),
            SizedBox(height: 8.0),
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
