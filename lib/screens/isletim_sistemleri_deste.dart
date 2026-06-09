import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:hubi_oyunda/core/shared_prefs_helper.dart';

class IsletimSistemleriDesteEkrani extends StatefulWidget {
  const IsletimSistemleriDesteEkrani({super.key});
  @override
  State<IsletimSistemleriDesteEkrani> createState() => _IsletimSistemleriDesteEkraniState();
}

class _IsletimSistemleriDesteEkraniState extends State<IsletimSistemleriDesteEkrani> {
  // 📝 Fatma'nın 10 Adet İşletim Sistemleri Konu Anlatım Kartı Notları
  final List<Map<String, String>> kartlar = [
    {'on': 'Bilgisayarın, telefonun veya tabletin içindeki tüm parçaları birbirine küstürmeden, uyum içinde yöneten gizli orkestra şefi kimdir?', 'arka': 'İşletim Sistemi!', 'hubi': '💡 İşletim sistemi; bilgisayar, telefon veya tablet açıldığı andan itibaren donanım parçaları ile tüm uygulamaların birbiriyle uyum içinde çalışmasını sağlayan ana yöneticidir. O olmadan cihazlar çalışamaz.'},
    {'on': 'Telefonun ekranına dokunduğunda veya klavyede bir tuşa bastığında, senin ne yapmak istediğini anlayıp bunu oynamak istediğin oyuna ileten köprü nedir?', 'arka': 'İşletim Sistemi! Donanım ile yazılım arasındaki iletişimi sağlar.', 'hubi': '💡 Bilgisayarda fiziksel olarak dokunabildiğimiz parçalara donanım, içindeki program ve oyunlara yazılım denir. İşletim sistemi, bu iki farklı yapının birbiriyle iletişim kurmasını sağlayan ana köprüdür.'},
    {'on': 'Günlük hayatta bilgisayar ve telefonlarımızda karşılaştığımız en popüler işletim sistemlerinden 3 tanesini sayabilir misin?', 'arka': 'Windows, Android, iOS ve Türkiye\'de TÜBİTAK tarafından geliştirilen yerli sistemimiz Pardus!', 'hubi': '💡 Dünyada bilgisayarlar için en yaygın sistem Windows, telefonlar için ise Android og iOS\'tur. Pardus ise Türkiye\'de TÜBİTAK tarafından geliştirilen güvenli, yerli ve milli işletim sistemimizdir.'},
    {'on': 'Açık Kaynak Kodlu Sistem Nedir?', 'arka': 'Kodları gizli olmayan, herkese açık özgür yazılımlardır.', 'hubi': '💡 Açık kaynak kodlu sistemlerin yapım tarifleri ve kodları gizli değildir, tüm dünyaya açıktır. Bu sayede yeryüzündeki bütün yazılımcılar bu kodları inceleyebilir, geliştirebilir ve daha güvenli hale getirebilir.'},
    {'on': 'Sistem Güncellemesi Neden Yapılır?', 'arka': 'Güvenlik açıklarını kapatmak ve yeni özellikler eklemek için.', 'hubi': '💡 Sistem güncellemeleri, siber korsanların cihazlardaki açıkları bulmasını engellemek için yayınlanan dijital yamalardır. Cihaza yeni özellikler kazandırır ve güvenlik duvarlarını en güncel seviyeye çıkarır.'},
    {'on': 'Çoklu Görev (Multi-tasking) Nedir?', 'arka': 'Aynı anda birden fazla programı karıştırmadan çalıştırma becerisi.', 'hubi': '💡 Çoklu görev (Multi-tasking), işletim sisteminin aynı anda birden fazla programı (örneğin aynı anda hem müzik çalmayı, hem indirme yapmayı, hem de yazı yazmayı) birbirine karıştırmadan yönetme becerisidir.'},
    {'on': 'Önyükleme (Booting) Ne Demektir?', 'arka': 'Cihazın açma tuşuna basıldığı an başlayan ayağa kalkma süreci.', 'hubi': '💡 Cihazın açma tuşuna basıldığı an, işletim sistemi kalıcı hafızadan alınarak geçici hafızaya yüklenir. Bu yüklenme ve cihazın ilk ayağa kalkma sürecine önyükleme (booting) adı verilir.'},
    {'on': 'Mobil İşletim Sisteminin Farkı Nedir?', 'arka': 'Pil tasarrufu, dokunmatik ekran ve sensör yönetimi için özel üretilmesidir.', 'hubi': '💡 Mobil işletim sistemleri, masaüstü sistemlerden farklı olarak cep telefonları ve tabletlerin pillerini tasarruflu kullanmak, dokunmatik ekranları ve konum (GPS) sensörlerini yönetmek için özel üretilmiştir.'},
    {'on': 'Sürücü (Driver) Ne İşe Yarar?', 'arka': 'Bilgisayara takılan yeni bir donanımı işletim sistemine tanıtır.', 'hubi': '💡 Bilgisayara yeni bir fare, yazıcı veya oyun kolu takıldığında, işletim sisteminin o yabancı parçayı tanıyıp çalıştırabilmesi için yüklenen küçük tanıtım yazılımlarına sürücü (driver) denir.'},
    {'on': 'Grafiksel Arayüz (GUI) Nedir?', 'arka': 'Bilgisayarı ikonlara ve klasörlere tıklayarak kullanmamızı sağlayan görsel katman.', 'hubi': '💡 Eski bilgisayarlarda fare ve renkli pencereler yoktu, her şey siyah ekrana kod yazarak yapılırdı. Grafiksel arayüz, bilgisayarı ikonlara ve klasörlere tıklayarak kolayca kullanmamızı sağlayan görsel katmandır.'},
  ];

  int suAnkiKartIndex = 0;
  bool oyunBasladiMi = false;
  bool kartDonduMu = false;
  final Color isletimTemaRengi = const Color(0xffFF8B94);

  void _hubiNotuGoster(String mesaj) {
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)), 
        title: const Row(
          children: [Icon(Icons.smart_toy_rounded, color: Color(0xff8B5CF6)), SizedBox(width: 10), Text("Hubi'nin İpucu... 🤖")],
        ), 
        content: Text(mesaj, style: const TextStyle(fontSize: 18, height: 1.4)), 
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("Harika, Anladım!", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff8B5CF6))))]
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f7fb),
      body: Container(
        decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xffFFE5E5), Color(0xffFF8B94)], begin: Alignment.topLeft, end: Alignment.bottomRight)), 
        child: Column(
          children: [
            AppBar(
              title: const Text('İşletim Sistemleri', style: TextStyle(color: Color(0xff2A2D34), fontWeight: FontWeight.bold, fontSize: 24)), 
              backgroundColor: Colors.transparent, elevation: 0, 
              leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xff2A2D34)), onPressed: () => Navigator.pop(context))
            ),
            Expanded(
              child: Center(
                child: SizedBox(
                  width: 400, height: 500, 
                  child: Stack(
                    alignment: Alignment.center, 
                    children: [
                      ...List.generate(kartlar.length, (index) {
                        int tersIndex = (kartlar.length - 1) - index;
                        if (oyunBasladiMi && index == suAnkiKartIndex) return const SizedBox.shrink();
                        return AnimatedOpacity(
                          duration: const Duration(milliseconds: 400), opacity: oyunBasladiMi ? 0.0 : 1.0, 
                          child: Transform(
                            alignment: Alignment.center, transform: Matrix4.identity()..rotateZ((tersIndex - 2) * -0.06), 
                            child: Container(
                              margin: EdgeInsets.only(left: (60 + (tersIndex * -22.0) + 30.0).clamp(0.0, 500.0), top: (70 + (tersIndex * -18.0) + 20.0).clamp(0.0, 500.0)), 
                              width: 210, height: 300, 
                              decoration: BoxDecoration(color: isletimTemaRengi, borderRadius: BorderRadius.circular(22), border: Border.all(color: const Color(0xff2A2D34), width: 3)), 
                              child: Center(child: Text("${index + 1}. Kart", style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Color(0xff2A2D34))))
                            )
                          )
                        );
                      }),
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 550), curve: Curves.easeOutCubic, 
                        left: oyunBasladiMi ? 50 : 95.0, top: oyunBasladiMi ? 50 : 80.0, 
                        child: SizedBox(
                          key: ValueKey(suAnkiKartIndex), width: oyunBasladiMi ? 310 : 210, height: oyunBasladiMi ? 440 : 300, 
                          child: oyunBasladiMi ? _buildAktifKart() : _buildDesteTetiklayiciKart()
                        )
                      ),
                    ]
                  )
                )
              )
            ),
            if (oyunBasladiMi && kartDonduMu) _buildTekSiradakiKartButonu(),
            const SizedBox(height: 30),
          ]
        )
      ),
    );
  }

  Widget _buildDesteTetiklayiciKart() => GestureDetector(
    onTap: () => setState(() { oyunBasladiMi = true; suAnkiKartIndex = 0; kartDonduMu = false; }), 
    child: Container(decoration: BoxDecoration(color: isletimTemaRengi, borderRadius: BorderRadius.circular(22), border: Border.all(color: const Color(0xff2A2D34), width: 3)), child: const Icon(Icons.computer_rounded, size: 90, color: Color(0xff2A2D34)))
  );

  Widget _buildAktifKart() => GestureDetector(
    onTap: () => setState(() => kartDonduMu = !kartDonduMu), 
    child: TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: kartDonduMu ? math.pi : 0), duration: const Duration(milliseconds: 400), 
      builder: (context, double aci, child) { 
        final arkasiGozukuyorMu = aci >= math.pi / 2; 
        return Transform(
          alignment: Alignment.center, transform: Matrix4.identity()..setEntry(3, 2, 0.001)..rotateY(aci), 
          child: Container(
            decoration: BoxDecoration(color: arkasiGozukuyorMu ? Colors.white : isletimTemaRengi, borderRadius: BorderRadius.circular(28), border: Border.all(color: const Color(0xff2A2D34), width: 3.5)), 
            child: Transform(
              alignment: Alignment.center, transform: arkasiGozukuyorMu ? (Matrix4.identity()..rotateY(math.pi)) : Matrix4.identity(), 
              child: Padding(
                padding: const EdgeInsets.all(16), 
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, 
                  children: [
                    Text("${suAnkiKartIndex + 1}. Kart", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Color(0xff2A2D34))), 
                    const SizedBox(height: 10), 
                    Expanded(
                      child: Center(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Text(arkasiGozukuyorMu ? kartlar[suAnkiKartIndex]['arka']! : kartlar[suAnkiKartIndex]['on']!, textAlign: TextAlign.center, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xff2A2D34))),
                        ),
                      ),
                    ), 
                    if (arkasiGozukuyorMu) 
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 4.0), 
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff2A2D34), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10)), 
                          onPressed: () => _hubiNotuGoster(kartlar[suAnkiKartIndex]['hubi']!), 
                          icon: const Icon(Icons.hub_rounded), 
                          label: const Text("HUBİ'YE SOR", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
                        )
                      )
                  ]
                )
              )
            )
          )
        ); 
      }
    )
  );

  Widget _buildTekSiradakiKartButonu() { 
    bool sonKartMi = suAnkiKartIndex == kartlar.length - 1; 
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0), 
      child: InkWell(
        onTap: () { 
          if (!sonKartMi) { 
            setState(() { suAnkiKartIndex++; kartDonduMu = false; }); 
          } else { 
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SoruHaritasiIsletim())); 
          } 
        }, 
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20), 
          decoration: BoxDecoration(color: sonKartMi ? Colors.white : isletimTemaRengi, borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xff2A2D34), width: 3)), 
          child: Center(child: Text(sonKartMi ? 'SORU HARİTASINA GİT 🗺️' : 'SIRADAKİ KART ➡️', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xff2A2D34))))
        )
      )
    ); 
  }
}

class SoruHaritasiIsletim extends StatefulWidget { const SoruHaritasiIsletim({super.key}); @override State<SoruHaritasiIsletim> createState() => _SoruHaritasiIsletimState(); }
class _SoruHaritasiIsletimState extends State<SoruHaritasiIsletim> {
  @override
  Widget build(BuildContext context) { 
    int anlikToplamPuan = SharedPrefsHelper.getPuan();
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xffFFE5E5), Color(0xffFF8B94)], begin: Alignment.topLeft, end: Alignment.bottomRight)), 
        child: Column(
          children: [
            AppBar(title: const Text("Soru Haritası"), backgroundColor: Colors.transparent, elevation: 0, actions: [Padding(padding: const EdgeInsets.all(15), child: Text("🏆 $anlikToplamPuan XP", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Color(0xff2A2D34))))]), 
            Expanded(
              child: ListView.builder(
                itemCount: 10, // 🔥 VİDEODAKİ GİBİ 10 SEVİYELİK HARİTA SINIRI TAMAMLANDI!
                itemBuilder: (context, i) { 
                  bool kilitliMi = i > (SharedPrefsHelper.getLevel("Isletim") - 1); 
                  return GestureDetector(
                    onTap: () async { 
                      if (!kilitliMi) { 
                        await Navigator.push(context, MaterialPageRoute(builder: (context) => SoruDetayIsletim(seviye: i + 1, onBasari: (p) {
                          SharedPrefsHelper.setLevel("Isletim", i + 2); 
                          SharedPrefsHelper.puanArttir(p).then((_) { setState(() {}); });
                        }))); 
                        setState(() {}); 
                      } 
                    }, 
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 30), padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20), 
                      decoration: BoxDecoration(color: kilitliMi ? Colors.grey[400] : Color.lerp(const Color(0xffFF8B94), const Color(0xffFFD6A5), i / 9), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white, width: 3)), 
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center, 
                        children: [
                          Icon(kilitliMi ? Icons.lock : Icons.computer, color: Colors.white, size: 35), 
                          const SizedBox(width: 15), 
                          Text("SEVİYE ${i + 1}", style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.white))
                        ]
                      )
                    )
                  ); 
                }
              )
            )
          ]
        )
      )
    ); 
  }
}

class SoruDetayIsletim extends StatefulWidget { final int seviye; final Function(int) onBasari; const SoruDetayIsletim({super.key, required this.seviye, required this.onBasari}); @override State<SoruDetayIsletim> createState() => _SoruDetayIsletimState(); }
class _SoruDetayIsletimState extends State<SoruDetayIsletim> {
  int puan = 15;
  
  // 📝 Fatma'nın 10 ADET TAM ORİJİNAL QUIZ SORULARI VE İPUÇLARI
  final List<Map<String, dynamic>> sorular = [
    {'soru': 'Bilgisayarın tüm parçalarını birbirine küstürmeden yöneten şef?', 'siklar': ['Sabit Disk', 'İşletim Sistemi', 'İnternet Modemi', 'Şarkı Dosyası'], 'dogru': 1, 'cevap': 'İşletim Sistemi', 'ipucu': '💡 Ekranın, klavyenin ve tüm uygulamaların kavga etmeden, uyum içinde çalışmasını sağlayan o gizli yöneticiyi hatırla!'},
    {'soru': 'Donanım ile yazılım arasındaki iletişimi sağlayan köprü nedir?', 'siklar': ['Klavye tuşu', 'Geri Dönüşüm Kutusu', 'İşletim Sistemi', 'Şifre Kalesi'], 'dogru': 2, 'cevap': 'İşletim Sistemi', 'ipucu': '💡 Ekran bir donanımdır, oyun ise bir yazılım. İkisinin el sıkışıp birbiriyle konuşmasını sağlayan o dijital köprüyü düşün.'},
    {'soru': 'Aşağıdaki işletim sistemlerinden hangisi Türkiye\'de geliştirilen yerli ve Linux tabanlı sistemimizdir?', 'siklar': ['Windows', 'Android', 'iOS', 'Pardus'], 'dogru': 3, 'cevap': 'Pardus', 'ipucu': '💡 İsmini Anadolu parsından alan, Türkiye\'nin gururu olan o sevimli kedili işletim sistemimizi hatırla!'},
    {'soru': 'Dünyadaki tüm yazılımcıların kodlarını görebildiği ve geliştirebildiği özgür sistem türü hangisidir?', 'siklar': ['Kapalı Kaynak', 'Açık Kaynak', 'Gizli Kodlu', 'Lisanslı Sistem'], 'dogru': 1, 'cevap': 'Açık Kaynak', 'ipucu': '💡 Tarifi gizli olmayan bir yemek gibi, dünyadaki tüm yazılımcıların kodlarını görebildiği sistemleri düşün.'},
    {'soru': 'Cihazın siber korsanlara karşı korunması, yeni özellikler kazanması için hangisi yapılmalıdır?', 'siklar': ['Sistem Güncellemesi', 'Dosya Silme', 'Kablo Değişimi', 'Ekran Kapatma'], 'dogru': 0, 'cevap': 'Sistem Güncellemesi', 'ipucu': '💡 Cihazının siber korsanlara karşı daha güçlü dövüşebilmesi için ara sıra yeni zırhlar giymesi ve kalkanını yenilemesi gerekir.'},
    {'soru': 'Bilgisayarın aynı anda birden fazla işi birbirine karıştırmadan yapma becerisine ne denir?', 'siklar': ['Tekli Görev', 'Çoklu Görev', 'Hafıza Formatı', 'Yedekleme Sürücüsü'], 'dogru': 1, 'cevap': 'Çoklu Görev', 'ipucu': '💡 Aynı anda hem sakız çiğneyip hem yürüyebilmek gibidir! Bilgisayarın aynı anda birden fazla işi yapma becerisini hatırla.'},
    {'soru': 'Cihazın güç tuşuna basıldığı an, sistemin uyanıp kendini geçici hafızaya yüklediği sürece ne denir?', 'siklar': ['Önyükleme (Booting)', 'Kapatma', 'Yedekleme', 'Sıkıştırma'], 'dogru': 0, 'cevap': 'Önyükleme', 'ipucu': '💡 Bilgisayarın güç tuşuna bastığın o ilk saniyelerde, sistemin kalıcı hafızadan uyanıp kendini yüklediği o ilk anı düşün.'},
    {'soru': 'Dokunmatik ekran, sensörler ve pil tasarrufu için özel olarak üretilen sistem türü hangisidir?', 'siklar': ['Masaüstü Sistemi', 'Mobil İşletim Sistemi', 'Sunucu Yazılımı', 'Mainframe'], 'dogru': 1, 'cevap': 'Mobil İşletim Sistemi', 'ipucu': '💡 Masaüstü bilgisayarlar prize bağlıdır ama cebimize sığan, dokunmatik ekranlı ve pilli akıllı cihazlar için bambaşka bir sistem gerekir.'},
    {'soru': 'Bilgisayara yeni takılan yabancı bir donanım parçasının sistem tarafından tanınmasını sağlayan tanıtıcı yazılıma ne denir?', 'siklar': ['Sürücü (Driver)', 'Uzantı', 'Klasör', 'Bulut'], 'dogru': 0, 'cevap': 'Sürücü', 'ipucu': '💡 Bilgisayara yeni bir oyun kolu taktığında, işletim sisteminin bu yabancı parçayla tanışmasını sağlayan mini bir "tercüman" yazılımdır.'},
    {'soru': 'Siyah ekrana sıkıcı kodlar yazmak yerine; fareyle renkli ikonlara ve pencerelere tıklayarak gezindiğimiz görsel katman nedir?', 'siklar': ['Komut Satırı', 'Grafiksel Arayüz (GUI)', 'Sabit Disk Kontrolü', 'RAM Bellek'], 'dogru': 1, 'cevap': 'Grafiksel Arayüz', 'ipucu': '💡 Siyah bir ekrana sıkıcı kodlar yazmak yerine; renkli ikonlara, pencerelere ve klasörlere fareyle tıklayarak gezindiğin o güzel dünyayı hatırla.'},
  ];

  void _soruDetayAIYardimGoster(String ipucuText) {
    showDialog(
      context: context, 
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)), 
        title: const Row(children: [Icon(Icons.smart_toy_rounded, color: Colors.redAccent), SizedBox(width: 10), Text("Hubi'nin İpucu")]), 
        content: Padding(padding: const EdgeInsets.symmetric(vertical: 10), child: Text(ipucuText, style: const TextStyle(fontSize: 18, height: 1.4))), 
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("Anladım", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.redAccent)))]
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentIdx = (widget.seviye - 1).clamp(0, sorular.length - 1);
    final q = sorular[currentIdx];
    
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, leading: IconButton(icon: const Icon(Icons.close, color: Colors.black), onPressed: () => Navigator.pop(context))),
      body: Container(
        decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xffFFE5E5), Color(0xffFF8B94)], begin: Alignment.topLeft, end: Alignment.bottomRight)), 
        child: Padding(
          padding: const EdgeInsets.all(25), 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [
              Text("Soru Puanı: $puan", style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 25),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Text(q['soru'], textAlign: TextAlign.center, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: Color(0xff2A2D34))),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ...List.generate(4, (index) => Container(
                margin: const EdgeInsets.only(bottom: 15), width: double.infinity, height: 70, 
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff2A2D34), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))), 
                  onPressed: () { 
                    if (index == q['dogru']) { 
                      widget.onBasari(puan); 
                      Navigator.pop(context); 
                    } else { 
                      setState(() { if (puan > 5) puan -= 5; else SharedPrefsHelper.puanAzalt(1); }); 
                      showDialog(
                        context: context, 
                        builder: (_) => AlertDialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)), 
                          title: const Text("Yanlış Cevap ⚠️", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.red)), 
                          content: const Padding(padding: EdgeInsets.symmetric(vertical: 10), child: Text("Hadi bir daha dene, sen başarabilirsin!", style: TextStyle(fontSize: 22))), 
                          actions: [
                            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Denemeye Devam", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))), 
                            TextButton(onPressed: () { Navigator.pop(context); Navigator.pop(context); }, child: const Text("Çıkış", style: TextStyle(fontSize: 22, color: Colors.red)))
                          ]
                        )
                      ); 
                    } 
                  }, 
                  child: Text(q['siklar'][index], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white))
                )
              )),
              const SizedBox(height: 20),
              SizedBox(
                height: 60, width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff2A2D34), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))), 
                  onPressed: () => _soruDetayAIYardimGoster(q['ipucu']), 
                  icon: const Icon(Icons.smart_toy_rounded, size: 30), 
                  label: const Text("HUBİ'YE SOR", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                )
              ),
              const SizedBox(height: 10)
            ]
          )
        )
      ),
    );
  }
}