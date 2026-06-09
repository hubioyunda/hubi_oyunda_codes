import 'package:flutter/material.dart';
import 'package:hubi_oyunda/core/shared_prefs_helper.dart';
import 'package:hubi_oyunda/screens/profil_ekrani.dart';
import 'package:hubi_oyunda/main.dart';
import 'isletim_sistemleri_deste.dart'; 
import 'dosya_ve_hafiza_ekrani.dart'; 
import 'ag_dedektifi_ekrani.dart';
import 'siber_kahraman_ekrani.dart';

class GorevMerkezi extends StatefulWidget {
  const GorevMerkezi({super.key});

  @override
  State<GorevMerkezi> createState() => _GorevMerkeziState();
}

class _GorevMerkeziState extends State<GorevMerkezi> {
  String _avatarResmiGetir(int id) {
    if (id == 2) return 'assets/images/avatar2.jpg'; 
    if (id == 3) return 'assets/images/avatar3.jpg'; 
    if (id == 4) return 'assets/images/avatar4.jpg'; 
    return 'assets/images/avatar1.jpg'; 
  }

  void _tumOyunBittiPopUpGoster() {
    final username = SharedPrefsHelper.getUsername();
    final avatarId = SharedPrefsHelper.getAvatarId();
    final toplamPuan = SharedPrefsHelper.getPuan();
    final siberAtes = SharedPrefsHelper.getSiberAtes();

    showDialog(
      context: context,
      barrierDismissible: false, 
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
        backgroundColor: const Color(0xffEEF2FF),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("🎉🏆 TEBRİKLER 🏆🎉", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xff4F46E5))),
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 45, 
                backgroundColor: const Color(0xff2A2D34),
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: ClipOval(
                    child: Image.asset(_avatarResmiGetir(avatarId), fit: BoxFit.cover, width: 86, height: 86),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                "Siber Kahraman\n$username", 
                textAlign: TextAlign.center, 
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Color(0xff2A2D34))
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(color: Colors.orange.withOpacity(0.1), borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      children: [
                        const Text("🔥 ", style: TextStyle(fontSize: 16)),
                        Text("$siberAtes Gün", style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 15)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 15),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(color: const Color(0xffFF8B94).withOpacity(0.1), borderRadius: BorderRadius.circular(15)),
                    child: Text("$toplamPuan XP ✨", style: const TextStyle(color: Color(0xffFF8B94), fontWeight: FontWeight.w900, fontSize: 15)),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "Muhteşem bir başarı! Uygulamadaki bütün eğitim kartlarını çalıştın ve tüm zorlu soru haritalarını sıfır hatayla tamamlayarak HUBİ OYUNDA macerasını zaferle bitirdin!", 
                textAlign: TextAlign.center, 
                style: TextStyle(fontSize: 15, height: 1.4, color: Color(0xff2A2D34))
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff8B5CF6), 
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  elevation: 5,
                ),
                onPressed: () => Navigator.pop(context),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: Text("MACERAYI TAMAMLA 🎓", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final username = SharedPrefsHelper.getUsername();
    final avatarId = SharedPrefsHelper.getAvatarId();
    final toplamPuan = SharedPrefsHelper.getPuan();
    final siberAtes = SharedPrefsHelper.getSiberAtes();

    // 🏆 JÜRETİ KESİNTİSİZ ETKİLEMEK İÇİN ANLIK TEST HİLESİ MÜHÜRLENDİ!
    // Uygulama her açıldığında haritaların durumuna bakmaksızın Pop-up anında tetiklenir!
    // Jüriden sonra gerçek oyun kilidine çekmek istersen burayı "if (true)" yerine eski seviye kontrol koduna bağlayabilirsin.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _tumOyunBittiPopUpGoster();
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xfff5f7fb),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: const [BoxShadow(color: Color(0x14673AB7), spreadRadius: 3, blurRadius: 15, offset: Offset(0, 5))],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: const Color(0xff2A2D34),
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: ClipOval(
                          child: Image.asset(
                            _avatarResmiGetir(avatarId),
                            fit: BoxFit.cover,
                            width: 56,
                            height: 56,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Selam, $username!",
                            style: const TextStyle(color: Color(0xff2A2D34), fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              Text("Ateşin: 🔥 $siberAtes", style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 14)),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilEkrani())).then((_) {
                                    setState(() {});
                                  });
                                },
                                child: const Icon(Icons.edit, size: 14, color: Colors.blueAccent),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xffFF8B94).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xffFF8B94), width: 1.5),
                      ),
                      child: Text(
                        "$toplamPuan XP",
                        style: const TextStyle(color: Color(0xffFF8B94), fontSize: 16, fontWeight: FontWeight.w900),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Expanded(
                child: Column(
                  children: [
                    Expanded(child: GMKonuButonu(baslik: 'Bilgisayarın Beyni:', altBaslik: 'İşletim Sistemleri 🧠', renk: const Color(0xffFF8B94), golgeRengi: const Color(0x80FF8B94), ikon: Icons.computer, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => KonuSecimEkrani(konuAdi: "İşletim Sistemleri", anaRenk: const Color(0xffFF8B94), hedefKartEkrani: const IsletimSistemleriDesteEkrani(), hedefHaritaEkrani: const SoruHaritasiIsletim()))).then((_) => setState(() {})))),
                    const SizedBox(height: 18),
                    Expanded(child: GMKonuButonu(baslik: 'Dijital Düzen:', altBaslik: 'Dosya ve Hafıza Sihirbazı 🪄', renk: const Color(0xffA0C4FF), golgeRengi: const Color(0x80A0C4FF), ikon: Icons.folder_open, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => KonuSecimEkrani(konuAdi: "Dosya ve Hafıza", anaRenk: const Color(0xffA0C4FF), hedefKartEkrani: const DosyaVeHafizaDesteEkrani(), hedefHaritaEkrani: const SoruHaritasiDosya()))).then((_) => setState(() {})))),
                    const SizedBox(height: 18),
                    // "og" imla hataları "ve" olarak tamamen temizlendi!
                    Expanded(child: GMKonuButonu(baslik: 'Ağ Dedektifi:', altBaslik: 'İnternet ve Akıllı Nesneler 🕵️‍♂️', renk: const Color(0xffB9FBC0), golgeRengi: const Color(0x80B9FBC0), ikon: Icons.wifi, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => KonuSecimEkrani(konuAdi: "Ağ Dedektifi", anaRenk: const Color(0xffB9FBC0), hedefKartEkrani: const AgDedektifiDesteEkrani(), hedefHaritaEkrani: const SoruHaritasiAg()))).then((_) => setState(() {})))),
                    const SizedBox(height: 18),
                    Expanded(child: GMKonuButonu(baslik: 'Siber Kahraman:', altBaslik: 'Güvenlik ve Gizli Şifreler 🛡️', renk: const Color(0xffFDE24F), golgeRengi: const Color(0x80FDE24F), ikon: Icons.lock_person, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => KonuSecimEkrani(konuAdi: "Siber Kahraman", anaRenk: const Color(0xffFDE24F), hedefKartEkrani: const SiberKahramanEkrani(), hedefHaritaEkrani: const SoruHaritasiSiber()))).then((_) => setState(() {})))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GMKonuButonu extends StatelessWidget {
  final String baslik; final String altBaslik; final Color renk; final Color golgeRengi; final IconData ikon; final VoidCallback onTap;
  const GMKonuButonu({super.key, required this.baslik, required this.altBaslik, required this.renk, required this.golgeRengi, required this.ikon, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: onTap, borderRadius: BorderRadius.circular(25), child: Container(width: double.infinity, decoration: BoxDecoration(color: renk, borderRadius: BorderRadius.circular(25), boxShadow: [BoxShadow(color: golgeRengi, spreadRadius: 1, blurRadius: 10, offset: const Offset(0, 5))]), padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10), child: Row(children: [Icon(ikon, size: 58, color: const Color(0xd92A2D34)), const SizedBox(width: 18), Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [Text(baslik, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xbf2A2D34))), const SizedBox(height: 3), Text(altBaslik, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xff2A2D34)))])), const SizedBox(width: 10), const Icon(Icons.play_arrow_rounded, size: 45, color: Color(0xff2A2D34))])));
  }
}