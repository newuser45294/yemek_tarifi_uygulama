import 'dart:collection';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:yemek_tarifi_uygulama/datas.dart';
import 'package:yemek_tarifi_uygulama/main.dart';

class Login extends StatefulWidget {

  Login();

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  
  Future<void> sgnIn(BuildContext con,String email,String password,String name) async{
    var auth = FirebaseAuth.instance.createUserWithEmailAndPassword(email: email , password: password).then((value)  {
      var ref = FirebaseDatabase.instance.ref().child("User");
      HashMap map = HashMap();
      map["uid"] = value.user!.uid;
      map["admin"] = false;
      map["username"] = name;
      ref.push().set(map);
      ref.onValue.listen((event) {
        var data = event.snapshot.value! as dynamic;
        data.forEach((key,valn){
          var model = datas.json(key, valn);
          if(model.uid == value.user!.uid){
            Navigator.push(context,MaterialPageRoute(builder: (context) => MyApp(!model.admin,null,DateTime.now(),"${key}")));
          }
        });
        });
      
      
    });

  }
  Future<void> logIn(BuildContext con, email,String password) async{
   var remsds = FirebaseAuth.instance.signInWithEmailAndPassword(email: email , password: password).then(
    (value){
      var ref = FirebaseDatabase.instance.ref().child("User");
      ref.onValue.listen((event) {
        var data = event.snapshot.value! as dynamic;
        data.forEach((key,valn){
          var model = datas.json(key, valn);
          if(model.uid == value.user!.uid){
            Navigator.push(context,MaterialPageRoute(builder: (context) => MyApp(!model.admin,null,DateTime.now(),"${key}")));
          }
        });
        });
    }
   );

  }
  var email = TextEditingController();
  var username = TextEditingController();
  var password = TextEditingController();
  var tex = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellowAccent,
        body : Center(
          child: Container(
            width: 300,
            height: 350,
            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                
                children: [
                SizedBox(
                  height: 50,
                  child: TextField(controller: email,minLines: 1,decoration: InputDecoration(
                    hintText: "Email",
                    filled : true,
                      
                    border: OutlineInputBorder(
                      borderSide : BorderSide(color : Colors.black)
                      ),
                    fillColor: Color.fromARGB(100, 255, 225, 225)
                  ),),
                ),
                SizedBox(height: 10,),
                 SizedBox(
                  height: 50,
                  child: TextField(controller: password,minLines: 1,decoration: InputDecoration(
                    hintText: "Password",
                    filled : true,
                      
                    border: OutlineInputBorder(
                      borderSide : BorderSide(color : Colors.black)
                      ),
                    fillColor: Color.fromARGB(100, 255, 225, 225)
                  ),),
                ),
                GestureDetector(
                  onTap : (){
                  showDialog(context: context, builder: (context) {
                    return AlertDialog(title :Text("Yeni Şifre"),
                    content: Column(children: [
                      TextField(controller: tex,
                      decoration: InputDecoration(hintText: "Email")
                       )
                    ]),
                    actions : [
                      
                      ElevatedButton(onPressed: (){
                  var data = FirebaseAuth.instance.sendPasswordResetEmail(email: tex.text);
                        Navigator.pop(context);

                      }, child: Text("Gönder"))
                    ],);
                  });
                   
                  },
                  child: Text("Şifre Mi Unuttum",style: TextStyle(color : Colors.blue),)
                  ),

                  SizedBox(height: 10,),
                 SizedBox(
                  height: 50,
                  child: TextField(controller: username,minLines: 1,decoration: InputDecoration(
                    hintText: "Username",
                    filled : true,
                      
                    border: OutlineInputBorder(
                      borderSide : BorderSide(color : Colors.black)
                      ),
                    fillColor: Color.fromARGB(100, 255, 225, 225)
                  ),),
                ),
                SizedBox(height: 10,),
               ElevatedButton(onPressed: (){
                 sgnIn(context,email.text.trim(),password.text, username.text);
                
                               }, child: Text("Sign In"),style: ElevatedButton.styleFrom(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero
                                ),
                                primary: Colors.black54,
                                onPrimary: Colors.white,
                                maximumSize: Size(250,50),
                                minimumSize: Size(250,50)
                               ),),
                SizedBox(height : 20),
               ElevatedButton(onPressed: (){
                logIn(context,email.text.trim(), password.text);
                 
                               }, child: Text("Log In"),style: ElevatedButton.styleFrom(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero
                                ),
                                primary: Colors.black54,
                                onPrimary: Colors.white,
                                maximumSize: Size(250,50),
                                minimumSize: Size(250,50)
                               ),)
              ],),
            ),
          ),
        ));
  }
}