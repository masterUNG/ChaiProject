import 'package:chai_project/models/signin_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  // Explicit
  final formKey = GlobalKey<FormState>();
  String user, password;
  String url = 'http://58.137.37.240/dd_backend/TGER/webservice/tiger_score.asmx/Login';


  // Method
  Widget signInButton() {
    return Container(
      child: RaisedButton(
        child: Text('Sign In'),
        onPressed: () {
          print('You Click SignIn');
          if (formKey.currentState.validate()) {
            formKey.currentState.save();

            print('User = $user, Password = $password');
            findData();
          }
        },
      ),
    );
  }

  Future<void> findData()async{

    Data myData = Data(username: user, password: password);
    SignInModel signInModel = SignInModel(module: 'login', target: 'login', data: myData);

    var response = await http.get(url, headers: {'JSON':'application/json'});
    var result = json.decode(response.body);
    print('result = $result');

  }

  Widget userText() {
    return Container(
      margin: EdgeInsets.only(left: 50.0, right: 50.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'User :',
          helperText: 'Type Your User',
        ),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Please Fill User in Blank';
          }
        },onSaved: (String value){
          user = value;
        },
      ),
    );
  }

  Widget passwordText() {
    return Container(
      margin: EdgeInsets.only(left: 50.0, right: 50.0),
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'Password :',
          helperText: 'Type Your Password',
        ),validator: (String value){
          if (value.isEmpty) {
            return 'Please Fill Password in Blank';
          }
        },onSaved: (String value){
          password = value;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            userText(),
            passwordText(),
            signInButton(),
          ],
        ),
      ),
    );
  }
}
