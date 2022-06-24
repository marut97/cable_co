import 'package:cable_co/net/flutterfire.dart';
import 'package:cable_co/ui/home_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  TextEditingController _emailField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();
  var _showLoginError = false;

  void resetLoginError() {
    if (_showLoginError) {
      setState(() {
        _showLoginError = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/login_background.jpg"),
                  fit: BoxFit.cover)),
          child: Column(
            children: [
              Container(
                  margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                  height: (MediaQuery.of(context).size.height -
                          MediaQuery.of(context).viewInsets.bottom) /
                      (MediaQuery.of(context).viewInsets.bottom == 0 ? 5 : 10),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/icons/logo.png"),
                          fit: BoxFit.fitHeight))),
              Container(
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Text(
                    "CableCo",
                    style: GoogleFonts.courgette(fontSize: 40),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Icon(
                        Icons.email_rounded,
                        size: 32,
                        color: Colors.blueGrey,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.4,
                      child: Flexible(
                        child: TextField(
                            onChanged: (value) => resetLoginError(),
                            controller: _emailField,
                            obscureText: true,
                            decoration: const InputDecoration(
                              hintText: "Email",
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            style: GoogleFonts.nunito(fontSize: 20)),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Icon(
                        Icons.lock_rounded,
                        size: 32,
                        color: Colors.blueGrey,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.4,
                      child: Flexible(
                        child: TextField(
                            onChanged: (value) => resetLoginError(),
                            controller: _passwordField,
                            obscureText: true,
                            decoration: const InputDecoration(
                              hintText: "Password",
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            style: GoogleFonts.nunito(fontSize: 20)),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).viewInsets.bottom == 0
                        ? 60
                        : 20),
                width: MediaQuery.of(context).size.width / 1.4,
                height: 45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.blueAccent),
                child: MaterialButton(
                  onPressed: () async {
                    bool loggedIn =
                        await logIn(_emailField.text, _passwordField.text);
                    if (loggedIn) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeView(),
                          ));
                    } else {
                      setState(() {
                        _showLoginError = true;
                      });
                    }
                  },
                  child: Text(
                    "Log In",
                    style: GoogleFonts.nunito(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Visibility(
                  visible: _showLoginError,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 15, 20, 0),
                    child: Text(
                      "Login Failed. Invalid email id or password",
                      style: GoogleFonts.nunito(
                          fontSize: 16,
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold),
                    ),
                  ))
              // Container(
              //   margin: const EdgeInsets.all(10),
              //   width: MediaQuery.of(context).size.width / 1.4,
              //   height: 45,
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(15.0),
              //       color: Colors.blueAccent),
              //   child: MaterialButton(
              //     onPressed: () async {
              //       bool signedUp =
              //           await signUp(_emailField.text, _passwordField.text);
              //       if (signedUp) {
              //         Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //               builder: (context) => HomeView(),
              //             ));
              //       }
              //     },
              //     child: Text(
              //       "Sign Up",
              //       style: GoogleFonts.nunito(
              //           fontSize: 20,
              //           color: Colors.white,
              //           fontWeight: FontWeight.bold),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
