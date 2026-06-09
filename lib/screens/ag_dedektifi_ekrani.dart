import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:hubi_oyunda/core/shared_prefs_helper.dart';

class AgDedektifiDesteEkrani extends StatefulWidget {
  const AgDedektifiDesteEkrani({super.key});
  @override
  State<AgDedektifiDesteEkrani> createState() => _AgDedektifiDesteEkraniState();
}

class _AgDedektifiDesteEkraniState extends State<AgDedektifiDesteEkrani> {
  // 📝 Fatma'nın 10 Adet Ağ Dedektifi Anlatım Kartı Notları
  final List<Map<String, String>> kartlar = [
    {'on': 'Dünya üzerindeki tüm bilgisayarları birbirine bağlayan dev ağa ne denir?', 'arka': 'İnternet!', 'hubi': '💡 Bilgisayar ağı, en az iki veya daha fazla bilgisayarın kablolarla ya da Wi-Fi üzerinden birbirine bağlanarak veri paylaşmasıyla oluşan iletişim sistemidir.'},
    {'on': 'LAN (Yerel Ağ) ile İnternet arasındaki en büyük fark nedir?', 'arka': 'LAN küçük bir odayı bağlar, İnternet tüm gezegeni kaplar.', 'hubi': '💡 LAN (Yerel Ağ), sadece okul laboratuvarı veya ev gibi küçük bir alandaki cihazları bağlar. İnternet (WAN) ise kıtaları bağlayan en büyük ağdır.'},
    {'on': 'IoT (Nesnelerin İnterneti) nedir?', 'arka': 'Akıllı ev aletlerinin internete bağlanmasıdır.', 'hubi': '💡 Nesnelerin İnterneti, akıllı saat, robot süpürge veya akıllı buzdolabı gibi günlük hayatta kullandığımız eşyaların internete bağlanması teknolojisidir.'},
    {'on': 'Modem ne işe yarar?', 'arka': 'İnternet sinyalini cihazların anlayacağı dile çevirir.', 'hubi': '💡 Modem, sokaktaki telefon hatlarından gelen dış internet sinyallerini bilgisayarların anlayacağı dijital dile çeviren ve evdeki cihazlara dağıtan ana kutudur.'},
    {'on': 'URL nedir?', 'arka': 'Web sitelerinin internetteki adresidir (örn: www.google.com).', 'hubi': '💡 URL, internet dünyasindeki her web sitesinin kendine ait olan benzersiz internet adresidir. Tarayıcıya yazıldığında bizi siteye ulaştırır.'},
    {'on': 'Aradığımız bir kelimeyi saniyeler içinde önümüze listeleyen dev kütüphane sitelerine ne denir?', 'arka': 'Arama Motoru (Google, Bing vb.)', 'hubi': '💡 Arama motoru, internetteki milyarlarca web sitesini gece gündüz tarayıp dizine ekleyen ve aradığımız kelimeyi listeleyen sistemdir.'},
    {'on': 'Tarayıcı (Browser) nedir?', 'arka': 'İnternette gezinmemizi sağlayan programlardır (Chrome, Safari).', 'hubi': '💡 İnternet siteleri karmaşık kodlardan oluşur. Web tarayıcısı, bu görünmez kodları bizim okuyabileceğimiz renkli resim ve yazılara dönüştürür.'},
    {'on': 'İnterneti ışık hızında taşıyan ince cam kablolara ne denir?', 'arka': 'Fiber İnternet Kabloları!', 'hubi': '💡 5G, mobil cihazların havadan internete bağlanmasını sağlayan en yeni bağlantı neslidir. Eski nesillere göre verileri kat kat hızlı taşır.'},
    {'on': 'Web sitelerini içinde barındıran ve 7/24 hiç kapanmayan güçlü bilgisayarlara ne denir?', 'arka': 'Sunucu (Server)!', 'hubi': '💡 Sunucu, web sitelerinin dosyalarını içinde barındıran, internet bağlantısı ve elektrikleri 7/24 hiç kesilmeyen dev ana bilgisayarlardır.'},
    {'on': 'IP adresi nedir?', 'arka': 'İnternetteki her cihazın dijital kimlik numarasıdır.', 'hubi': '💡 IP adresi, internete bağlanan her cihaza verilen sayılardan oluşan benzersiz dijital kimlik numarasıdır. Verilerin doğru gitmesini sağlar.'},
  ];

  int suAnkiKartIndex = 0;
  bool oyunBasladiMi = false;
  bool kartDonduMu = false;
  final Color agTemaRengi = const Color(0xffB9FBC0);

  void _hubiAIYardimGoster(String mesaj) {
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)), 
        title: const Row(children: [Icon(Icons.smart_toy_rounded, color: Color(0xff8B5CF6)), SizedBox(width: 10), Text("Hubi'nin Notu... 🤖")]), 
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
        decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xffE8F5E9), Color(0xffB9FBC0)], begin: Alignment.topLeft, end: Alignment.bottomRight)), 
        child: Column(
          children: [
            AppBar(
              title: const Text('Ağ Dedektifi', style: TextStyle(color: Color(0xff2A2D34), fontWeight: FontWeight.bold, fontSize: 24)), 
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
                              decoration: BoxDecoration(color: agTemaRengi, borderRadius: BorderRadius.circular(22), border: Border.all(color: const Color(0xff2A2D34), width: 3)), 
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
    child: Container(decoration: BoxDecoration(color: agTemaRengi, borderRadius: BorderRadius.circular(22), border: Border.all(color: const Color(0xff2A2D34), width: 3)), child: const Icon(Icons.wifi_find_rounded, size: 90, color: Color(0xff2A2D34)))
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
            decoration: BoxDecoration(color: arkasiGozukuyorMu ? Colors.white : agTemaRengi, borderRadius: BorderRadius.circular(28), border: Border.all(color: const Color(0xff2A2D34), width: 3.5)), 
            child: Transform(
              alignment: Alignment.center, transform: arkasiGozukuyorMu ? (Matrix4.identity()..rotateY(math.pi)) : Matrix4.identity(), 
              child: Padding(
                padding: const EdgeInsets.all(12), 
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
                          onPressed: () => _hubiAIYardimGoster(kartlar[suAnkiKartIndex]['hubi']!), 
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
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SoruHaritasiAg())); 
          } 
        }, 
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20), 
          decoration: BoxDecoration(color: sonKartMi ? Colors.white : agTemaRengi, borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xff2A2D34), width: 3)), 
          child: Center(child: Text(sonKartMi ? 'GÖREVİ BİTİR 🗺️' : 'SIRADAKİ KART ➡️', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xff2A2D34))))
        )
      )
    ); 
  }
}

class SoruHaritasiAg extends StatefulWidget { const SoruHaritasiAg({super.key}); @override State<SoruHaritasiAg> createState() => _SoruHaritasiAgState(); }
class _SoruHaritasiAgState extends State<SoruHaritasiAg> {
  @override
  Widget build(BuildContext context) { 
    int anlikToplamPuan = SharedPrefsHelper.getPuan();
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xffE8F5E9), Color(0xffB9FBC0)], begin: Alignment.topLeft, end: Alignment.bottomRight)), 
        child: Column(
          children: [
            AppBar(title: const Text("Soru Haritası"), backgroundColor: Colors.transparent, elevation: 0, actions: [Padding(padding: const EdgeInsets.all(15), child: Text("🏆 $anlikToplamPuan XP", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Color(0xff2A2D34))))]), 
            Expanded(
              child: ListView.builder(
                itemCount: 10, 
                itemBuilder: (context, i) { 
                  bool kilitliMi = i > (SharedPrefsHelper.getLevel("Ag") - 1); 
                  return GestureDetector(
                    onTap: () async { 
                      if (!kilitliMi) { 
                        await Navigator.push(context, MaterialPageRoute(builder: (context) => SoruDetayAg(seviye: i + 1, onBasari: (p) {
                          SharedPrefsHelper.setLevel("Ag", i + 2); 
                          SharedPrefsHelper.puanArttir(p).then((_) { setState(() {}); });
                        }))); 
                        setState(() {}); 
                      } 
                    }, 
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 30), padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20), 
                      decoration: BoxDecoration(color: kilitliMi ? Colors.grey[400] : Color.lerp(const Color(0xffB9FBC0), const Color(0xffFFD6A5), i / 9), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white, width: 3)), 
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center, 
                        children: [
                          Icon(kilitliMi ? Icons.lock : Icons.wifi, color: Colors.white, size: 35), 
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

class SoruDetayAg extends StatefulWidget { final int seviye; final Function(int) onBasari; const SoruDetayAg({super.key, required this.seviye, required this.onBasari}); @override State<SoruDetayAg> createState() => _SoruDetayAgState(); }
class _SoruDetayAgState extends State<SoruDetayAg> {
  int puan = 15;
  final List<Map<String, dynamic>> sorular = [
    {'soru': 'Bilgisayarları birbirine bağlayan ağ?', 'siklar': ['İnternet', 'Modem', 'Dosya', 'Kablo'], 'dogru': 0, 'cevap': 'İnternet', 'ipucu': '💡 Bilgisayarların tek başlarına sıkılmaması, dosya paylaşmak için kurdukları o arkadaşlık köprüsü nedir?'},
    {'soru': 'İnternetin ilk giriş kapısı?', 'siklar': ['Klavye', 'Modem', 'Ekran', 'Fare'], 'dogru': 1, 'cevap': 'Modem', 'ipucu': '💡 Evin bir köşesinde duran, üzerinde internet ışıkları yanıp sönen o küçük kutuyu hatırla!'},
    {'soru': 'Kablosuz internet teknolojisine ne ad verilir?', 'siklar': ['Wi-Fi', 'Kablo', 'Ekran', 'Dosya'], 'dogru': 0, 'cevap': 'Wi-Fi', 'ipucu': '💡 Sinyalleri havada uçuran o sihirli kablosuz bağlantıyı hatırla!'},
    {'soru': 'Cihazın internet dünyasındaki kimlik numarası?', 'siklar': ['URL', 'IP', 'RAM', 'SSD'], 'dogru': 1, 'cevap': 'IP', 'ipucu': '💡 Bilgisayarların birbirini bulabilmesi için her cihaza verilen sayılardan oluşan gizli dijital kimlik numarasıdır.'},
    {'soru': 'Akıllı ev aletleri ağına ne denir?', 'siklar': ['IoT', 'URL', 'RAM', 'Dosya'], 'dogru': 0, 'cevap': 'IoT', 'ipucu': '💡 Sadece bilgisayarlar değil; akıllı saatler, robot süpürgeler, yani tüm cansız eşyalar internete bağlanabiliyor!'},
    {'soru': 'Sitenin internet adresi hangisidir?', 'siklar': ['URL', 'IP', 'SSD', 'RAM'], 'dogru': 0, 'cevap': 'URL', 'ipucu': '💡 Bir web sitesine gitmek için tarayıcıya onun internet dünyasindeki adresini yazarsın.'},
    {'soru': 'İnternet gezinti gemisi programı hangisidir?', 'siklar': ['Dosya', 'Tarayıcı', 'Modem', 'Klavye'], 'dogru': 1, 'cevap': 'Tarayıcı', 'ipucu': '💡 Chrome veya Safari gibi, internet sitelerinin kodlarını bizim için renkli resimlere dönüştüren pencereler.'},
    {'soru': 'Işık hızında taşıyan internet şebekesi bağlantısı?', 'siklar': ['Bakır', '5G Teknolojisi', 'IP', 'URL'], 'dogru': 1, 'cevap': '5G Teknolojisi', 'ipucu': '💡 İnternette videoların hiç takılmadan yüklenmesini sağlayan ve gelecekte uçan arabaların kullanacağı en yeni nesil bağlantı.'},
    {'soru': 'Web sitelerinin saklandığı güçlü 7/24 açık bilgisayarlar?', 'siklar': ['Sunucu', 'RAM', 'Klavye', 'Modem'], 'dogru': 0, 'cevap': 'Sunucu', 'ipucu': '💡 İnternet sitelerinin 7 gün 24 saat tüm dünyaya açık kalmasını sağlayan, hiç kapanmayan o dev ev sahibi bilgisayarlar.'},
    {'soru': 'Dosyaların internette saklanması?', 'siklar': ['Bulut', 'RAM', 'Dosya', 'Kablo'], 'dogru': 0, 'cevap': 'Bulut', 'ipucu': '💡 Dosyalarını kendi bilgisayarında değil, gökyüzündeki o dev ortak bilgisayarlarda saklamak gibidir!'},
  ];

  void _soruDetayAIYardimGoster(String ipucuText) {
    showDialog(
      context: context, 
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)), 
        title: const Row(children: [Icon(Icons.smart_toy_rounded, color: Colors.green), SizedBox(width: 10), Text("Hubi'nin İpucu")]), 
        content: Padding(padding: const EdgeInsets.symmetric(vertical: 10), child: Text(ipucuText, style: const TextStyle(fontSize: 18, height: 1.4))), 
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("Anladım", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)))]
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    final q = sorular[(widget.seviye - 1).clamp(0, sorular.length - 1)];
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, leading: IconButton(icon: const Icon(Icons.close, color: Colors.black), onPressed: () => Navigator.pop(context))),
      body: Container(
        decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xffE8F5E9), Color(0xffB9FBC0)], begin: Alignment.topLeft, end: Alignment.bottomRight)), 
        child: Padding(
          padding: const EdgeInsets.all(25), 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [
              Text("Soru Puanı: $puan", style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.green)),
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