import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:hubi_oyunda/core/shared_prefs_helper.dart';
import 'package:hubi_oyunda/core/ai_service.dart';

class DosyaVeHafizaDesteEkrani extends StatefulWidget {
  const DosyaVeHafizaDesteEkrani({super.key});
  @override
  State<DosyaVeHafizaDesteEkrani> createState() => _DosyaVeHafizaDesteEkraniState();
}

class _DosyaVeHafizaDesteEkraniState extends State<DosyaVeHafizaDesteEkrani> {
  final List<Map<String, String>> kartlar = [
    {'on': 'Bilgisayardaki fotoğraflarimizi, şarkılarımızı veya ödevlerimizi aradığımızda kolayca bulabilmek için içine koyduğumuz dijital kutulara ne ad verilir?', 'arka': 'Klasör!', 'hubi': '💡 Klasörler, bilgisayarın içindeki fotoğrafları, ödevleri ve belgeleri türlerine göre gruplayıp düzenli tutmamızı sağlayan dijital dosya kutularıdır.'},
    {'on': 'Bir dosyanın ne dosyası olduğunu anlamamızı sağlayan dosya uzantılarına 3 örnek?', 'arka': '.mp3 (müzik), .jpg (fotoğraf), .pdf (yazı).', 'hubi': '💡 Dosya uzantısı, bir dosyanın adının sonundaki noktadan sonra gelen harflerdir ve dosyanın türünü belirler.'},
    {'on': 'RAM ile Sabit Disk arasındaki en büyük fark nedir?', 'arka': 'RAM geçici hafızadır, Sabit Disk kalıcıdır.', 'hubi': '💡 RAM, bilgisayar açıkken çalışan programların verilerini tutan çok hızlı ama geçici bir hafızadır; elektrik kesilince silinir.'},
    {'on': 'Geri Dönüşüm Kutusu\'na gönderilen dosya tamamen silinmiş olur mu?', 'arka': 'Hayır! Kutuyu boşaltmak gerekir.', 'hubi': '💡 Bilgisayardan silinen dosyalar doğrudan yok olmaz, Geri Dönüşüm Kutusu\'na taşınır. Kutu boşaltılana kadar diskte yer kaplar.'},
    {'on': 'Masaüstündeki küçük ok işaretli simgelere ne denir?', 'arka': 'Kısayol!', 'hubi': '💡 Kısayol, çok derin klasörlerin içindeki bir ana dosyaya veya oyuna masaüstünden tek tıkla ulaşabilmemiz için oluşturulan simgelerdir.'},
    {'on': 'Büyük dosyaları daha hızlı göndermek için küçülten sisteme ne denir?', 'arka': 'Dosya Sıkıştırma (Zip/Rar)!', 'hubi': '💡 Dosya sıkıştırma (Zip/Rar), büyük boyutlu dosya ve klasörleri dijital bir bavula koyup sıkıştırarak boyutlarını küçültme işlemidir.'},
    {'on': 'Önemli dosyaları kaybolmaya karşı kopyalayıp saklamaya ne denir?', 'arka': 'Yedekleme (Backup)!', 'hubi': '💡 Yedekleme, bilgisayarın veya telefonun bozulması riskine karşı içindeki önemli fotoğraf ve belgelerin birer kopyasını kaydetmektir.'},
    {'on': 'İçinde mekanik parça olmayan, ışık hızında çalışan yeni nesil disklere ne denir?', 'arka': 'SSD!', 'hubi': '💡 SSD, eski nesil sabit disklere (HDD) göre içinde dönen mekanik hiçbir parça barındırmayan yeni nesil kalıcı hafızadır.'},
    {'on': 'Dosyaları internette sakma teknolojisine ne denir?', 'arka': 'Bulut Depolama!', 'hubi': '💡 Bulut depolama, dosyaları kendi cihazımızda taşımak yerine internet üzerindeki dev ve güvenli veri merkezlerinde saklama teknolojisidir.'},
    {'on': 'Megabayt ve Gigabayt\'tan büyük olan hafıza birimi?', 'arka': 'Terabayt (TB)!', 'hubi': '💡 Terabayt (TB), dijital verilerin boyutunu ölçen devasa bir hafıza birimidir. 1 Terabayt tam 1024 Gigabayt (GB) eder.'},
  ];

  int suAnkiKartIndex = 0;
  bool oyunBasladiMi = false;
  bool kartDonduMu = false;
  bool aiYukleniyorMi = false;
  final Color maviTemaRengi = const Color(0xffA0C4FF);

  void _hubiAIYardimGoster() async {
    setState(() => aiYukleniyorMi = true);
    try {
      String aiIpucu = await AIServisi.ipucuAl(soru: kartlar[suAnkiKartIndex]['on']!, dogruCevap: kartlar[suAnkiKartIndex]['arka']!);
      _diyalogAc(aiIpucu);
    } catch (e) {
      _diyalogAc(kartlar[suAnkiKartIndex]['hubi']!);
    } finally {
      setState(() => aiYukleniyorMi = false);
    }
  }

  void _diyalogAc(String mesaj) {
    showDialog(context: context, builder: (context) => AlertDialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)), title: const Text("💡 Hubi'nin Notu", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)), content: Text(mesaj, style: const TextStyle(fontSize: 18)), actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("Anladım!", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xffE0EAFC), Color(0xffA0C4FF)], begin: Alignment.topLeft, end: Alignment.bottomRight)), child: Column(children: [
        AppBar(title: const Text('Dosya ve Hafıza', style: TextStyle(color: Color(0xff2A2D34), fontWeight: FontWeight.bold, fontSize: 24)), backgroundColor: Colors.transparent, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xff2A2D34)), onPressed: () => Navigator.pop(context))),
        Expanded(child: Center(child: SizedBox(width: 400, height: 500, child: Stack(alignment: Alignment.center, children: [
          ...List.generate(kartlar.length, (index) {
            int tersIndex = (kartlar.length - 1) - index;
            if (oyunBasladiMi && index == suAnkiKartIndex) return const SizedBox.shrink();
            return AnimatedOpacity(duration: const Duration(milliseconds: 400), opacity: oyunBasladiMi ? 0.0 : 1.0, child: Transform(alignment: Alignment.center, transform: Matrix4.identity()..rotateZ((tersIndex - 2) * -0.06), child: Container(margin: EdgeInsets.only(left: (60 + (tersIndex * -22.0) + 30.0).clamp(0.0, 500.0), top: (70 + (tersIndex * -18.0) + 20.0).clamp(0.0, 500.0)), width: 210, height: 300, decoration: BoxDecoration(color: maviTemaRengi, borderRadius: BorderRadius.circular(22), border: Border.all(color: const Color(0xff2A2D34), width: 3)), child: Center(child: Text("${index + 1}. Kart", style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Color(0xff2A2D34)))))));
          }),
          AnimatedPositioned(duration: const Duration(milliseconds: 550), curve: Curves.easeOutCubic, left: oyunBasladiMi ? 50 : 95.0, top: oyunBasladiMi ? 50 : 80.0, child: AnimatedSwitcher(duration: const Duration(milliseconds: 600), child: SizedBox(key: ValueKey(suAnkiKartIndex), width: oyunBasladiMi ? 310 : 210, height: oyunBasladiMi ? 440 : 300, child: oyunBasladiMi ? _buildAktifKart() : _buildDesteTetiklayiciKart()))),
        ])))),
        if (oyunBasladiMi && kartDonduMu) _buildTekSiradakiKartButonu(),
        const SizedBox(height: 30),
      ])),
    );
  }

  Widget _buildDesteTetiklayiciKart() => GestureDetector(onTap: () => setState(() { oyunBasladiMi = true; suAnkiKartIndex = 0; kartDonduMu = false; }), child: Container(decoration: BoxDecoration(color: maviTemaRengi, borderRadius: BorderRadius.circular(22), border: Border.all(color: const Color(0xff2A2D34), width: 3)), child: const Icon(Icons.help_center_rounded, size: 90, color: Color(0xff2A2D34))));
  Widget _buildAktifKart() => GestureDetector(onTap: () => setState(() => kartDonduMu = !kartDonduMu), child: TweenAnimationBuilder(tween: Tween<double>(begin: 0, end: kartDonduMu ? math.pi : 0), duration: const Duration(milliseconds: 400), builder: (context, double aci, child) { final arkasiGozukuyorMu = aci >= math.pi / 2; return Transform(alignment: Alignment.center, transform: Matrix4.identity()..setEntry(3, 2, 0.001)..rotateY(aci), child: Container(decoration: BoxDecoration(color: arkasiGozukuyorMu ? Colors.white : maviTemaRengi, borderRadius: BorderRadius.circular(28), border: Border.all(color: const Color(0xff2A2D34), width: 3.5)), child: Transform(alignment: Alignment.center, transform: arkasiGozukuyorMu ? (Matrix4.identity()..rotateY(math.pi)) : Matrix4.identity(), child: Padding(padding: const EdgeInsets.all(12), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text("${suAnkiKartIndex + 1}. Kart", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Color(0xff2A2D34))), const SizedBox(height: 10), Expanded(child: Center(child: Text(arkasiGozukuyorMu ? kartlar[suAnkiKartIndex]['arka']! : kartlar[suAnkiKartIndex]['on']!, textAlign: TextAlign.center, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xff2A2D34))))), if (arkasiGozukuyorMu) Padding(padding: const EdgeInsets.only(bottom: 8.0), child: aiYukleniyorMi ? const CircularProgressIndicator() : ElevatedButton.icon(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff2A2D34), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10)), onPressed: _hubiAIYardimGoster, icon: const Icon(Icons.hub_rounded), label: const Text("HUBİ'YE SOR", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))))]))))); }));
  Widget _buildTekSiradakiKartButonu() { bool sonKartMi = suAnkiKartIndex == kartlar.length - 1; return Padding(padding: const EdgeInsets.symmetric(horizontal: 40.0), child: InkWell(onTap: () { if (!sonKartMi) { setState(() { suAnkiKartIndex++; kartDonduMu = false; }); } else { Navigator.push(context, MaterialPageRoute(builder: (context) => const SoruHaritasiDosya())); } }, child: Container(padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20), decoration: BoxDecoration(color: sonKartMi ? Colors.white : maviTemaRengi, borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xff2A2D34), width: 3)), child: Center(child: Text(sonKartMi ? 'SORU HARİTASINA GİT 🗺️' : 'SIRADAKİ KART ➡️', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xff2A2D34))))))); }
}

class SoruHaritasiDosya extends StatefulWidget { const SoruHaritasiDosya({super.key}); @override State<SoruHaritasiDosya> createState() => _SoruHaritasiDosyaState(); }
class _SoruHaritasiDosyaState extends State<SoruHaritasiDosya> {
  @override
  Widget build(BuildContext context) { 
    int anlikToplamPuan = SharedPrefsHelper.getPuan();
    return Scaffold(body: Container(decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xffE3F2FD), Color(0xffA0C4FF)], begin: Alignment.topLeft, end: Alignment.bottomRight)), child: Column(children: [AppBar(title: const Text("Soru Haritası"), backgroundColor: Colors.transparent, elevation: 0, actions: [Padding(padding: const EdgeInsets.all(15), child: Text("🏆 $anlikToplamPuan XP", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Color(0xff2A2D34))))]), Expanded(child: ListView.builder(itemCount: 10, itemBuilder: (context, i) { bool kilitliMi = i > (SharedPrefsHelper.getLevel("Dosya") - 1); return GestureDetector(onTap: () async { if (!kilitliMi) { await Navigator.push(context, MaterialPageRoute(builder: (context) => SoruDetayDosya(seviye: i + 1, onBasari: (p) {
      SharedPrefsHelper.setLevel("Dosya", i + 2); 
      SharedPrefsHelper.puanArttir(p).then((_) { setState(() {}); });
    }))); setState(() {}); } }, child: Container(margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 30), padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20), decoration: BoxDecoration(color: kilitliMi ? Colors.grey[400] : Color.lerp(const Color(0xffA0C4FF), const Color(0xffB9FBC0), i / 9), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white, width: 3)), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(kilitliMi ? Icons.lock : Icons.star, color: Colors.white, size: 35), const SizedBox(width: 15), Text("SEVİYE ${i + 1}", style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.white))]))); }))]))); }
}

class SoruDetayDosya extends StatefulWidget { final int seviye; final Function(int) onBasari; const SoruDetayDosya({super.key, required this.seviye, required this.onBasari}); @override State<SoruDetayDosya> createState() => _SoruDetayDosyaState(); }
class _SoruDetayDosyaState extends State<SoruDetayDosya> {
  int puan = 15; bool sAiYukleniyor = false;
  final List<Map<String, dynamic>> sorular = [
    {'soru': 'Dijital kutulara ne ad verilir?', 'siklar': ['RAM', 'Modem', 'Klasör', 'Site'], 'dogru': 2, 'cevap': 'Klasör', 'ipucu': '💡 Dağınık odandaki tüm oyuncakları ortalıkta bırakmak yerine, hepsini koyduğumuz o kutuları düşün.'},
    {'soru': '.mp3 uzantısı neyi anlatır?', 'siklar': ['Fotoğraf', 'Müzik', 'Yazı', 'Video'], 'dogru': 1, 'cevap': 'Müzik', 'ipucu': '💡 Kulaklığını takıp en sevdiğin şarkıyı açtığında aslında bu uzantıya sahip bir dosyayı oynatıyorsun!'},
    {'soru': 'Elektrik kesilince silinen hafıza?', 'siklar': ['SSD', 'Disk', 'RAM', 'Klasör'], 'dogru': 2, 'cevap': 'RAM', 'ipucu': '💡 Bilgisayar açıkken çalışan o hızlı "çalışma masasını" düşün; elektrik gidince her şey silinir!'},
    {'soru': 'Geri Dönüşüm Kutusu boşaltılmazsa?', 'siklar': ['Silinmez', 'Silinir', 'İnternete gider', 'Oyun olur'], 'dogru': 0, 'cevap': 'Silinmez', 'ipucu': '💡 Odandaki çöp kovasına kâğıt attığında, kova boşaltılana kadar kâğıt hâlâ odandadır.'},
    {'soru': 'Ok işaretli simgeler nedir?', 'siklar': ['Klasör', 'Kısayol', 'URL', 'Modem'], 'dogru': 1, 'cevap': 'Kısayol', 'ipucu': '💡 Derin klasörlerin içindeki ana dosyaya masaüstünden o sihirli kapıyla tek tıkla ulaşabilirsin.'},
    {'soru': 'Dosyaları küçülten bavul?', 'siklar': ['Zip', 'RAM', 'IP', 'SSD'], 'dogru': 0, 'cevap': 'Zip', 'ipucu': '💡 Tatile giderken kıyafetlerini bavula sıkı sıkı yerleştirip alanı küçültmek gibidir.'},
    {'soru': 'Yedekleme nedir?', 'siklar': ['Silme', 'Kopyalama', 'Oyun', 'Kodlama'], 'dogru': 1, 'cevap': 'Kopyalama', 'ipucu': '💡 Bilgisayarın bozulursa dosyaların kaybolmasın diye onların bir kopyasını internete saklama işlemidir.'},
    {'soru': 'En hızlı disk türü?', 'siklar': ['SSD', 'CD', 'Disket', 'DVD'], 'dogru': 0, 'cevap': 'SSD', 'ipucu': '💡 İçinde eski diskler gibi dönen mekanik parçalar olmadığı için saniyeler içinde fişek gibi açan hafıza.'},
    {'soru': 'İnternetteki saklama alanı?', 'siklar': ['RAM', 'Bulut', 'Klasör', 'SSD'], 'dogru': 1, 'cevap': 'Bulut', 'ipucu': '💡 Dosyalarını kendi cihazında değil, gökyüzündeki o dev ortak dijital alanda saklamak gibidir!'},
    {'soru': '1 TB yaklaşık kaç GB eder?', 'siklar': ['10', '100', '1000', '1'], 'dogru': 2, 'cevap': '1000', 'ipucu': '💡 Megabayt ve Gigabayt\'tan bile çok daha büyük olan devasa ölçü birimidir. Tam 1024 eder!'},
  ];

  void _detayAIYardimGoster(String sText, String cText) async {
    setState(() => sAiYukleniyor = true);
    try {
      String aiIpucu = await AIServisi.ipucuAl(soru: sText, dogruCevap: cText);
      _detayDiyalog(aiIpucu);
    } catch (e) {
      _detayDiyalog(sorular[widget.seviye - 1]['ipucu']);
    } finally {
      setState(() => sAiYukleniyor = false);
    }
  }

  void _detayDiyalog(String icerik) {
    showDialog(context: context, builder: (_) => AlertDialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)), title: const Row(children: [Icon(Icons.hub_rounded, color: Colors.blueAccent), SizedBox(width: 10), Text("Hubi'nin İpucu")]), content: Padding(padding: const EdgeInsets.symmetric(vertical: 10), child: Text(icerik, style: const TextStyle(fontSize: 18, height: 1.5))), actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("Anladım", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))]));
  }

  @override
  Widget build(BuildContext context) {
    final q = sorular[(widget.seviye - 1).clamp(0, sorular.length - 1)];
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, leading: IconButton(icon: const Icon(Icons.close, color: Colors.black), onPressed: () => Navigator.pop(context))),
      body: Container(decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xffE3F2FD), Color(0xffA0C4FF)], begin: Alignment.topLeft, end: Alignment.bottomRight)), child: Padding(padding: const EdgeInsets.all(25), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text("Soru Puanı: $puan", style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
        const SizedBox(height: 25),
        Text(q['soru'], textAlign: TextAlign.center, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Color(0xff2A2D34))),
        const SizedBox(height: 35),
        ...List.generate(4, (index) => Container(margin: const EdgeInsets.only(bottom: 15), width: double.infinity, height: 75, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff2A2D34), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))), onPressed: () { if (index == q['dogru']) { widget.onBasari(puan); Navigator.pop(context); } else { setState(() { if (puan > 5) puan -= 5; else SharedPrefsHelper.puanAzalt(1); }); showDialog(context: context, builder: (_) => AlertDialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)), title: const Text("Yanlış Cevap ⚠️", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.red)), content: const Padding(padding: EdgeInsets.symmetric(vertical: 10), child: Text("Hadi bir daha dene, sen başarabilirsin!", style: TextStyle(fontSize: 22))), actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("Denemeye Devam", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))), TextButton(onPressed: () { Navigator.pop(context); Navigator.pop(context); }, child: const Text("Çıkış", style: TextStyle(fontSize: 22, color: Colors.red)))])); } }, child: Text(q['siklar'][index], style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white))))),
        const Spacer(),
        SizedBox(height: 60, child: sAiYukleniyor ? const CircularProgressIndicator() : ElevatedButton.icon(style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), elevation: 5), onPressed: () => _detayAIYardimGoster(q['soru'], q['cevap']), icon: const Icon(Icons.hub_rounded, size: 30), label: const Text("HUBİ'YE SOR", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1)))),
        const SizedBox(height: 20)
      ]))),
    );
  }
}