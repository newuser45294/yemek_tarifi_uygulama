import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yemek_tarifi_uygulama/detaylar.dart';
import 'package:yemek_tarifi_uygulama/trfs.dart';

class EklenenTarifler extends StatefulWidget {
  String keyn;
  String date;
  EklenenTarifler(this.keyn,this.date);

  @override
  State<EklenenTarifler> createState() => _EklenenTariflerState();
}

class _EklenenTariflerState extends State<EklenenTarifler> {
  @override
  void initState() {
    print("${widget.keyn}");
    super.initState();
  }
  var controller = TextEditingController();
  var items = ["vejeteryan","hazırlanan","hızlı"];
  var item = "vejeteryan";
  var date = DateTime.now();
  var cnt = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var ref = FirebaseDatabase.instance.ref("User/${widget.keyn}/Tarifler");
    var list = <trfs>[];
    Future<void> tarifGit(String? content,String? title,String? features) async{
      String? baslik = title ?? "Boş";
      String? featureses = features ?? "Boş";
     Navigator.push(context,MaterialPageRoute(builder: (event) => Detaylar(content ?? "Boş",baslik, featureses)));
    }
    return MaterialApp(
      home : Scaffold(
        backgroundColor: const Color.fromARGB(255, 116, 114, 109),
        appBar:  AppBar(
          backgroundColor: Colors.yellowAccent,
          actions : [
          
            SizedBox(
              width : 200,
              height: 50,
              child: TextField(controller :cnt,onTap: ()async{
                DateTime? pickedDate = await showDatePicker(context: context, firstDate: DateTime.now(), lastDate: DateTime(DateTime.now().year + 100),initialDate: date,currentDate: date);
                setState(() {
                  cnt.text = pickedDate.toString();
                });
                Navigator.push(context,MaterialPageRoute(builder: (context) => EklenenTarifler(widget.keyn, pickedDate.toString())));
              }),
            )
          ]
            ),
      body : SingleChildScrollView(
        child: Column(children: [
          Row(
            children: [
          StreamBuilder<DatabaseEvent>(
            stream: ref.onValue,
            builder: (context, snapshot) {
              if(snapshot.hasData && snapshot.data!.snapshot.value != null){
                var data = snapshot.data!.snapshot.value as dynamic;
                data.forEach((key,value){
                var dtn = trfs.jsOn(value);
                print(widget.date);
                 if(widget.date.substring(0,9) == dtn.date.toString().substring(0,9)){
                    list.add(dtn);
                 }
              

            
              
              
                });
              }
          
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  itemCount: list.length,
                  shrinkWrap: true,itemBuilder: (context,index){
                  return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color : Colors.white,
                          shape : RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                          elevation: 8,
                          child: Container(
                          
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color : Colors.white
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.network("${list[index].resim}",width : 200,height: 105,fit : BoxFit.cover),
                                SizedBox(height: 10,),
                                 Row(
                      children: [
                         
                        Text("${list[index].name}",style : GoogleFonts.robotoSlab(color: Colors.yellowAccent,fontSize : 26)),
                        SizedBox(width: 2),
                        ElevatedButton(onPressed: (){
                        tarifGit(list[index].content,list[index].title,list[index].ozellik);
                        }, child: Text("Tarif"),style: ElevatedButton.styleFrom(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero
                                ),
                                primary: Colors.black54,
                                onPrimary: Colors.white,
                                maximumSize: Size(100,50),
                                minimumSize: Size(100,50)
                               )),
                               SizedBox(width: 5,),
                        ElevatedButton(onPressed: (){
                          var malzemeList = list[index].malzeme.toString().split(",");
                             showDialog(context: context, builder: (context){
                                  return AlertDialog(content: ListView.builder(itemCount: malzemeList.length,itemBuilder: (context,index){
                                    return Text("${list[index].name}");
                                  }),actions: [
                                    ElevatedButton(onPressed: (){
                                      Navigator.pop(context);
                                    }, child: Text("Çık"))
                                  ],);
                             });
                        }, child: Text("Malzemeler"),style: ElevatedButton.styleFrom(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero
                                ),
                                primary: Colors.black54,
                                onPrimary: Colors.white,
                                maximumSize: Size(130,50),
                                minimumSize: Size(130,50)
                               ))
                    
                      ],
                    ),         
                              ],
                            ),
                          ),
                        ),
                      );
                } 
                ),
              );
            }
          )
        ])
            ]),
      )
    ));
  }
}