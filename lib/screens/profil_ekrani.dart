import 'package:flutter/material.dart';
import 'package:hubi_oyunda/core/shared_prefs_helper.dart';
import 'package:hubi_oyunda/screens/gorev_merkezi.dart';

class ProfilEkrani extends StatefulWidget {
  const ProfilEkrani({super.key});

  @override
  State<ProfilEkrani> createState() => _ProfilEkraniState();
}

class _ProfilEkraniState extends State<ProfilEkrani> {
  final TextEditingController _nameController = TextEditingController();
  int _selectedAvatarId = 1;

  @override
  void initState() {
    super.initState();
    _nameController.text = SharedPrefsHelper.getUsername() == 'Siber Kahraman' ? '' : SharedPrefsHelper.getUsername();
    _selectedAvatarId = SharedPrefsHelper.getAvatarId();
  }

  void _profilKaydet() async {
    String girilenIsim = _nameController.text.trim();
    if (girilenIsim.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen siber kod adını yaz kahraman!')),
      );
      return;
    }
    await SharedPrefsHelper.setUsername(girilenIsim);
    await SharedPrefsHelper.setAvatarId(_selectedAvatarId);

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const GorevMerkezi()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f7fb),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xff2A2D34)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "SİBER PROFİLİN",
                style: TextStyle(color: Color(0xff2A2D34), fontSize: 26, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _nameController,
                style: const TextStyle(color: Color(0xff2A2D34), fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  labelText: 'Siber Kod Adın (Nickname)',
                  labelStyle: const TextStyle(color: Color(0xff8B5CF6)),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xff8B5CF6), width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 35),
              const Text("Siber Karakterini Seç:", style: TextStyle(color: Color(0xff2A2D34), fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _avatarWidget(1, 'assets/images/avatar1.jpg', 'Tilki'),
                  _avatarWidget(2, 'assets/images/avatar2.jpg', 'Penguen'),
                  _avatarWidget(3, 'assets/images/avatar3.jpg', 'Baykuş'),
                  _avatarWidget(4, 'assets/images/avatar4.jpg', 'Rakun'),
                ],
              ),
              const SizedBox(height: 45),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: _profilKaydet,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff8B5CF6),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    elevation: 4,
                  ),
                  child: const Text("PROFİLİ KAYDET VE BAŞLA ✨", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _avatarWidget(int id, String path, String name) {
    bool isSelected = _selectedAvatarId == id;
    return GestureDetector(
      onTap: () => setState(() => _selectedAvatarId = id),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: isSelected ? const Color(0xff8B5CF6) : Colors.transparent, width: 3.5),
            ),
            child: CircleAvatar(radius: 34, backgroundImage: AssetImage(path)),
          ),
          const SizedBox(height: 8),
          Text(name, style: TextStyle(color: isSelected ? const Color(0xff8B5CF6) : const Color(0xff2A2D34).withOpacity(0.6), fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, fontSize: 14)),
        ],
      ),
    );
  }
}