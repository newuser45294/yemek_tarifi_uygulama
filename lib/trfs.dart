class trfs{
  var date;
  String? ozellik;
  String? content;
  String? title;
  String? resim;
  var name;
  var malzeme;
  trfs(this.date,this.name,this.malzeme,this.ozellik,this.content,this.title,this.resim);
  factory trfs.jsOn(Map map){
    return trfs(map["date"],map["name"],map["malzeme"],map["features"],map["content"],map["title"],map["resim"] ?? "https://www.gentas.com.tr/wp-content/uploads/2021/05/3156-koyu-gri_renk_g475_1250x1000_t7okbiqy.jpg");
  }
}