import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:godrej_login_auth/screens/registration_screen.dart';
import 'package:http/http.dart' as http;
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // form key
  final _formKey = GlobalKey<FormState>();
  // editing controller
  // ignore: non_constant_identifier_names
  final TextEditingController UserNameController = TextEditingController();
  // ignore: unnecessary_new
  final TextEditingController passwordController = new TextEditingController();

  String _loginError = ''; // Update to string type to store error message

  bool passToggle = true;

  @override
  Widget build(BuildContext context) {
    // email field
    // ignore: non_constant_identifier_names
    final UserNameField = TextFormField(
        autofocus: false,
        controller: UserNameController,
        keyboardType: TextInputType.emailAddress,
        onSaved: (value) {
          UserNameController.text = value!;
        },
        validator: (value) {
          if (value!.isEmpty) {
            return 'UserName is required';
          }
          return null;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.verified_user_rounded),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "User Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    // password field
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordController,
        obscureText: passToggle,
        onSaved: (value) {
          passwordController.text = value!;
        },
        validator: (value) {
          if (value!.isEmpty) {
            return 'Password is required';
          }
          return null;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key),
          suffix: InkWell(
            onTap: () {
              setState(() {
                passToggle = !passToggle;
              });
            },
            child: Icon(passToggle ? Icons.visibility : Icons.visibility_off),
          ),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.indigoAccent,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () async {
          // Reset login error before making a login request
          setState(() {
            _loginError = ''; // Reset error message
          });

          http.Response response = await http.post(
             Uri.parse('https://test.vastraindia.com/api/login/login'),
             // Uri.parse('https://10.0.2.2:7058/api/login/login'),
            //Uri.parse('https://localhost:7058//api/login/login'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({
              "username": UserNameController.text,
              "password": passwordController.text,
            }),
          );

          if (response.statusCode == 200) {
            var responseData = json.decode(response.body);
            if (responseData == "Success") {
              print('success');
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              );
            } else {
              // Update login error when response is not success
              setState(() {
                _loginError =
                    'Invalid User Name or Password'; // Update error message here
              });
            }
          } else {
            setState(() {
              _loginError =
                  'Something went wrong, please try again'; // Update error message
            });
          }
        },

        //   http.Response response = await http.post(
        //     Uri.parse('https://test.vastraindia.com/api/login/login'),
        //     headers: {'Content-Type': 'application/json'},
        //     body: json.encode({
        //       "username": UserNameController.text,
        //       "password": passwordController.text,
        //     }),
        //   );
        //
        //   if (response.statusCode == 200) {
        //     var responseData = json.decode(response.body);
        //     if (responseData == "Success") {
        //       print('success');
        //       Navigator.of(context).pushReplacement(
        //         MaterialPageRoute(
        //           builder: (context) => HomeScreen(),
        //
        //         ),
        //       );
        //     } else {
        //       print("Login failed");
        //     }
        //   } else {
        //     print(response.reasonPhrase);
        //   }
        // },

        child: const Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
    const SizedBox(height: 15);
    Text(
      _loginError, // Display the login error message
      style: const TextStyle(color: Colors.red),
    );

    final loginErrorWidget = Visibility(
      visible: _loginError.isNotEmpty,
      child: Text(
        _loginError,
        style: const TextStyle(
          color: Colors.red,
          fontSize: 16.0,
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        height: 200,
                        child: Image.asset(
                          "assets/logo.png",
                          fit: BoxFit.contain,
                        )),
                    const SizedBox(height: 45),
                    UserNameField,
                    const SizedBox(height: 25),
                    passwordField,
                    const SizedBox(height: 35),
                    loginErrorWidget,
                    loginButton,
                    const SizedBox(height: 15),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text("Don't have an account? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RegistrationScreen()));
                            },
                            child: const Text(
                              "SignUp",
                              style: TextStyle(
                                  color: Colors.indigoAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          )
                        ])
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
