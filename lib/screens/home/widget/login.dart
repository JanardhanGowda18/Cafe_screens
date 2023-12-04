import 'package:flutter/material.dart';

import '../home.dart';
import 'forgotpassword.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cafe Registration',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email address';
    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    } else if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    } else if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one digit';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/cafe1.jpeg"),
                  fit: BoxFit.cover,
                ),
              ),
              height: MediaQuery.of(context).size.height * 0.3,
            ),
            Center(
              child:Padding(
                padding: const EdgeInsets.only(top: 100.0),

                child: FractionallySizedBox(
                  heightFactor: 0.7, // Adjust the value as needed
                  widthFactor: 0.9,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Login',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Email',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8),
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: TextFormField(
                                    controller: emailController,
                                    focusNode: emailFocusNode,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) => emailFocusNode.hasFocus ? _validateEmail(value) : null,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Password',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8),
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: TextFormField(
                                    controller: passwordController,
                                    focusNode: passwordFocusNode,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                    ),
                                    obscureText: true,
                                    validator: (value) => passwordFocusNode.hasFocus ? _validatePassword(value) : null,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            InkWell(
                              onTap: () {},
                              child: Text(
                                "New user? Create account",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.blue, fontSize: 16),
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Checkbox(
                                  value: rememberMe,
                                  onChanged: (value) {
                                    setState(() {
                                      rememberMe = value ?? false;
                                    });
                                  },
                                ),
                                Text('Remember me'),
                              ],
                            ),
                            SizedBox(height: 5),
                            Container(
                              width: 100,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (Form.of(context)!.validate()) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => HomePage()),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Please fill the feilds.'),
                                      ),
                                    );
                                  }
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.brown),
                                  shape: MaterialStateProperty.all<OutlinedBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                ),
                                child: Text('Next',style: TextStyle(color: Colors.white),),
                              ),

                            ),
                            SizedBox(height: 7),
                            Align(
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
                                },
                                child: Text('Forgot Password?',style: TextStyle(color:Colors.blue),),

                              ),),
                            // SizedBox(height: 8),


                          ],
                        ),
                      ),
                    ),
                  ),

                ),

              ),
            ),
          ],
        ),
      ),
    );
  }
}