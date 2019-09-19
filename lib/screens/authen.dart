import 'dart:io';

import 'package:chai_project/models/signin_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:http/http.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  // Explicit
  final formKey = GlobalKey<FormState>();
  String user, password;
  

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
            // findData();
            _makePostRequest();
          }
        },
      ),
    );
  }

  

  Future<void> _makePostRequest() async {
  // set up POST request arguments
  String url = 'http://58.137.37.240/dd_backend/TGER/webservice/tiger_score.asmx/Login';
  Map<String, String> headers = {"Content-type": "application/json"};
  String json = '{"module" : "login","target" : "login","data" : {"username" : "KAM_711","password" : "1"}}';
  // make POST request
  Response response = await post(url, headers: headers, body: json);
  // check the status code for the result
  int statusCode = response.statusCode;
  print('stautscode = $statusCode');
  // this API passes back the id of the new item added to the body
  String body = response.body;
  print('body = $body');
  
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
          }else {
            return null;
          }
        },
        onSaved: (String value) {
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
        ),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Please Fill Password in Blank';
          }
        },
        onSaved: (String value) {
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
