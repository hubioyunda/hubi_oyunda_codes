class AnalizManager {
  static String hesaplaAnlamaSeviyesi({required int dogruSayisi, required int yanlisSayisi, required int karttaGecirilenSaniye}) {
    int toplamSoru = dogruSayisi + yanlisSayisi;
    if (toplamSoru == 0) return "%0 (Başlanmadı)";
    double basariYuzdesi = (dogruSayisi / toplamSoru) * 100;
    if (karttaGecirilenSaniye < 15) basariYuzdesi -= 10;
    int nihaiSkor = basariYuzdesi.clamp(0, 100).toInt();
    if (nihaiSkor >= 85) return "%$nihaiSkor (Siber Dedektif)";
    if (nihaiSkor >= 60) return "%$nihaiSkor (Gelişmekte Olan)";
    return "%$nihaiSkor (Desteğe İhtiyacı Var)";
  }
}