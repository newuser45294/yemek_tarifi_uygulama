import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Detaylar extends StatefulWidget {
  String content;
  String? title;
  String? features;
  Detaylar(this.content,this.title,this.features);

  @override
  State<Detaylar> createState() => _DetaylarState();
}

class _DetaylarState extends State<Detaylar> {
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
                Text("${widget.title}",style: GoogleFonts.robotoSlab(fontWeight: FontWeight.w600,color: Colors.yellowAccent,fontSize: 32)),
                Text("${widget.content}",style: GoogleFonts.robotoSlab(fontWeight: FontWeight.w300,color: const Color.fromARGB(255, 116, 114, 109),fontSize: 20)),
                Text("${widget.features}",style: GoogleFonts.robotoSlab(fontWeight: FontWeight.w300,color: const Color.fromARGB(255, 116, 114, 109),fontSize: 20))
              ],),
            ),
          ),
        ));
  }
}