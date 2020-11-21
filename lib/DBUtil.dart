import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:my_world_time_app/User.dart';

class DBUtil{
  Future<Database> db;
  createDB() async{
    String dbPath = await getDatabasesPath();
    print('dbPath is'+dbPath );
    String fullPath = join(dbPath,'dbDemo.db');
     db = openDatabase(
        fullPath,
     version: 1,
      onCreate: (db,version){
        db.execute(
          "CREATE TABLE IF NOT EXISTS User(username TEXT PRIMARY KEY, password TEXT)",
        );
        print('succsessfully created');
      }
    );
  }

  insertIntoDB(User user) async{
  Database d = await db;
  await d.insert('User', user.convertToMap());
  print('successfully inserted');
  }

  Future<bool> checkIfAuthenticated(String username,String password) async{
    Database d = await db;
    List<Map> list = await d.rawQuery('SELECT * FROM User WHERE username=\''+username+'\' AND password =\''+password+'\'');
    if(list.isEmpty){
      return false;
    }else{
      return true;
    }
  }

}