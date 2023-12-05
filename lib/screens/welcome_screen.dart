import 'package:screen_project/screens/signup_screen.dart';
import 'package:screen_project/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'constants.dart';
import 'login.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _imageSlideAnimation;
  late Animation<Offset> _loginSlideAnimation;
  late Animation<Offset> _signupSlideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _imageSlideAnimation = Tween<Offset>(
      begin: Offset(0, -1),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _loginSlideAnimation = Tween<Offset>(
      begin: Offset(-1, 0),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _signupSlideAnimation = Tween<Offset>(
      begin: Offset(1, 0),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
            tag: 'welcome_image',
            child: SlideTransition(
              position: _imageSlideAnimation,
              child: FadeTransition(
                opacity: _opacityAnimation,
                child: SvgPicture.asset(
                  "assets/images/welcome.svg",
                  height: 150,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          FadeTransition(
            opacity: _opacityAnimation,
            child: Text(
              "Welcome!",
              style: TextStyle(
                fontSize: kbigFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 10),
          FadeTransition(
            opacity: _opacityAnimation,
            child: Text(
              "Please login or signup",
              style: TextStyle(fontSize: kmediumFontSize),
            ),
          ),
          SizedBox(height: 20),
          SlideTransition(
            position: _loginSlideAnimation,
            child: FadeTransition(
              opacity: _opacityAnimation,
              child: CustomButton(
                color: kprimaryColor,
                textColor: Colors.white,
                text: "Login",
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignIn(),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 10),
          SlideTransition(
            position: _signupSlideAnimation,
            child: FadeTransition(
              opacity: _opacityAnimation,
              child: CustomButton(
                color: ksecondryColor,
                textColor: Colors.black,
                text: "Sign Up",
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignupScreen(),
                    ),
                  );
                },
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