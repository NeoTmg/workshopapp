import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:myworkshop/login.dart';

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
                  validator: (val){
                    if(val != null && val.isEmpty){
                      return "Confirm Password";
                    }
                  },
                ),
                SizedBox(height: 10,),
                RaisedButton(
                  child: Text("Register"),
                    onPressed: (){

                      //start validation


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
    );
  }
}
