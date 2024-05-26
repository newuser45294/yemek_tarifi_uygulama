class datas{
  var uid;
  var key;
  bool admin;
  String username;
  datas(this.key,this.uid,this.admin,this.username);
  factory datas.json(key,Map map){
    return datas(key,map["uid"],map["admin"],map["username"]);
  }
}