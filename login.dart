import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class loginPage extends StatefulWidget{
  @override
  _loginPageState createState() => _loginPageState();
}


class _loginPageState extends State<loginPage> {
  String email;
  String password;

  final formKey = new GlobalKey<FormState>();

  bool validateAndSave(){
    final form = formKey.currentState;
    if (form.validate()){
      form.save();
      return true;
    } else {
      return false;
    }
  }
  void validateAndSubmit() async{
    if (validateAndSave()){
      try {
       // FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
        print('Signed in');

      }
      catch(e){
        print('error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
          title: new Text('Login')
      ),
      body: new Container(
          padding: EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: new InputDecoration(labelText: 'Email'),
                  validator: (value) => value.isEmpty  ? 'Please enter email' : null,
                  onSaved: (value) => password = value,
                ),
                TextFormField(
                  decoration: new InputDecoration(labelText: 'Password'),
                  obscureText: true,
                    validator: (value) => value.isEmpty  ? 'Please enter password' : null,
                  onSaved: (value) => password = value,
                ),
                RaisedButton(
                  onPressed: (){

                  },
                  child: Text('Login', style: new TextStyle(fontSize: 20),

                )),
              ],
            )
          )
      )
    );
  }
}