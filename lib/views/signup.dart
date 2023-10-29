// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'package:contacts_app/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100], // Set the background color to peach
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(
                height: 90,
              ),
              Text(
                "Sign Up",
                style: GoogleFonts.dancingScript(
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  color: Colors.brown, // Set text color to brown
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .9,
                child: TextFormField(
                  validator: (value) =>
                      value!.isEmpty ? "Email cannot be empty." : null,
                  controller: _emailController,
                  style: GoogleFonts.dancingScript(
                    fontSize: 16,
                    color: Colors.brown, // Set text color to brown
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email",
                    labelStyle: GoogleFonts.dancingScript(
                      fontSize: 16,
                      color: Colors.brown, // Set label text color to brown
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .9,
                child: TextFormField(
                  validator: (value) =>
                      value!.length < 8 ? "Password should have at least 8 characters." : null,
                  controller: _passwordController,
                  obscureText: true,
                  style: GoogleFonts.dancingScript(
                    fontSize: 16,
                    color: Colors.brown, // Set text color to brown
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Password",
                    labelStyle: GoogleFonts.dancingScript(
                      fontSize: 16,
                      color: Colors.brown, // Set label text color to brown
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 65,
                width: MediaQuery.of(context).size.width * .9,
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      AuthService()
                          .createAccountWithEmail(_emailController.text, _passwordController.text)
                          .then((value) {
                        if (value == "Account Created") {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text("Account Created")));
                          Navigator.pushReplacementNamed(context, "/home");
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              value,
                              style: GoogleFonts.dancingScript(
                                fontSize: 16,
                                color: Colors.white, // Set text color to white
                              ),
                            ),
                            backgroundColor: Colors.brown, // Set button color to brown
                          ));
                        }
                      });
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.brown), // Set button color to brown
                  ),
                  child: Text(
                    "Sign Up",
                    style: GoogleFonts.dancingScript(
                      fontSize: 16,
                      color: Colors.white, // Set text color to white
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: GoogleFonts.dancingScript(
                      fontSize: 16,
                      color: Colors.white, // Set text color to white
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Login",
                      style: GoogleFonts.dancingScript(
                        fontSize: 16,
                        color: Colors.white, // Set text color to white
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
