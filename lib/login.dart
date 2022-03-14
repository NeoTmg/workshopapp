import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:myworkshop/registration.dart';


class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {

  final GlobalKey<FormState> _key = GlobalKey();
  TextEditingController _email = new TextEditingController();
  TextEditingController _pass = new TextEditingController();



  //now creating dialog box

  void mydialog(String msg){
    showDialog(
      barrierDismissible: false,
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("Workshop App"),
          content: Text(msg),
          actions: <Widget>[
            FlatButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text("OK")
            )
          ]
        )
    );
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('LOGIN'),

      ),
      body: Padding(
        padding: EdgeInsets.only(top: 0,left: 30, right: 30),
        child: Center(
          child: SingleChildScrollView(
            child: Form(

              key: _key,
              child: Column(

                children: [
                  TextFormField(
                    decoration: InputDecoration(hintText: "Email"),
                    controller : _email,
                    validator: (val){

                      if(val != null && val.isEmpty){
                          return "Email";
                      }
                    },
                  ),

                  SizedBox(height: 10,),

                  TextFormField(
                    decoration: InputDecoration(hintText: "Password"),
                    controller : _pass,
                    obscureText : true,

                    keyboardType: TextInputType.emailAddress,
                    validator: (val){
                      if(val != null && val.isEmpty){
                        return "Password ";
                      }
                    },
                  ),
                  SizedBox(height: 20,),

                  RaisedButton(
                      child: Text("Login"),
                      onPressed: (){
                         //now first getting login credentials


                      
                      }
                  ),

                  SizedBox(height: 70,),
                  RichText(

                    text: TextSpan(
                      children: [
                        new TextSpan(
                            text: "Don't have Account ? ",
                          style: TextStyle(color: Colors.black, fontSize: 16)
                        ),
                        new TextSpan(
                            text: "Register",
                            style: TextStyle(color: Colors.blue,fontSize: 16),
                            recognizer: TapGestureRecognizer()..onTap = (){
                              // Navigator.push(context, MaterialPageRoute(builder: (context) => register()));
                              Navigator.push(context, MaterialPageRoute(builder: (context) => register()));
                            }
                        )
                      ]
                    ),

                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
