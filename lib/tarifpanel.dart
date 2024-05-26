import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yemek_tarifi_uygulama/detaylar.dart';
import 'package:yemek_tarifi_uygulama/edit_add.dart';
import 'package:yemek_tarifi_uygulama/tarif.dart';

class TarifPanel extends StatefulWidget {
  const TarifPanel({super.key});

  @override
  State<TarifPanel> createState() => _TarifPanelState();
}

class _TarifPanelState extends State<TarifPanel> {
 var ref = FirebaseDatabase.instance.ref("Tarifler");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
        body : StreamBuilder<DatabaseEvent>(
          stream: ref.onValue,
          builder: (context, snapshot) {
            var list = <tarif>[];
            if(snapshot.hasData){
              var data = snapshot.data!.snapshot.value as dynamic;
              data.forEach((key,value){
                var dataz = tarif.fromJson(key,value);
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
                      height: 200,
                      width : MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color:Colors.black),
                          top: BorderSide.none,
                          left: BorderSide.none,
                          right: BorderSide.none
                          )
                      ),
                      child:Column(
                        children: [
                          Image.network(list[index].resim,width : 200,height :125 ,fit : BoxFit.cover),
                          SizedBox(height: 10,),
                          Row(children: [
                            Text("${list[index].title}",style: GoogleFonts.robotoSlab(fontWeight: FontWeight.w600,color: const Color.fromARGB(255, 116, 114, 109),fontSize: 20)),
                            SizedBox(width: 10,),
                            ElevatedButton(onPressed: (){
                             Navigator.push(context,MaterialPageRoute(builder: (context) => Edit_Add(true,"${list[index].keyn}")));
                            }, child: Text("Edit"),style: ElevatedButton.styleFrom(
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
                        ],
                      ),
                    ),
                  );
                }),
              ),
            );
          },

        ),
        floatingActionButton: FloatingActionButton(onPressed: (){
          
          
          Navigator.push(context,MaterialPageRoute(builder: (context) => Edit_Add(false,"")));
        },child: Icon(Icons.add),),
      );
  }
}
