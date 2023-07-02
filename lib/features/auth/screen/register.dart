import 'package:custom_shop/features/auth/service/auth_services.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  FocusNode myFocusNode = FocusNode();
  FocusNode myFocusNode1 = FocusNode();
  FocusNode myFocusNode2 = FocusNode();
  FocusNode myFocusNode3 = FocusNode();
  final AuthService authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPassController.dispose();

    super.dispose();
  }

  void signUpUser() {
    ///avoid memory leak
    authService.signUpUser(
      context: context,
      name: _nameController.text,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 150.0, bottom: 100),
            child: Center(
              child: Text('Register', style: TextStyle(fontSize: 60.0)),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 40.0, right: 40.0),
            child: Form(
                key: _form,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: _emailController,
                        validator: (value) =>
                            value!.isEmpty ? 'Email cannot be blank' : null,
                        focusNode: myFocusNode1,
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 40, 25, 25),
                                  width: 2.0),
                            ),
                            labelText: 'Enter your Email',
                            labelStyle: TextStyle(
                                color: myFocusNode1.hasFocus
                                    ? const Color.fromARGB(255, 21, 40, 55)
                                    : Color(0xFF6C6C6C))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: _nameController,
                        validator: (value) =>
                            value!.isEmpty ? 'Name cannot be blank' : null,
                        focusNode: myFocusNode3,
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 40, 25, 25),
                                  width: 2.0),
                            ),
                            labelText: 'Enter your Name',
                            labelStyle: TextStyle(
                                color: myFocusNode1.hasFocus
                                    ? const Color.fromARGB(255, 21, 40, 55)
                                    : Color(0xFF6C6C6C))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: TextFormField(
                        controller: _passwordController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) =>
                            value!.isEmpty ? 'Password cannot be blank' : null,
                        obscureText: true,
                        focusNode: myFocusNode,
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 40, 25, 25),
                                  width: 2.0),
                            ),
                            labelText: 'Enter your password',
                            labelStyle: TextStyle(
                                color: myFocusNode.hasFocus
                                    ? const Color.fromARGB(255, 21, 40, 55)
                                    : Color(0xFF6C6C6C))),
                      ),
                    ),
                    TextFormField(
                      controller: _confirmPassController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (val) {
                        if (val!.isEmpty) return 'Empty';
                        if (val != _passwordController.text) return 'Not Match';
                        return null;
                      },
                      obscureText: true,
                      focusNode: myFocusNode2,
                      decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 40, 25, 25),
                                width: 2.0),
                          ),
                          labelText: 'Re-Enter your password',
                          labelStyle: TextStyle(
                              color: myFocusNode2.hasFocus
                                  ? const Color.fromARGB(255, 21, 40, 55)
                                  : Color(0xFF6C6C6C))),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: 100,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                          ),
                          onPressed: () {
                            if (_form.currentState!.validate()) {
                              signUpUser();
                            }
                          },
                          child: Text('Register')),
                    ),
                    SizedBox(
                      width: 100,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                          ),
                          onPressed: () => Navigator.pushNamed(context, '/'),
                          child: Text('Back')),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
