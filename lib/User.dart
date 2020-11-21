class User{
  String userName;
  String password;

  User({this.userName,this.password});

  Map<String,dynamic> convertToMap(){
    return {
      'username':userName,
      'password':password
    };
  }
}