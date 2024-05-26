import 'dart:collection';
import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Edit_Add extends StatefulWidget {
  bool edit;
  String keyn;
  Edit_Add(this.edit,this.keyn);

  @override
  State<Edit_Add> createState() => _Edit_AddState();
}

class _Edit_AddState extends State<Edit_Add> {
  var content = TextEditingController();
  var title = TextEditingController();
  var date = TextEditingController();
  var malzemeler = TextEditingController();
  Future<void> add(String features,String content,String title,String malzemeler,String tarih,String resim) async{
 var ref = FirebaseDatabase.instance.ref("Tarifler");
    HashMap<String,Object?> map = HashMap();
    map["features"] = features;
    map["content"] = content;
    map["title"]= title;
    map["malzemler"] = malzemeler;
    map["tarih"] = tarih;
    map["resim"] = resim;
     ref.push().set(map);
  }
  String pickedUrl = "https://www.gentas.com.tr/wp-content/uploads/2021/05/3156-koyu-gri_renk_g475_1250x1000_t7okbiqy.jpg";
  Future<String> pick() async{
    var picker =await FilePicker.platform.pickFiles();
    var storage =await FirebaseStorage.instance.ref().child("images").child(Random().nextInt(1000000000).toString()).putFile(File(picker!.files.first.path!));
  
    return await storage.ref.getDownloadURL();
  }
  Future<void> update(String key,String features,String content,String title,String malzemeler,String tarih,String resim) async{
     var ref = FirebaseDatabase.instance.ref("Tarifler");
    HashMap<String,Object?> map = HashMap();
    map["features"] = features;
    map["content"] = content;
    map["title"] = title;
    map["malzemeler"] = malzemeler;
    map["tarih"] = tarih;
    map["resim"] = resim;
    ref.child("${key}").update(map);
  }
 var features = ["vejeteryan","hazırlanan","hızlı"];
  var data = "vejeteryan";
  var daten = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home : Scaffold(
        backgroundColor: Colors.yellowAccent,
        body : Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            DropdownButton(value : data,items: features.map<DropdownMenuItem<String>>((e){
              return DropdownMenuItem<String>(child: Text(e),value: e);
            } ).toList(), onChanged: (String? str){
             setState(() {
               data = str!;
             });
            }),
            TextField(controller: content,decoration: InputDecoration(
                      hintText: "title",
                      filled : true,
                        
                      border: OutlineInputBorder(
                        borderSide : BorderSide(color : Colors.black)
                        ),
                      fillColor: Color.fromARGB(100, 255, 225, 225)
                    ),),
                    SizedBox(height: 3,),
            TextField(controller : title,maxLines: 5,decoration: InputDecoration(
                      hintText: "content",
                      filled : true,
                      
                      contentPadding: EdgeInsets.symmetric(vertical:40.0),
                      border: OutlineInputBorder(
                        borderSide : BorderSide(color : Colors.black)
                        ),
                      fillColor: Color.fromARGB(100, 255, 225, 225)
                    ),),
                    SizedBox(height: 3,),
            TextField(controller : malzemeler,decoration: InputDecoration(
                      hintText: "malzemeler",
                      filled : true,
                        
                      border: OutlineInputBorder(
                        borderSide : BorderSide(color : Colors.black)
                        ),
                      fillColor: Color.fromARGB(100, 255, 225, 225)
                    )),
                  
                    SizedBox(height: 5,),
                    GestureDetector(
                      onTap :()async{
                        var picker =await FilePicker.platform.pickFiles();
    var storage =await FirebaseStorage.instance.ref().child("images").child(Random().nextInt(1000000000).toString()).putFile(File(picker!.files.first.path!));
    var ftt = await storage.ref.getDownloadURL();
 
                       setState(() {
                          pickedUrl =  ftt;
                       });
                       print(pickedUrl);
                      },
                      child: Image.network("${pickedUrl}",width : 50,height : 50,fit : BoxFit.cover)),
                      Text("Resim Seçmek İçin Gri Kutuya Bas",style:TextStyle(color : Colors.blueAccent)),
                    SizedBox(height: 5,),
                    TextField(controller : daten,onTap: (){
                showDatePicker(context: context, firstDate: DateTime.now(), lastDate: DateTime(DateTime.now().year + 100),initialDate: DateTime.now());
              },),
             ElevatedButton(onPressed: (){
               widget.edit ? update(widget.keyn,data,content.text,title.text,malzemeler.text,daten.text,pickedUrl) : add(data,content.text,title.text,malzemeler.text,daten.text,pickedUrl);
            }, child: widget.edit ? Text("Edit") : Text("Add"),style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero
                                  ),
                                  primary: Colors.black54,
                                  onPrimary: Colors.white,
                                  maximumSize: Size(250,50),
                                  minimumSize: Size(250,50)
                                 ))]),
        )));
        
        
  } 
}