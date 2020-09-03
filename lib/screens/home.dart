import 'package:flutter/material.dart';
import 'package:tutorial_01/screens/register.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Method
  @override
  void initState(){
    super.initState();

  }

  Future

  Widget showAppName() {
    return Container(
        child: Text(
      "ACare Mall",
      style: TextStyle(
          fontSize: 30.0,
          color: Colors.blue.shade600,
          //fontWeight: FontWeight.bold,
          //fontStyle: FontStyle.italic,
          fontFamily: 'SourceSans Pro'),
    ));
  }

  Widget signUpBtn() {
    return RaisedButton(
      onPressed: () {
        MaterialPageRoute materialPageRoute = MaterialPageRoute(
            builder: (BuildContext buildContext) => Register());
        Navigator.of(context).push(materialPageRoute);
      },
      child: Text('Sign Up'),
    );
  }

  Widget signInBtn() {
    return RaisedButton(
      onPressed: null,
      child: Text('Sign In'),
    );
  }

  Widget showBtn() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        signInBtn(),
        SizedBox(
          width: 4.0,
        ),
        signUpBtn()
      ],
    );
  }

  Widget showLogo() {
    return Container(
        width: 120.0,
        height: 120.0,
        child: Image.asset('images/shopping_cart.png'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            showLogo(),
            showAppName(),
            SizedBox(
              height: 12.0,
            ),
            showBtn()
          ],
        )),
      ),
    );
  }
}
