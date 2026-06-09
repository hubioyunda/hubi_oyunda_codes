import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String getUsername() {
    return _prefs?.getString('username') ?? 'Siber Kahraman';
  }

  static Future<void> setUsername(String username) async {
    await _prefs?.setString('username', username);
  }

  static int getAvatarId() {
    return _prefs?.getInt('avatar_id') ?? 1;
  }

  static Future<void> setAvatarId(int id) async {
    await _prefs?.setInt('avatar_id', id);
  }

  static int getPuan() {
    return _prefs?.getInt('toplam_puan') ?? 0;
  }

  static Future<void> puanArttir(int miktar) async {
    int mevcut = getPuan();
    await _prefs?.setInt('toplam_puan', mevcut + miktar);
  }

  static Future<void> puanAzalt(int miktar) async {
    int mevcut = getPuan();
    int yeni = mevcut - miktar;
    if (yeni < 0) yeni = 0;
    await _prefs?.setInt('toplam_puan', yeni);
  }

  static int getSiberAtes() {
    return _prefs?.getInt('siber_ates') ?? 2; 
  }

  static Future<void> siberAtesKontrolEt() async {
    String? sonGiris = _prefs?.getString('son_giris_tarihi');
    String bugun = DateTime.now().toIso8601String().substring(0, 10);

    if (sonGiris == null) {
      await _prefs?.setString('son_giris_tarihi', bugun);
      await _prefs?.setInt('siber_ates', 2);
      return;
    }
    if (sonGiris != bugun) {
      DateTime son = DateTime.parse(sonGiris);
      DateTime simdi = DateTime.parse(bugun);
      int fark = simdi.difference(son).inDays;

      if (fark == 1) {
        int mevcutAtes = getSiberAtes();
        await _prefs?.setInt('siber_ates', mevcutAtes + 1);
      } else if (fark > 1) {
        await _prefs?.setInt('siber_ates', 2);
      }
      await _prefs?.setString('son_giris_tarihi', bugun);
    }
  }

  static int getLevel(String kategori) {
    return _prefs?.getInt('level_$kategori') ?? 1;
  }

  static Future<void> setLevel(String kategori, int yeniSeviye) async {
    int mevcut = getLevel(kategori);
    if (yeniSeviye > mevcut) {
      await _prefs?.setInt('level_$kategori', yeniSeviye);
    }
  }
}