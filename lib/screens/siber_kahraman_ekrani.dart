import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:hubi_oyunda/core/shared_prefs_helper.dart';

class SiberKahramanEkrani extends StatefulWidget {
  const SiberKahramanEkrani({super.key});
  @override
  State<SiberKahramanEkrani> createState() => _SiberKahramanEkraniState();
}

class _SiberKahramanEkraniState extends State<SiberKahramanEkrani> {
  // 📝 Fatma'nın 10 Adet Siber Kahraman Anlatım Kartı Notları
  final List<Map<String, String>> kartlar = [
    {'on': 'Phishing (Oltalama) nedir?', 'arka': 'Sahte e-posta veya mesajlarla bilgi çalma yöntemidir.', 'hubi': '💡 Kimlik avı (oltalama), siber korsanların sahte hediyelerle çocukları kandırarak hesap şifrelerini çalmaya çalıştığı bir dijital tuzaktır.'},
    {'on': 'Güçlü parola nasıl olmalıdır?', 'arka': 'Harf, rakam ve özel karakterlerden oluşan uzun şifre.', 'hubi': '💡 Güçlü bir şifre kalesi oluşturmak için şifrenin en az 8 karakterden oluşması; içinde büyük-küçük harf, sayı ve sembollerin karışık bulunması gerekir.'},
    {'on': 'İki faktörlü doğrulama nedir?', 'arka': 'Giriş yaparken şifreye ek olarak telefona gelen koddur.', 'hubi': '💡 İki adımlı doğrulama, siber korsanlar şifremizi ele geçirse bile hesaba girmelerini engelleyen sistemdir. Telefona onay kodu gönderir.'},
    {'on': 'Malware nedir?', 'arka': 'Bilgisayara zarar veren kötü amaçlı yazılımlardır.', 'hubi': '💡 Antivirüs, internetten indirdiğimiz dosyalardan cihazımıza sızmaya çalışan zararlı yazılımları tarayan koruyucu bir programdır.'},
    {'on': 'Güvenli Wi-Fi nedir?', 'arka': 'Şifresi olan ve güvendiğin ağlardır.', 'hubi': '💡 Girdiğimiz web sitesinin adres çubuğunun en solunda duran kapalı kilit sembolü ve https:// siber zırhla korunduğunu kanıtlar.'},
    {'on': 'İnternet trafiğini şifreleyerek gizleyen tünel nedir?', 'arka': 'VPN Sistemi!', 'hubi': '💡 Kriptografi, internette gönderdiğimiz mesajların havada siber korsanlar tarafından çalınmasını önlemek için verileri şifreleme bilimidir.'},
    {'on': 'Bilgisayarı kötü yazılımlara karşı koruyan ve temizleyen yazılım hangisidir?', 'arka': 'Antivirüs Programı!', 'hubi': '💡 Antivirüs programı, internet ortamındaki virüslerden korunmak ve siber mikropları yok etmek için dijital doktorundur.'},
    {'on': 'İnsanları kandırarak bilgi elde etme sanatına ne denir?', 'arka': 'Sosyal Mühendislik Yazılımları!', 'hubi': '💡 Sosyal mühendislik, insanları kandırarak bilgi elde etme sanatıdır. Kimse senden şifreni istemez, buna kanma!'},
    {'on': 'Dosyaların bir kopyasını başka bir yerde saklamaya ne denir?', 'arka': 'Yedekleme (Backup)!', 'hubi': '💡 Bir şey silinirse korkma, yedeğin varsa güvendesin. Önemli fotoğraf ve belgelerin harici bir belleğe kopyalanmasıdır.'},
    {'on': 'Güvenlik açıklarını kapatmak ve performansı artırmak için ne yapılmalıdır?', 'arka': 'Sistem Güncellemesi!', 'hubi': '💡 Güncellemeleri erteleme, sistemini hep taze tut! Güvenlik duvarını ve açıklarını en güncel seviyeye çıkarır.'},
  ];

  int suAnkiKartIndex = 0;
  bool oyunBasladiMi = false;
  bool kartDonduMu = false;
  final Color siberTemaRengi = const Color(0xffFDE24F);

  void _hubiYardimGoster(String mesaj) {
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)), 
        title: const Row(children: [Icon(Icons.smart_toy_rounded, color: Colors.orange), SizedBox(width: 10), Text("Hubi'nin Notu... 💡")]), 
        content: Text(mesaj, style: const TextStyle(fontSize: 18, height: 1.4)), 
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("Anladım!", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))]
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xffFFFDE7), Color(0xffFDE24F)], begin: Alignment.topLeft, end: Alignment.bottomRight)), 
        child: Column(
          children: [
            AppBar(
              title: const Text('Siber Kahraman', style: TextStyle(color: Color(0xff2A2D34), fontWeight: FontWeight.bold, fontSize: 24)), 
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
                              decoration: BoxDecoration(color: siberTemaRengi, borderRadius: BorderRadius.circular(22), border: Border.all(color: const Color(0xff2A2D34), width: 3)), 
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
    child: Container(decoration: BoxDecoration(color: siberTemaRengi, borderRadius: BorderRadius.circular(22), border: Border.all(color: const Color(0xff2A2D34), width: 3)), child: const Icon(Icons.security_rounded, size: 90, color: Color(0xff2A2D34)))
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
            decoration: BoxDecoration(color: arkasiGozukuyorMu ? Colors.orangeAccent : siberTemaRengi, borderRadius: BorderRadius.circular(28), border: Border.all(color: const Color(0xff2A2D34), width: 3.5)), 
            child: Transform(
              alignment: Alignment.center, transform: arkasiGozukuyorMu ? (Matrix4.identity()..rotateY(math.pi)) : Matrix4.identity(), 
              child: Padding(
                padding: const EdgeInsets.all(12), 
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, 
                  children: [
                    Text("${suAnkiKartIndex + 1}. Kart", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)), 
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
                          onPressed: () => _hubiYardimGoster(kartlar[suAnkiKartIndex]['hubi']!), 
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
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SoruHaritasiSiber())); 
          } 
        }, 
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20), 
          decoration: BoxDecoration(color: sonKartMi ? Colors.orangeAccent : siberTemaRengi, borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xff2A2D34), width: 3)), 
          child: Center(child: Text(sonKartMi ? 'SORU HARİTASINA GİT 🗺️' : 'SIRADAKİ KART ➡️', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xff2A2D34))))
        )
      )
    ); 
  }
}

class SoruHaritasiSiber extends StatefulWidget { const SoruHaritasiSiber({super.key}); @override State<SoruHaritasiSiber> createState() => _SoruHaritasiSiberState(); }
class _SoruHaritasiSiberState extends State<SoruHaritasiSiber> {
  @override
  Widget build(BuildContext context) { 
    int anlikToplamPuan = SharedPrefsHelper.getPuan();
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xffFFFDE7), Color(0xffFDE24F)], begin: Alignment.topLeft, end: Alignment.bottomRight)), 
        child: Column(
          children: [
            AppBar(title: const Text("Soru Haritası"), backgroundColor: Colors.transparent, elevation: 0, actions: [Padding(padding: const EdgeInsets.all(15), child: Text("🏆 $anlikToplamPuan XP", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Color(0xff2A2D34))))]), 
            Expanded(
              child: ListView.builder(
                itemCount: 10, 
                itemBuilder: (context, i) { 
                  bool kilitliMi = i > (SharedPrefsHelper.getLevel("Siber") - 1); 
                  return GestureDetector(
                    onTap: () async { 
                      if (!kilitliMi) { 
                        await Navigator.push(context, MaterialPageRoute(builder: (context) => SoruDetaySiber(seviye: i + 1, onBasari: (p) {
                          SharedPrefsHelper.setLevel("Siber", i + 2); 
                          SharedPrefsHelper.puanArttir(p).then((_) { setState(() {}); });
                        }))); 
                        setState(() {}); 
                      } 
                    }, 
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 30), padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20), 
                      decoration: BoxDecoration(color: kilitliMi ? Colors.grey[400] : Color.lerp(const Color(0xffFDE24F), Colors.orange, i / 9), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white, width: 3)), 
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center, 
                        children: [
                          Icon(kilitliMi ? Icons.lock : Icons.security, color: Colors.white, size: 35), 
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

class SoruDetaySiber extends StatefulWidget { final int seviye; final Function(int) onBasari; const SoruDetaySiber({super.key, required this.seviye, required this.onBasari}); @override State<SoruDetaySiber> createState() => _SoruDetaySiberState(); }
class _SoruDetaySiberState extends State<SoruDetaySiber> {
  int puan = 15;
  final List<Map<String, dynamic>> sorular = [
    {'soru': 'Sahte e-posta ile bilgi çalma?', 'siklar': ['Phishing', 'RAM', 'Dosya', 'Kablo'], 'dogru': 0, 'cevap': 'Phishing', 'ipucu': '💡 Bir balıkçının oltanın ucuna solucan takıp balıkları kandırması gibi, siber korsanlar da "Bedava oyun altını" yemiyle seni avlamaya çalışıyor. Kanma!'},
    {'soru': 'Güçlü parola nasıl olur?', 'siklar': ['Kısa', 'Sadece rakam', 'Karışık ve uzun', 'İsim'], 'dogru': 2, 'cevap': 'Karışık ve uzun', 'ipucu': '💡 Sadece 1234 yazarsan kalenin kapısını açık bırakırsın! Güçlü bir şifre kalesi için içine büyük-küçük harfler, sayılar ve gizli semboller saklamalısın.'},
    {'soru': 'İkinci bir kilit yöntemi (2FA)?', 'siklar': ['VPN', '2FA', 'RAM', 'SSD'], 'dogru': 1, 'cevap': '2FA', 'ipucu': '💡 Korsanlar şifreni çalsa bile, telefonuna gelen o gizli onay kodu olmadan hesabına asla giremezler. Kalenin arkasına eklenen ikinci gizli kapı gibidir!'},
    {'soru': 'Kötü amaçlı yazılım türü?', 'siklar': ['Malware', 'Dosya', 'Kablo', 'Ekran'], 'dogru': 0, 'cevap': 'Malware', 'ipucu': '💡 Bilgisayara sızıp onu yavaşlatmaya çalışan siber mikroplara karşı, elinde koruyucu şurubuyla bekleyen o sadık "dijital doktoru" düşün!'},
    {'soru': 'Güvenli ağ bağlantısı (SSL) adresi hangisiyle başlar?', 'siklar': ['http://', 'ftp://', 'https://', 'www.'], 'dogru': 2, 'cevap': 'https://', 'ipucu': '💡 İnternet sitesinin adres çubuğunun en solunda duran o minik, güvenli kilit sembolünü ve site adresinin https:// ile başladığını hayal et.'},
    {'soru': 'İnternet trafiğini şifreleyen gizli geçit?', 'siklar': ['VPN', 'URL', 'IP', 'SSD'], 'dogru': 0, 'cevap': 'VPN', 'ipucu': '💡 Tarihte gizli ajanların mektupları düşman eline geçmesin diye harfleri kaydırarak kullandığı o gizemli şifreleme mantığını hatırla.'},
    {'soru': 'Siber mikropları temizleyen kalkan görevi gören program?', 'siklar': ['Antivirüs', 'Klavye', 'Fare', 'Ekran'], 'dogru': 0, 'cevap': 'Antivirüs', 'ipucu': '💡 Dijital dünyadaki kalkanın antivirüs programındır.'},
    {'soru': 'İnsanları kandırarak gizli bilgi elde etme tuzağı?', 'siklar': ['Sosyal Mühendislik', 'RAM', 'SSD', 'Dosya'], 'dogru': 0, 'cevap': 'Sosyal Mühendislik', 'ipucu': '💡 İnternette birisi sana kötü sözler söylerse asla korkma; o kişiyi hemen engelle ve durumu ailene anlat!'},
    {'soru': 'Dosya kopyası saklama ve koruma işlemine ne denir?', 'siklar': ['Yedekleme', 'Silme', 'RAM', 'Klavye'], 'dogru': 0, 'cevap': 'Yedekleme', 'ipucu': '💡 Bir şey silinirse korkma, yedeğin varsa güvendesin. Dosyaların bir kopyasını başka bir yerde saklamaktır.'},
    {'soru': 'Sistemi siber tehlikelere karşı taze tutmak için hangisi şarttır?', 'siklar': ['Güncelleme', 'Silme', 'Kablo', 'Ekran'], 'dogru': 0, 'cevap': 'Güncelleme', 'ipucu': '💡 Güncellemeleri erteleme, sistemini hep taze tut! Güvenlik açıklarını kapatır ve performansı artırır.'},
  ];

  void _soruDetayAIYardimGoster(String ipucuText) {
    showDialog(
      context: context, 
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)), 
        title: const Row(children: [Icon(Icons.smart_toy_rounded, color: Colors.orange), SizedBox(width: 10), Text("Hubi'nin İpucu")]), 
        content: Padding(padding: const EdgeInsets.symmetric(vertical: 10), child: Text(ipucuText, style: const TextStyle(fontSize: 18, height: 1.4))), 
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("Anladım", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange)))]
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    final q = sorular[(widget.seviye - 1).clamp(0, sorular.length - 1)];
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, leading: IconButton(icon: const Icon(Icons.close, color: Colors.black), onPressed: () => Navigator.pop(context))),
      body: Container(
        decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xffFFFDE7), Color(0xffFDE24F)], begin: Alignment.topLeft, end: Alignment.bottomRight)), 
        child: Padding(
          padding: const EdgeInsets.all(25), 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [
              Text("Soru Puanı: $puan", style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.orange)),
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
                          title: const Text("Yanlış Cevap ⚠️", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)), 
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