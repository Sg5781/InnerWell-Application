import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:firebase_core/firebase_core.dart';
import 'Screens/MainScreen.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure that Flutter is initialized
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mental Health App',
      theme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(163, 166, 173, 175),
          brightness: Brightness.dark,
          surface: Colors.grey[50],
        ),
        scaffoldBackgroundColor: Colors.grey[50],
      ),
      home:
          FirebaseAuthenticationWrapper(), // Use a wrapper to handle authentication
    );
  }
}

class FirebaseAuthenticationWrapper extends StatefulWidget {
  @override
  _FirebaseAuthenticationWrapperState createState() =>
      _FirebaseAuthenticationWrapperState();
}

class _FirebaseAuthenticationWrapperState
    extends State<FirebaseAuthenticationWrapper> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _auth
          .authStateChanges(), // Listen to the user's authentication state changes
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;

          // Check if the user is authenticated
          if (user == null) {
            // User is not authenticated, navigate to login screen
            return LoginScreen();
          } else {
            // User is authenticated, navigate to main screen
            return MainScreen();
          }
        }

        // While the authentication state is loading, you can show a loading indicator
        return CircularProgressIndicator();
      },
    );
  }
}

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signInWithEmailAndPassword(BuildContext context) async {
    try {
      final String email = _emailController.text.trim();
      final String password = _passwordController.text.trim();

      // Sign in with email and password
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      // Successfully logged in, navigate to the main screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    } catch (e) {
      // Handle login errors
      print(e.toString());

      // You can show an error message to the user
      // For example: ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true, // Hide password
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _signInWithEmailAndPassword(context),
              child: Text('Log In'),
            ),
            SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                // Navigate to a registration screen or implement password reset
                // For example: Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegistrationScreen()));
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
