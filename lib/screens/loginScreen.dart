// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, missing_return, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/services/api_manager.dart';

import '../utils/iColors.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isValid = true;
  bool isObsecure = true;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: IColors.title,
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: height / 10,
              ),
              child: Text(
                "Welcome Back",
                style: TextStyle(
                    fontSize: 48,
                    color: IColors.background,
                    fontFamily: GoogleFonts.mavenPro().fontFamily,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: height / 10,
            ),
            //---------Form--------//
            Container(
              height: height / 2.2,
              width: width / 1.2,
              decoration: BoxDecoration(
                  color: IColors.title,
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [
                  //----------Username------------//
                  //------------------------------//
                  //----------Label-01------------//
                  Padding(
                    padding:
                        EdgeInsets.only(top: height / 30, right: width / 1.4),
                    child: Text(
                      "Email",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: GoogleFonts.mavenPro().fontFamily,
                          color: IColors.placeholderText),
                    ),
                  ),
                  SizedBox(
                    height: height / 60,
                  ),
                  //-------------------//
                  //------Input--------//
                  Container(
                    height: height / 18,
                    width: width / 1.2,
                    decoration: BoxDecoration(
                        color: IColors.placeholder,
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: EdgeInsets.only(left: width / 30),
                      child: TextField(
                        controller: username,
                        style: TextStyle(
                            fontFamily: GoogleFonts.mavenPro().fontFamily,
                            color: IColors.title,
                            fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "elon@musk.com",
                            hintStyle: TextStyle(
                                fontFamily: GoogleFonts.mavenPro().fontFamily,
                                fontWeight: FontWeight.bold,
                                color: IColors.placeholderText),
                            suffixIcon: Icon(
                              Icons.person,
                              color: IColors.placeholderText,
                            )),
                        onEditingComplete: () {
                          if (!username.text.contains("@") ||
                              username.text.length > 16) {
                            Fluttertoast.showToast(msg: "Email is not valid");
                          }
                        },
                      ),
                    ),
                  ),
                  //-------------------//
                  //----------------Password------------------//
                  Padding(
                    padding:
                        EdgeInsets.only(top: height / 30, right: width / 1.6),
                    child: Text(
                      "Password",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: GoogleFonts.mavenPro().fontFamily,
                          color: IColors.placeholderText),
                    ),
                  ),
                  SizedBox(
                    height: height / 60,
                  ),
                  //-------------------//
                  //------Input--------//
                  Container(
                    height: height / 18,
                    width: width / 1.2,
                    decoration: BoxDecoration(
                        color: IColors.placeholder,
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: EdgeInsets.only(left: width / 30),
                      child: TextField(
                        controller: password,
                        obscureText: isObsecure,
                        style: TextStyle(
                            color: IColors.title,
                            fontFamily: GoogleFonts.mavenPro().fontFamily,
                            fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "XXXXXXX",
                            hintStyle: TextStyle(
                                fontFamily: GoogleFonts.mavenPro().fontFamily,
                                fontWeight: FontWeight.bold,
                                color: IColors.placeholderText),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isObsecure = !isObsecure;
                                });
                              },
                              icon: Icon(
                                  isObsecure ? Icons.lock : Icons.lock_open),
                              color: isValid
                                  ? IColors.placeholderText
                                  : IColors.green,
                            )),
                        onEditingComplete: () {
                          if (password.text.length < 6) {
                            Fluttertoast.showToast(
                                msg: "Password is not valid");
                          }
                        },
                        onChanged: (value) {
                          if (password.text.length > 6) {
                            setState(() {
                              isValid = false;
                            });
                          } else {
                            setState(() {
                              isValid = true;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                  //--------------------------------//
                  //----------Submit-Button-------------//
                  SizedBox(
                    height: height / 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (username.text.isEmpty || password.text.isEmpty) {
                        Fluttertoast.showToast(
                          msg: "All fields are required 🤖",
                          textColor: IColors.red,
                          backgroundColor: IColors.title,
                        );
                      } else {
                        // login(username.text, password.text);
                        Api_Manager()
                            .loginPost(username.text, password.text, context);
                      }
                    },
                    child: Container(
                      height: height / 18,
                      width: width / 1.2,
                      decoration: BoxDecoration(
                          color: IColors.background,
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontFamily: GoogleFonts.mavenPro().fontFamily,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: IColors.title,
                          ),
                        ),
                      ),
                    ),
                  ),
                  //-----------------------------//
                  //---------forgot-password-------------------//
                  SizedBox(
                    height: height / 40,
                  ),
                  Text(
                    "forgot password?",
                    style: TextStyle(
                        color: IColors.placeholderText,
                        fontSize: 12,
                        fontFamily: GoogleFonts.mavenPro().fontFamily,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            //------------------------------------//
            //-------------Sign-Up-------------------//
            SizedBox(
              height: height / 20,
            ),
            GestureDetector(
              onTap: () {},
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 1.2,
                child: Container(
                  height: height / 18,
                  width: width / 1.2,
                  decoration: BoxDecoration(
                      color: IColors.background,
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontFamily: GoogleFonts.mavenPro().fontFamily,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: IColors.title,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            //-----------------------------//
            //------------problem---------------//
            Padding(
              padding: EdgeInsets.only(top: height / 12, left: width / 3.2),
              child: Row(
                children: [
                  Text(
                    "got a problem? ",
                    style: TextStyle(
                        color: IColors.placeholderText,
                        fontSize: 12,
                        fontFamily: GoogleFonts.mavenPro().fontFamily,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "complaint us",
                    style: TextStyle(
                        color: IColors.placeholder,
                        fontSize: 12,
                        fontFamily: GoogleFonts.mavenPro().fontFamily,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
