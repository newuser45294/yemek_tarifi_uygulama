import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yemek_tarifi_uygulama/datas.dart';
import 'package:yemek_tarifi_uygulama/main.dart';
import 'package:yemek_tarifi_uygulama/tarifpanel.dart';

class Panel extends StatefulWidget {
  const Panel({super.key});

  @override
  State<Panel> createState() => _PanelState();
}

class _PanelState extends State<Panel> {
   var widgets = [UserPanel(),TarifPanel()];
    var curindex = 0;
  
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      home : Scaffold(
        appBar : AppBar(
          title: Text("Panel",style : GoogleFonts.robotoSlab(fontWeight: FontWeight.w400)),
          backgroundColor: Colors.yellowAccent,
        ),
        body : widgets[curindex],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.black87,
          backgroundColor: Colors.yellowAccent,
          currentIndex: curindex,
          onTap: (value){
            setState(() {
              curindex = value;
            });
            print(curindex);
          },
          items: [
        BottomNavigationBarItem(icon: Icon(Icons.account_box),label : "hesaplar"),
        BottomNavigationBarItem(icon: Icon(Icons.upload),label : "tarifler")

      ]),)
    );
  }
}
class UserPanel extends StatefulWidget {
  const UserPanel({super.key});

  @override
  State<UserPanel> createState() => _UserPanelState();
}

class _UserPanelState extends State<UserPanel> {
  var ref = FirebaseDatabase.instance.ref().child("User");
   Future<void> adminEkle(var key,String name,var uid) async{
    HashMap<String,Object?> map = HashMap<String,Object?>();
    map["uid"] = uid;
    map["name"] = name;
    map["admin"] = true;
    ref.child("${key}").update(map);

   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : StreamBuilder<DatabaseEvent>(
        stream: ref.onValue,
        builder: (context, snapshot) {
          var list = <datas>[];
          if(snapshot.hasData){
            var data = snapshot.data!.snapshot.value as dynamic;
            data.forEach((key,value){
              var dataz = datas.json(key,value);
              list.add(dataz);
            });
          }
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.yellowAccent,
                borderRadius: BorderRadius.circular(10)
              ),
              child: ListView.builder(itemCount: list.length,itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color:Colors.black),
                        top: BorderSide.none,
                        left: BorderSide.none,
                        right: BorderSide.none
                        )
                    ),
                    child: Row(children: [
                      Text("${list[index].username}",style: GoogleFonts.robotoSlab(fontWeight: FontWeight.w600,color: const Color.fromARGB(255, 116, 114, 109),fontSize: 20)),
                      SizedBox(width: 10,),
                      ElevatedButton(onPressed: (){
                       adminEkle("${list[index].key}",list[index].username, list[index].uid);
                      }, child: Text("Admin Ekle"),style: ElevatedButton.styleFrom(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero
                                ),
                                primary: Colors.white,
                                onPrimary: Colors.black54,
                                maximumSize: Size(150,50),
                                minimumSize: Size(150,50)
                               )),
                      
                    ]),
                  ),
                );
              }),
            ),
          );
        }
      )
    );
  }
}