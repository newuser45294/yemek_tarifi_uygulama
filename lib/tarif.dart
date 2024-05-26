class tarif{
  
  String ozellik;
  String content;
  String title;
  String malzemeler;
  String tarih;
  String resim;
  String keyn;
  tarif(this.keyn,this.ozellik,this.content,this.title,this.malzemeler,this.tarih,this.resim);
  factory tarif.fromJson(keyn,Map map){
return tarif(keyn,map["features"],map["content"],map["title"],map["malzemler"],map["tarih"],map["resim"] ?? "https://www.gentas.com.tr/wp-content/uploads/2021/05/3156-koyu-gri_renk_g475_1250x1000_t7okbiqy.jpg");
  }
}