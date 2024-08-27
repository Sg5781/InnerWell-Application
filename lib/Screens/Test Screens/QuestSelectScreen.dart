import 'package:flutter/material.dart';
import 'package:mental_health_app1/Screens/Test%20Screens/GAD-7.dart';
import 'package:mental_health_app1/Screens/Test%20Screens/PHQ-9.dart';

class MentalHealthTestsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 250.0, top: 25, bottom: 25),
                child: Text(
                  'Self Assess',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.asset(
                    'assets/images/SelfAssess.png',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 35, right: 35),
                child: Divider(
                  color: Colors.white.withOpacity(0.4),
                ),
              ),
              ...[
                _TestBox(
                  title: 'PHQ-9',
                  subtitle: 'For Depression',
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PHQ9TestScreen()));
                  },
                ),
                _TestBox(
                  title: 'GAD-7',
                  subtitle: 'For Anxiety',
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => GAD7TestScreen()));
                  },
                ),
                _TestBox(
                  title: 'ASRS',
                  subtitle: 'For ADHD',
                  onPressed: () {
                    // Navigate to ASRS test
                  },
                ),
                _TestBox(
                  title: 'EAT-26',
                  subtitle: 'For Eating Disorders',
                  onPressed: () {
                    // Navigate to EAT-26 test
                  },
                ),
                _TestBox(
                  title: 'WHO-5',
                  subtitle: 'Well-Being Index',
                  onPressed: () {
                    // Navigate to WHO-5 test
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _TestBox extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onPressed;

  const _TestBox({
    required this.title,
    required this.subtitle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30, right: 30),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          width: double.infinity, // This ensures it takes full width
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color:
                Color.fromARGB(255, 26, 13, 46), // Dark grey background color
            border: Border(
              bottom: BorderSide(color: Colors.white.withOpacity(0.4)),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    color: Colors
                        .white, // Changed text color to white for better visibility on dark background
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                subtitle,
                style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey[
                        400]), // Adjusted grey color to be visible on a dark background
              ),
            ],
          ),
        ),
      ),
    );
  }
}
