import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_crafter_app/screens/dashboard.dart';
import 'package:task_crafter_app/screens/forgot_password.dart';
import 'package:task_crafter_app/screens/signupas.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  userLogin() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => dashboard()));
  }

  var email = '';
  var password = '';
  String? selectedOption;
  String? errorText;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final selectedOptionController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    selectedOptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: TextStyle(
          color: Colors.deepPurple,
          fontSize: 20.0,
        ),
        centerTitle: true,
        title: Text("TaskCrafter"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                    icon: Icon(Icons.email_outlined),
                    labelText: 'Email',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Valid Email';
                    } else if (!value.contains('@')) {
                      return 'Please Enter Valid Email';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Password';
                    }
                    return null;
                  },
                ),
              ),
              /*Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10,
                    0), // Padding around the DropdownButtonFormField
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText:
                        'Select Role', // Label text displayed above the dropdown field
                    labelStyle:
                        TextStyle(fontSize: 20.0), // Styling for the label text
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                    // Border around the dropdown field
                  ),
                  value: selectedOption, // Currently selected option
                  onChanged: (String? newValue) {
                    // Function called when the user selects an option
                    setState(() {
                      selectedOption = newValue;
                      controller:
                      selectedOptionController;
                    });
                  },
                 // items: <String>['Project Manager', 'Team Member']
                  //    .map<DropdownMenuItem<String>>((String value) {
                    // Mapping options to DropdownMenuItems
                   // return DropdownMenuItem<String>(
                   //   value: value,
                 //     child: Text(value),
                 //   );
                //  }).toList(),
                 // validator: (value) {
                 //   if (selectedOption == null) {
                 //     return "Select a Role";
                 //   }
                 //   return null;
                //  },
                ),
              ),
            */
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromRGBO(0, 0, 255, 0.4),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            email = emailController.text;
                            password = passwordController.text;
                            //selectedOption = selectedOptionController.text;
                          });
                          userLogin();
                        }
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 14.0, color: Colors.white),
                      ),
                    ),
                    TextButton(
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgotPassword(),
                          ),
                        )
                      },
                      child: Text(
                        'Forgot Password ?',
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an Account? "),
                    TextButton(
                      onPressed: () => {
                        Navigator.pushAndRemoveUntil(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, a, b) => Signupas(),
                              transitionDuration: Duration(seconds: 0),
                            ),
                            (route) => false)
                      },
                      child: Text(
                        'Signup',
                        style:
                            TextStyle(color: Colors.deepPurple, fontSize: 14.0),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
