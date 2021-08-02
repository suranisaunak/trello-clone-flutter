import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trelloapp/src/constants/constants.dart';
import 'package:trelloapp/src/providers/auth_provider.dart';
import 'package:trelloapp/src/providers/connectivity_provider.dart';
import 'package:trelloapp/src/widget/loader.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final connectivityProvider = Provider.of<ConnectivityProvider>(context);

    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
    
      body: Stack(
        children: [
          Container(
              child: ListView(
            children: [
              SizedBox(
                height: height * 0.1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: primaryBlue),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.06,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        width: width,
                        margin: EdgeInsets.symmetric(horizontal: width * 0.05),
                        child: TextFormField(
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            letterSpacing: 1.5,
                          ),
                          decoration: InputDecoration(
                            //  prefixIcon: Icon(FontAwesomeIcons.envelope, size: 20),
                            filled: true,
                            fillColor: Color(0xFFF2F2F2),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(6)),
                                borderSide:
                                    BorderSide(width: 1, color: primaryBlue)),

                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(6)),
                              borderSide: BorderSide(
                                width: 1,
                                color: primaryBlue,
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(6)),
                                borderSide:
                                    BorderSide(width: 1, color: primaryBlue)),

                            isDense: true,
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            hintText: "Email",
                            hintStyle: TextStyle(
                              fontSize: 14,
                              color: Color(0xFFB3B1B1),
                              letterSpacing: 1.5,
                            ),
                            //errorText: snapshot.error,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email is required';
                            } else if (!EmailValidator.validate(value)) {
                              return "Please enter a correct email address";
                            }
                            return null;
                          },
                          controller: _email,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Container(
                        width: width,
                        margin: EdgeInsets.symmetric(horizontal: width * 0.05),
                        child: TextFormField(
                          obscureText: true,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            letterSpacing: 1.5,
                          ),
                          decoration: InputDecoration(
                            //  prefixIcon: Icon(FontAwesomeIcons.envelope, size: 20),
                            filled: true,
                            fillColor: Color(0xFFF2F2F2),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(6)),
                                borderSide:
                                    BorderSide(width: 1, color: primaryBlue)),

                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(6)),
                              borderSide: BorderSide(
                                width: 1,
                                color: primaryBlue,
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(6)),
                                borderSide:
                                    BorderSide(width: 1, color: primaryBlue)),

                            isDense: true,
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            hintText: "Password",
                            hintStyle: TextStyle(
                              fontSize: 14,
                              color: Color(0xFFB3B1B1),
                              letterSpacing: 1.5,
                            ),
                            //errorText: snapshot.error,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required';
                            }
                           else if (value.length < 6) {
                              return 'Password must be at least 6 character';
                            }
                            return null;
                          },
                          controller: _password,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Container(
                        width: width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (_formKey.currentState!.validate()) 
                                {
                                  connectivityProvider
                                      .checkInternet()
                                      .then((hasInternet) {
                                    if (hasInternet) {
                                      setState(() {
                                        isLoading = true;
                                      });

                                      authProvider
                                          .emailSignIn(
                                              email: _email.text.toLowerCase(),
                                              pass: _password.text.toLowerCase())
                                          .then((user) {
                                        if (user == null) {
                                          setState(() {
                                            isLoading = false;
                                          });
                                        } else {
                                          setState(() {
                                            isLoading = false;
                                          });
                                          Navigator.pushReplacementNamed(
                                              context, '/homescreen');
                                        }
                                      }).catchError((onError){
                                         ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                        onError.toString(),
                                      )));
                                       setState(() {
                                          isLoading = false;
                                        });
                                      });
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                        "No internet connectivity found",
                                      )));
                                    }
                                  });
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: height * 0.05),
                                height: 40,
                                padding:
                                    EdgeInsets.symmetric(horizontal: width * 0.1),
                                decoration: BoxDecoration(
                                    gradient: buttonBgGradient,
                                    borderRadius: BorderRadius.circular(25),
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 3,
                                          color: Colors.grey,
                                          offset: Offset(0, 2),
                                          spreadRadius: 2)
                                    ]),
                                child: Center(
                                    child: Text(
                                  "Login",
                                  style:
                                      TextStyle(fontSize: 16, color: Colors.white),
                                )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                height: height * 0.07,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    child: Text(
                      "Don't have an account ? ",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/signupscreen');
                    },
                    child: Container(
                      height: 50,
                      child: Text(
                        "Signup",
                        style: TextStyle(fontSize: 14, color: primaryBlue),
                      ),
                    ),
                  ),
                ],
              )
            ],
          )),
          isLoading ? Loader(): SizedBox()
        ],
      ),
    );
  }
}
