import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:myworkshop/dashboard.dart';
import 'package:myworkshop/registration.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'global.dart';


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
                      onPressed: ()async{
                         //now first getting login credentials
                        final database = openDatabase(

                            path.join(await getDatabasesPath(), 'workshop.db'),

                            onCreate: (db, version) {
                        // Run the CREATE TABLE statement on the database.
                        return db.execute(
                        'CREATE TABLE Register(id INTEGER PRIMARY KEY, email TEXT, username TEXT, password TEXT)',
                        );
                        },
                        version: 1,
                        );

                        final db = await database;
                        var email = _email.text;
                        var pass = _pass.text;
                        List<Map> result = [];
                        result = await db.rawQuery("select * from Register where email='$email' and password = '$pass'");
                        print(result);
                        if(result.length == 0){
                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid Username and Password.")));

                        }else{
                          global.email = _email.text;
                          global.isLogin = true;
                          global.username = result[0]['username'];
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));
                        }

                      
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
