// ... other imports
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class KnowYourMedicineScreen extends StatefulWidget {
  @override
  _KnowYourMedicineScreenState createState() => _KnowYourMedicineScreenState();
}

class _KnowYourMedicineScreenState extends State<KnowYourMedicineScreen> {
  Future<Map<String, dynamic>>? _medicineDataFuture;
  final _controller = TextEditingController();

  Future<Map<String, dynamic>> fetchMedicineData(String query) async {
    final apiKey =
        'D81wRFa9QXRPfKnxhRV1uEIFRNw7BE7k2LiMZyrv'; // Replace with your API key
    final response = await http.get(
      Uri.parse(
          'https://api.fda.gov/drug/label.json?search=${query}&api_key=${apiKey}'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load medicine data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Arial',
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
          bodyText1: TextStyle(fontSize: 18.0),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Know your Medicine"),
          elevation: 0.0,
          backgroundColor: Colors.black,
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Search medicine',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _medicineDataFuture = fetchMedicineData(_controller.text);
                    });
                  },
                  child: Text(
                    'Search',
                    style: TextStyle(
                      color: Colors.white, // Set text color
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.brown, // Set background color
                    padding: EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12), // Set padding
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(20), // Set border radius
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: FutureBuilder<Map<String, dynamic>>(
                  future: _medicineDataFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      var results = snapshot.data?['results'] ?? [];
                      if (results.isEmpty) {
                        return Center(child: Text('No data available'));
                      }

                      var medicineData = results[0];
                      return ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        children: [
                          if (medicineData['openfda'] != null &&
                              medicineData['openfda']['brand_name'] != null &&
                              medicineData['openfda']['brand_name'].isNotEmpty)
                            Text(
                                'Brand Name: ${medicineData['openfda']['brand_name'][0]}',
                                style: Theme.of(context).textTheme.headline1),
                          SizedBox(height: 20),
                          if (medicineData['indications_and_usage'] != null &&
                              medicineData['indications_and_usage'].isNotEmpty)
                            Text(
                              'Usage: ${medicineData['indications_and_usage'][0].toString().substring(0, medicineData['indications_and_usage'][0].toString().length < 1000 ? medicineData['indications_and_usage'][0].toString().length : 1000)}...',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          SizedBox(height: 20),
                          if (medicineData['dosage_and_administration'] !=
                                  null &&
                              medicineData['dosage_and_administration']
                                  .isNotEmpty)
                            Text(
                                'Dosage: ${medicineData['dosage_and_administration'][0].toString().substring(0, medicineData['dosage_and_administration'][0].toString().length < 1000 ? medicineData['dosage_and_administration'][0].toString().length : 1000)}...',
                                style: Theme.of(context).textTheme.bodyText1),
                          SizedBox(height: 20),
                          if (medicineData['general_precautions'] != null &&
                              medicineData['general_precautions'].isNotEmpty)
                            Text(
                                'General Precautions: ${medicineData['general_precautions'][0].toString().substring(0, medicineData['general_precautions'][0].toString().length < 1000 ? medicineData['general_precautions'][0].toString().length : 1000)}...',
                                style: Theme.of(context).textTheme.bodyText1),
                          SizedBox(height: 20),
                          if (medicineData['storage_and_handling'] != null &&
                              medicineData['storage_and_handling'].isNotEmpty)
                            Text(
                                'Storage and Handling: ${medicineData['storage_and_handling'][0].toString().substring(0, medicineData['storage_and_handling'][0].toString().length < 1000 ? medicineData['storage_and_handling'][0].toString().length : 1000)}...',
                                style: Theme.of(context).textTheme.bodyText1),
                          // add more fields as necessary
                        ],
                      );
                    } else {
                      return Center(child: Text('No data available'));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
