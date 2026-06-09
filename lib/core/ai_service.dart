import 'package:google_generative_ai/google_generative_ai.dart';

class AIServisi {
  // ⚠️ Google AI Studio'dan aldığın API Key buraya gelecek
static const String _apiKey = " ";

  static final _systemInstruction = Content.system('''
    Sen "Hubi Oyunda" isimli mobil eğitim uygulamasının sevimli, neşeli ve zeki yapay zeka robotu "Hubi"sin. 
    Görevin: Ortaokul (10-12 yaş) seviyesindeki çocuklara bilişim teknolojileri, yazılım dünyası ve dijital okuryazarlık kartlarındaki veya testlerindeki sorularda yardımcı olmak.

    Şu kurallara KESİNLİKLE uymalısın:
    1. Çocuğa asla doğrudan doğru cevabı şık olarak ("A şıkkı", "Doğru cevap RAM" vb.) söyleme! Bunu yaparsan oyunun büyüsü bozulur.
    2. Cevabı kendisinin bulması için ona günlük hayattan basitleştirilmiş eğlenceli benzetmeler (analojiler) ve küçük, merak uyandırıcı ipuçları ver.
    3. Dilin her zaman çok samimi, neşeli, merak uyandırıcı ve emoji destekli olsun (Örn: "Selam Kahraman! 🚀", "Harika bir soru...").
    4. Cümlelerin kısa ve 10-12 yaşındaki bir çocuğun sıkılmadan okuyabileceği uzunlukta olsun.
  ''');

  static final GenerativeModel _model = GenerativeModel(
    model: 'gemini-1.5-flash',
    apiKey: _apiKey,
    systemInstruction: _systemInstruction,
  );

  static Future<String> ipucuAl({required String soru, required String dogruCevap}) async {
    try {
      final prompt = Content.text('''
        Çocuk şu an bir soruda takıldı ve senden yardım istiyor.
        Sorulan Soru: "$soru"
        Bu sorunun sistemdeki gizli doğru cevabı: "$dogruCevap"
        
        Lütfen doğru cevabı doğrudan ağzından kaçırmadan, çocuğun seviyesine uygun harika bir ipucu üret.
      ''');

      final response = await _model.generateContent([prompt]);
      return response.text ?? "🤖 Uhm, sanırım sinyallerim karıştı. Tekrar dener misin?";
    } catch (e) {
      return "🤖 Hubi şu an siber devriyede, ama vazgeçme! Soruyu tekrar okursan başarabilirsin! 💪";
    }
  }
}