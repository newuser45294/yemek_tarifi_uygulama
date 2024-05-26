import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yemek_tarifi_uygulama/datas.dart';
import 'package:yemek_tarifi_uygulama/detaylar.dart';
import 'package:yemek_tarifi_uygulama/edit_add.dart';
import 'package:yemek_tarifi_uygulama/eklenentarifler.dart';
import 'package:yemek_tarifi_uygulama/firebase_options.dart';
import 'package:yemek_tarifi_uygulama/logIn.dart';
import 'package:yemek_tarifi_uygulama/tarif.dart';
import 'package:yemek_tarifi_uygulama/trfs.dart';
import 'package:yemek_tarifi_uygulama/panel.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const Anasayfa());
}
class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home : Login(),
      debugShowCheckedModeBanner: false,
      );
  }
}


class MyApp extends StatefulWidget {
  bool admin;
  var uid;
  var time;
  String keyn;
  MyApp(this.admin,this.uid,this.time,this.keyn);

  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  var controller = TextEditingController();
  var date = DateTime.now();
  var items = ["vejeteryan","hazırlanan","hızlı"];
  var item = "vejeteryan";
  var cnten = TextEditingController();
  var ref = FirebaseDatabase.instance.ref().child("Tarifler");
  var list = <tarif>[];
  Future<void> tarifEkle(var tarifKey,String date,String name,String malzeme,String features,String title,String content,String tarih,String resim) async{
   var tarifler = FirebaseDatabase.instance.ref("User");
   var dbn = FirebaseDatabase.instance.ref("User/${widget.keyn}/Tarifler");
    HashMap map = HashMap();
    map["date"] = date;
    map["features"] = features;
    map["content"] = content;
    map["title"] = title;
    map["name"] = name;
    map["malzemeler"] = malzeme;
    map["resim"] = resim;
    await dbn.push().set(map);
  

  }
  var isSearched = false;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color.fromARGB(255, 116, 114, 109),
       appBar: AppBar(
          backgroundColor: Colors.yellowAccent,
          actions: [
    SizedBox(
      width : 100,
      height: 50,
      child: TextField(controller: cnten,onTap: ()async {
                    var pickedDate = await showDatePicker(context: context, firstDate: DateTime.now(), lastDate: DateTime(DateTime.now().year + 50 ),initialDate: date);
                     setState(() {
                       cnten.text = pickedDate.toString();
                     });
                  },),
    ),
            Visibility(
              visible: isSearched,
              child: SizedBox(
                width : 200,
                height: 40,
                child: TextField(
                  controller: controller ,
                  decoration: InputDecoration(
                    hintText : "Ara",
                    filled: true,
                    fillColor: Colors.white,
                    border : OutlineInputBorder(borderRadius: BorderRadius.zero,borderSide: BorderSide.none)
                  ),
                ),
              ),
            ),
            ElevatedButton(onPressed: (){
              
             setState(() {
              isSearched = true;
               list = list.where((element) => element.title.contains(controller.text) && element.ozellik == item).toList();
             });
              
            }, child: Icon(Icons.search,color : Colors.black54),style : ElevatedButton.styleFrom(
              elevation: 0,
              primary : Colors.yellowAccent,
            
              shape : RoundedRectangleBorder(
                side : BorderSide.none,
                borderRadius: BorderRadius.zero
              )
            )),
            
            PopupMenuButton<String>(itemBuilder: (context){
              return  [
                 PopupMenuItem(child: Text("Eklenen Tarifler"),onTap: (){
                  print("Tıklandı");
                 var ref = FirebaseDatabase.instance.ref("User");
                 ref.once().then((value){
                  
             Navigator.push(context,MaterialPageRoute(builder: (context) => EklenenTarifler("${widget.keyn}","${DateTime.now()}")));
                
                });
      
                 }),
          
              PopupMenuItem(enabled:!widget.admin,child: Text("Panel"),onTap: (){
                 Navigator.push(context,MaterialPageRoute(builder: (context) => Panel()));
                },),
               ];
                 
                },)
          ]),
        body : SingleChildScrollView(
          child: Center(
            child: Column(children: [
              DropdownButton<String>(underline : SizedBox(),dropdownColor: Colors.black87,style : GoogleFonts.robotoSlab(color : Colors.yellowAccent)
              , items: items.map<DropdownMenuItem<String>>((e){
                return DropdownMenuItem<String>(child: Text(e),value : e);
              }).toList() , onChanged: (String? s){
                setState(() {
                  item = s!;
                });
              }),
              StreamBuilder<DatabaseEvent>(
                stream: ref.onValue,
                builder: (context, snapshot) {
                  
                  if(snapshot.hasData && snapshot.data!.snapshot.value != null){
                    var dataz = snapshot.data!.snapshot.value as dynamic;
                    dataz.forEach((key,value){
                    var dtn = tarif.fromJson(key,value);
                    list.add(dtn);
                  
                    });
                    list = list.where((element) => element.ozellik == item).toList();
                  }
                  return ListView.builder( physics:NeverScrollableScrollPhysics(),scrollDirection: Axis.vertical,shrinkWrap: true,itemCount: list.length,itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color : Colors.white,
                        shape : RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                        elevation: 8,
                        child: Container(
                        
                          height: 300,
                          width: 500,
                          decoration: BoxDecoration(
                            color : Colors.white
                          ),
                          child:Column(
                            children: [
                              Image.network(list[index].resim,width: 200,height: 170,fit:BoxFit.cover),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("${list[index].title}",style : GoogleFonts.robotoSlab(color: Colors.yellowAccent,fontSize : 26)),
                                  SizedBox(width : 10),
                                  GestureDetector(
                                      onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => Detaylar(
                                                                 list[index].content,
                                                                 list[index].title,
                                                                 list[index].ozellik
                                                                
                                                               )));
                                                                },
                                                                child: Text("Detaylar",style : GoogleFonts.robotoSlab(color :Colors.lightGreenAccent[400]))),
                                  SizedBox(width: 40,),
                                    ElevatedButton(onPressed: (){
                                     tarifEkle(list[index].keyn,date.toString(),list[index].title,list[index].malzemeler,list[index].ozellik,list[index].content,list[index].content,date.toLocal().toString(),list[index].resim);
                                    },child: Text("Tarif Ekle"),style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero
                                  ),
                                  primary: Colors.black54,
                                  onPrimary: Colors.white,
                                  maximumSize: Size(100,50),
                                  minimumSize: Size(100,50)
                                 ))
                                                
                                ],
                              ),
                                
                            ],
                          ),
                        ),
                      ),
                    );
                  } 
                  );
                }
              )
            ],),
          ),
        )
    );
  }
}


