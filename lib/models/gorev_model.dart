import 'package:flutter/material.dart';
import 'package:hubi_oyunda/core/shared_prefs_helper.dart';
import 'package:hubi_oyunda/screens/profil_ekrani.dart';

class GorevMerkezi extends StatefulWidget {
  const GorevMerkezi({super.key});

  @override
  State<GorevMerkezi> createState() => _GorevMerkeziState();
}

class _GorevMerkeziState extends State<GorevMerkezi> {
  // İngilizce karakterli, güvenli yükleme görevi nesnesi
  late Future<void> _yuklemeGorevi;
  int toplamPuan = 0;

  @override
  void initState() {
    super.initState();
    // Sayfa açılırken yükleme işlemini başlatıyoruz
    _yuklemeGorevi = _verileriYukle();
  }

  Future<void> _verileriYukle() async {
    toplamPuan = SharedPrefsHelper.getPuan();
  }

  // Puan arttığında arayüzün anında yenilenmesi için bu fonksiyonu kullanacağız
  void _puanGuncelle(int eklenecekPuan) async {
    await SharedPrefsHelper.puanArttir(eklenecekPuan);
    setState(() {
      toplamPuan = SharedPrefsHelper.getPuan();
    });
  }

  // Profilde seçilen id'ye göre doğru resmi getiren siber motor
  String _avatarResmiGetir(int id) {
    if (id == 2) return 'assets/images/avatar2.jpg'; // Civciv (Sağda)
    if (id == 3) return 'assets/images/avatar3.jpg'; // Tilki (Ortada)
    return 'assets/images/avatar1.jpg'; // Varsayılan Aslan (Solda)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
          ),
        ),
        child: SafeArea(
          child: FutureBuilder(
            future: _yuklemeGorevi,
            builder: (context, snapshot) {
              // Veriler hafızadan okunurken ekranda siber bir yükleniyor dairesi döner
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(color: Color(0xFF00FFCC)),
                );
              }

              // Veriler başarıyla yüklendiği an değişkenleri çekiyoruz:
              final username = SharedPrefsHelper.getUsername();
              final avatarId = SharedPrefsHelper.getAvatarId();

              return Column(
                children: [
                  // --- SİBER ÜST BAR (Gülsena'nın Altyapısı) ---
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: const Color(0xFF334155), width: 2),
                      ),
                      child: Row(
                        children: [
                          // Çocuğun seçtiği dinamik avatar
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: const Color(0xFF00FFCC),
                            child: Padding(
                              padding: const EdgeInsets.all(3),
                              child: ClipOval(
                                child: Image.asset(
                                  _avatarResmiGetir(avatarId),
                                  fit: BoxFit.cover,
                                  width: 60,
                                  height: 60,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          // Dinamik İsim Alanı
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Selam, $username!",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  "Siber Göreve Hazır Mısın?",
                                  style: TextStyle(color: Color(0xFF8B5CF6), fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          // Dinamik Puan Kutusu (XP)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            decoration: BoxDecoration(
                              color: const Color(0xFF00FFCC).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: const Color(0xFF00FFCC), width: 1.5),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.bolt, color: Color(0xFF00FFCC), size: 22),
                                const SizedBox(width: 4),
                                Text(
                                  "$toplamPuan XP",
                                  style: const TextStyle(
                                    color: Color(0xFF00FFCC),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // --- ZEHRA'NIN KARTLARI İÇİN AYRILAN GÜVENLİ ALAN ---
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Veriler başarıyla bağlandı! 🚀",
                            style: TextStyle(color: Colors.white54, fontSize: 14),
                          ),
                          const SizedBox(height: 25),
                          
                          // Çocuğun istediği zaman nick ve avatar değiştirmesini sağlayan buton
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const ProfilEkrani()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF334155),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            ),
                            icon: const Icon(Icons.edit, size: 18, color: Color(0xFF00FFCC)),
                            label: const Text("Profili Düzenle / Değiştir", style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          const SizedBox(height: 15),

                          // Test amaçlı puan artırma butonu (Yarın Zehra'nın kartlarına entegre edeceğiz)
                          ElevatedButton(
                            onPressed: () => _puanGuncelle(10),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF8B5CF6),
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            ),
                            child: const Text("Test: 10 Puan Kazan", style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}