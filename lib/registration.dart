import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:myworkshop/login.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class register extends StatefulWidget {
  const register({Key? key}) : super(key: key);

  @override
  _registerState createState() => _registerState();
}

class _registerState extends State<register> {

  @override
  void initState(){
    super.initState();
  }

  TextEditingController _email = new TextEditingController();
  TextEditingController _username = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  TextEditingController _conpass = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration"),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/5, left: 30, right: 30),
        child: SingleChildScrollView(
          child: Center(
            child:  Form(
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(hintText: "Email"),
                    controller: _email,
                    validator: (val){
                      if(val != null && val.isEmpty){
                        return "Email";
                      }
                    },
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    decoration: InputDecoration(hintText: "Username"),
                    controller: _username,
                    validator: (val){
                      if(val != null && val.isEmpty){
                        return "Username";
                      }
                    },
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    decoration: InputDecoration(hintText: "Password"),
                    controller: _password,
                    obscureText: true,
                    validator: (val){
                      if(val != null && val.isEmpty){
                        return "Password";
                      }
                    },
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    decoration: InputDecoration(hintText: "Confirm Password"),
                    controller: _conpass,
                    obscureText: true,
                    validator: (val){
                      if(val != null && val.isEmpty){
                        return "Confirm Password";
                      }
                    },
                  ),
                  SizedBox(height: 10,),
                  RaisedButton(
                    child: Text("Register"),
                      onPressed: ()async{

                        //start validation

                        final database = openDatabase(

                            join(await getDatabasesPath(), 'workshop.db'),

                            onCreate: (db, version) {
                        // Run the CREATE TABLE statement on the database.
                        return db.execute(
                        'CREATE TABLE Register(id INTEGER PRIMARY KEY, email TEXT, username TEXT, password TEXT)',
                        );
                        },
                        // Set the version. This executes the onCreate function and provides a
                        // path to perform database upgrades and downgrades.
                        version: 1,
                        );

                        var email = _email.text;
                        var username = _username.text;
                        var pass = _password.text;
                        final db = await database;
                        db.rawQuery("insert into Register(email,username,password)values('$email','$username','$pass')");

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("User Registered Successfully.")));

                        setState(() {
                          _email.text = '';
                          _username.text = '';
                          _password.text = '';
                          _conpass.text = '';
                        });


                        //do Registration API calling process

                      }
                  ),

                  SizedBox(height: 50,),
                  InkWell(
                    child: Text("Have an Account ?"),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => login()));
                    },
                  ),


                ],
              ),
            )
          ),
        ),
      ),
    );
  }
}
