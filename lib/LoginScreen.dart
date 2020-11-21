import 'package:flutter/material.dart';
import 'package:my_world_time_app/User.dart';
import 'package:my_world_time_app/DBUtil.dart';
import 'package:my_world_time_app/main.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username;
  String password;
  DBUtil dbutil ;
  @override
  initState(){
    dbutil = new DBUtil();
    dbutil.createDB();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      centerTitle: true,
        title: Text('Login Screen'),
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (text){
              username=text;
            },
            decoration: InputDecoration(
              hintText: 'UserName'
            ),
          ),
          TextField(
            onChanged: (text){
              password=text;
            },
            decoration: InputDecoration(
                hintText: 'password'
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () async {
                bool isAuthenticated = await dbutil.checkIfAuthenticated(username, password);
                print(isAuthenticated);
                if(isAuthenticated ==true){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => Home(),
                  ));
                }else{
                  print('not authenticated');
                }
                },
                child: CircleAvatar(
                  radius: 70,
                  child: Text('Login'),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: (){
                User newUser = User(userName: username,password: password);
                dbutil.insertIntoDB(newUser);
                },
                child: CircleAvatar(
                  radius: 70,
                  child: Text('Signup'),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
