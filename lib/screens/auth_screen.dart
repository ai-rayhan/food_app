

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dart:io'show Platform;

import '../provider/auth.dart';

enum AuthMode { signup, login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';
 

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    // final transformConfig = Matrix4.rotationZ(-8 * pi / 180);
    // transformConfig.translate(-10.0);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: deviceSize.height / 4,
                margin: EdgeInsets.only(right: deviceSize.width / 3),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color(0xff0AA1DD),
                    Color.fromARGB(255, 69, 183, 228)
                  ]),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(120))),
                child: Padding(
                  padding: EdgeInsets.only(
                      top: deviceSize.height / 8, right: deviceSize.width / 8),
                  child: Column(
                    children: [
                      const Text("HI,WELCOME"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [const Text("APPNAME")],
                      )
                    ],
                  ),
                ),
              ),
             
              const SizedBox(
                child: AuthCard(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({super.key});

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.login;
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();

  void _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    if (_authMode == AuthMode.login) {
      await Provider.of<Auth>(context, listen: false)
          .signin(_authData['email']!, _authData['password']!);
    } else {
      await Provider.of<Auth>(context, listen: false)
          .signup(_authData['email']!, _authData['password']!);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.login) {
      setState(() {
        _authMode = AuthMode.signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Container(
          margin:EdgeInsets.symmetric(horizontal:deviceSize.width/3, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
               SizedBox(width: 100, child: Image.asset('assets/images/logo.png'),),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Color(0XFF0AA1DD)),
                  prefixIcon: Icon(
                    Icons.email,
                    color: Color(0XFF0AA1DD),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0XFF0AA1DD), width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0XFF0AA1DD)),
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return 'Invalid email!';
                  }
                  return null;
                },
                onSaved: (value) {
                  _authData['email'] = value!;
                },
              ),
              const Divider(),
              TextFormField(
                decoration: const InputDecoration(
                  fillColor: Color(0xffE8F9FD),
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Color(0XFF0AA1DD)),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Color(0XFF0AA1DD),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0XFF0AA1DD), width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0XFF0AA1DD)),
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                ),
                obscureText: true,
                controller: _passwordController,
                validator: (value) {
                  if (value!.isEmpty || value.length < 5) {
                    return 'Password is too short!';
                  }
                },
                onSaved: (value) {
                  _authData['password'] = value!;
                },
              ),
              if (_authMode == AuthMode.signup)
                TextFormField(
                  enabled: _authMode == AuthMode.signup,
                  decoration:
                      const InputDecoration(labelText: 'Confirm Password'),
                  obscureText: true,
                  validator: _authMode == AuthMode.signup
                      ? (value) {
                          if (value != _passwordController.text) {
                            return 'Passwords do not match!';
                          }
                        }
                      : null,
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: const Text("Forgotton password"),
                    onPressed: () {},
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              if (_isLoading)
                const CircularProgressIndicator()
              else
                RawMaterialButton(
                  onPressed: _submit,
                  fillColor: const Color(0XFF0AA1DD),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 13.0),
                  child:
                      Text(_authMode == AuthMode.login ? 'LOGIN' : 'SIGN UP'),
                ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RawMaterialButton(
                    onPressed: _switchAuthMode,
                    fillColor: const Color(0XFF0AA1DD),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 10),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    child: Text(
                        '${_authMode == AuthMode.login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
                  ),
              
                ],
              ),
               const SizedBox(height: 20,),
                  const Divider(),
                  const Center(child: Text('OR')),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                    SizedBox(width: 40, child: RawMaterialButton(onPressed: (){},shape:const CircleBorder(),child: Image.asset('assets/images/google.png'),)),
                    SizedBox(width: 40, child: RawMaterialButton(onPressed: (){},shape:const CircleBorder(),child: Image.asset('assets/images/fb.png'),)),
                    SizedBox(width: 40, child: RawMaterialButton(onPressed: (){},shape:const CircleBorder(),child: Image.asset('assets/images/twitter.png'),))
                  ],)
            ],
          ),
        ),
      ),
    );
  }
}
