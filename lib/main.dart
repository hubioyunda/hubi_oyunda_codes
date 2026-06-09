import 'package:flutter/material.dart';
import 'package:hubi_oyunda/core/shared_prefs_helper.dart';
import 'package:hubi_oyunda/screens/giris_ekrani.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Lokal hafıza başlatılıyor
  await SharedPrefsHelper.init();

  // Siber ateş (Streak) kontrol motoru tetiklenir
  await SharedPrefsHelper.siberAtesKontrolEt();

  runApp(const HubiOyundaApp());
}

class HubiOyundaApp extends StatelessWidget {
  const HubiOyundaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HUBİ OYUNDA',
      theme: ThemeData(fontFamily: 'Comic Sans MS'),
      home: const GirisEkrani(),
    );
  }
}

// 🔒 AKILLI SEVİYE HAFIZASI: Çocukların kaldığı seviyeyi hafızada tutan merkezi sınıf
class SeviyeVerisi {
  static int getLevel(String key) {
    return SharedPrefsHelper.getLevel(key);
  }
  static void setLevel(String key, int val) {
    SharedPrefsHelper.setLevel(key, val);
  }
}

// --- ZEHRA'NIN ARA SEÇİM EKRANI ---
class KonuSecimEkrani extends StatelessWidget {
  final String konuAdi;
  final Color anaRenk;
  final Widget hedefKartEkrani;
  final Widget hedefHaritaEkrani; 

  const KonuSecimEkrani({
    super.key, 
    required this.konuAdi, 
    required this.anaRenk, 
    required this.hedefKartEkrani,
    required this.hedefHaritaEkrani,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(konuAdi, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xff2A2D34))),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xff2A2D34)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Harika gidiyorsun!", style: TextStyle(fontSize: 22, color: Color.fromARGB(255, 55, 55, 55))),
            const SizedBox(height: 10),
            Text(konuAdi, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Color(0xff2A2D34))),
            const SizedBox(height: 50),
            
            _buyukSecimButonu(context, "Konu Kartlarına Çalış", Icons.style_rounded, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => hedefKartEkrani));
            }),
            const SizedBox(height: 20),
            _buyukSecimButonu(context, "Soru Haritasına Git", Icons.map_rounded, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => hedefHaritaEkrani)); 
            }),
          ],
        ),
      ),
    );
  }

  Widget _buyukSecimButonu(BuildContext context, String baslik, IconData icon, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity, height: 100,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          elevation: 3,
          shadowColor: Colors.black12,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30), side: BorderSide(color: anaRenk.withOpacity(0.3), width: 2)),
        ),
        onPressed: onTap,
        child: Row(
          children: [
            Container(padding: const EdgeInsets.all(15), decoration: BoxDecoration(color: anaRenk.withOpacity(0.15), borderRadius: BorderRadius.circular(20)), child: Icon(icon, color: anaRenk, size: 35)),
            const SizedBox(width: 20),
            Text(baslik, style: const TextStyle(fontSize: 20, color: Color(0xff2A2D34), fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}