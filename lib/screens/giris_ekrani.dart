import 'package:flutter/material.dart';
import 'package:hubi_oyunda/core/shared_prefs_helper.dart';
import 'package:hubi_oyunda/screens/profil_ekrani.dart';
import 'package:hubi_oyunda/screens/gorev_merkezi.dart';

class GirisEkrani extends StatelessWidget {
  const GirisEkrani({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/giris_arka_plan.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 60),
                child: SizedBox(
                  width: double.infinity,
                  height: 70,
                  child: ElevatedButton(
                    onPressed: () {
                      String mevcutKullanici = SharedPrefsHelper.getUsername();
                      bool profilVarMi = mevcutKullanici != 'Siber Kahraman';

                      if (profilVarMi) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const GorevMerkezi()),
                        );
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const ProfilEkrani()),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff8B5CF6),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      elevation: 6,
                      shadowColor: const Color(0xff8B5CF6).withOpacity(0.35),
                    ),
                    child: const Text(
                      "MACERAYA BAŞLA 🚀",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, letterSpacing: 1.2),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}