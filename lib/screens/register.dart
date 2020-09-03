import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tutorial_01/screens/my_service.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //Explicit
  final formkey = GlobalKey<FormState>();
  String nameString, emailString, passwordString;

  //Method
  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  Widget registerBtn() {
    return IconButton(
        icon: Icon(Icons.cloud_upload),
        onPressed: () {
          print('You click Upload');
          if (formkey.currentState.validate()) {
            formkey.currentState.save();
            print('name = $nameString ' +
                'email = $emailString ' +
                'password = $passwordString');
            registerThread();
          }
        });
  }

  Future<void> registerThread() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth
        .createUserWithEmailAndPassword(
        email: emailString, password: passwordString)
        //.then((value) => print('Register success :' + value.toString()))
    .then((value){
      setupDisplayName();
    })
        .catchError((err) {
      String title = err.code;
      String message = err.message;
      print('Error title = $title, message = $message');
      myAlert(title, message);
    });
  }

  Future<void> setupDisplayName() async{
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    if (firebaseAuth.currentUser != null) {
      firebaseAuth.currentUser.updateProfile(displayName: nameString);

      MaterialPageRoute materialPageRoute = MaterialPageRoute(builder: (BuildContext context) => MyService());
      Navigator.of(context).pushAndRemoveUntil(materialPageRoute, (Route<dynamic> route) => false);
    }
  }

  void myAlert(String title, String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: ListTile(
              leading: Icon(
                Icons.add_alert,
                color: Colors.red,
              ),
              title: Text(title),
            ),
            content: Text(message),
            actions: [FlatButton(onPressed: () {
              Navigator.of(context).pop();}, child: Text('OK'))
            ],
          );
        });
  }

  Widget nameTextForm() {
    return TextFormField(
      decoration: InputDecoration(
          icon: Icon(
            Icons.face,
            size: 40,
            color: Colors.purple,
          ),
          labelText: 'Display name : '),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Please fill your name';
        } else {
          return null;
        }
      },
      onSaved: (String value) {
        nameString = value.trim();
      },
    );
  }

  Widget emailTextForm() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          icon: Icon(
            Icons.email,
            size: 40,
            color: Colors.purple,
          ),
          labelText: 'Email : '),
      validator: (String value) {
        if (validateEmail(value)) {
          return null;
        } else {
          return 'Email not correct.';
        }
      },
      onSaved: (String value) {
        emailString = value.trim();
      },
    );
  }

  Widget passwordTextForm() {
    return TextFormField(
      decoration: InputDecoration(
          icon: Icon(
            Icons.lock,
            size: 40,
            color: Colors.purple,
          ),
          labelText: 'Password : '),
      validator: (String value) {
        if (value.length < 6) {
          return 'Password must length greater than 6';
        } else {
          return null;
        }
      },
      onSaved: (String value) {
        passwordString = value.trim();
      },
    );
  }

  Widget registerForm() {
    return Form(
      key: formkey,
      child: ListView(
        padding: EdgeInsets.all(30.0),
        children: [nameTextForm(), emailTextForm(), passwordTextForm()],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade800,
        title: Text('Register'),
        actions: [registerBtn()],
      ),
      body: registerForm(),
    );
  }
}
