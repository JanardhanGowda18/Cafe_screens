import 'package:flutter/material.dart';
import 'package:screen_project/screens/home/home.dart';
import '../../controller/signup/signup_controller.dart';
import '../../services/auth_sservice.dart';
import '../../services/firestore_service.dart';
import '../../widgets/custom_button.dart';
import '../constants.dart';
import '../login/login.dart';
import 'signup_screen_state.dart';
import 'OtpVerificationScreen.dart';
import '../../helpers/helpers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with SingleTickerProviderStateMixin
    implements SignupScreenState {
  late SignupController _controller;
  late AuthService authService = AuthService();
  final FirestoreService firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    _controller = SignupController(this, authService, firestoreService);
    _controller.initAnimations();
  }

  Future<void> _validateInputs() async {
    // Validate inputs and sign up logic here

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool userSignedUpBefore = prefs.getBool('userSignedUp') ?? false;

    if (userSignedUpBefore) {
      // User has signed up before, navigate to home page directly
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      // User is signing up for the first time, set the flag in shared preferences
      prefs.setBool('userSignedUp', true);

      // Navigate to home page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SlideTransition(
            position: _controller.getImageSlideAnimation(),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/cafe1.jpeg"),
                  fit: BoxFit.cover,
                ),
              ),
              height: MediaQuery.of(context).size.height * 0.4,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: SingleChildScrollView(
                child: SlideTransition(
                  position: _controller.getCardSlideAnimation(),
                  child: FadeTransition(
                    opacity: _controller.getOpacityAnimation(),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(height: 20),
                            Text(
                              "Create New Account",
                              style: TextStyle(
                                fontSize: kbigFontSize,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 20),
                            TextField(
                              controller: _controller.usernameController,
                              decoration: InputDecoration(
                                labelText: "Username",
                                errorText: _controller.getUsernameError(),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            TextField(
                              controller: _controller.emailController,
                              decoration: InputDecoration(
                                labelText: "Email",
                                errorText: _controller.getEmailError(),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            TextField(
                              controller: _controller.phoneController,
                              decoration: InputDecoration(
                                labelText: "Phone Number",
                                errorText: _controller.getPhoneNumberError(),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            TextField(
                              controller: _controller.passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: "Password",
                                errorText: _controller.getPasswordError(),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            CustomButton(
                              color: kprimaryColor,
                              textColor: Colors.white,
                              text: "Signup",
                              onPress: _validateInputs,
                            ),
                            SizedBox(height: 10),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>SignIn()));
                              },
                              child: Text(
                                "Already have an account? Login",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}