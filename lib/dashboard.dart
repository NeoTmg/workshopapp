import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myworkshop/Model/Test.dart';
import 'package:myworkshop/global.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;


class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        // automaticallyImplyLeading: false,
      ),
      drawer: new Drawer(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(height: 10,),
             ListTile(
               title: Text("Welcome to Workshop App", style: TextStyle(fontSize: 20),),
             ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [

              Center(
                child: Text("Welcome "),
              ),
              Text("Data From Local Database "),
              SingleChildScrollView(
                child: Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: FutureBuilder(
                    future: getUserlist(),
                      builder: (context, AsyncSnapshot mydata){
                        if(mydata.data == null){
                          return Center(child: CircularProgressIndicator(),);
                        }else{
                          // final data = mydata.data as List<Map<String, dynamic>>;
                          return ListView.builder(
                              itemCount: mydata.data.length,
                              itemBuilder: (context, int index){
                                return ListTile(
                                  title: Text(mydata.data[index]['username']),
                                  subtitle: Text(mydata.data[index]['username']),
                                );
                              }
                          );
                        }
                      }
                  ),
                ),
              ),
              Text("Fetching Data through API "),
              SingleChildScrollView(
                child: Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: FutureBuilder(
                      future: getDataFromAPI(),
                      builder: (BuildContext context,AsyncSnapshot mydata){
                        if(mydata.data == null){
                          return Center(child: CircularProgressIndicator(),);
                        }else{
                          // final data = mydata.data as List<Map<String, dynamic>>;
                          return ListView.builder(
                              itemCount: mydata.data.length,
                              itemBuilder: (context, int index){
                                return ListTile(
                                  title: Text((mydata.data[index].id).toString()),
                                  subtitle: Text(mydata.data[index].title),
                                );
                              }
                          );
                        }
                      }
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );

  }
  Future<List> getUserlist()async{
    final database = openDatabase(

      join(await getDatabasesPath(), 'workshop.db'),

      version: 1,
    );
    final db = await database;
    List<Map> result = [];
    result = await db.rawQuery("select * from Register");
    return result;

  }

  Future<List<Test>> getDataFromAPI()async{

    final response = await http.get(Uri.parse("https://my-json-server.typicode.com/typicode/demo/posts"));
    if(response.statusCode == 200){
      
      final List<Test> data = testFromJson(response.body);
      return data;
    }

    return <Test>[];
    // return result;

  }
}
