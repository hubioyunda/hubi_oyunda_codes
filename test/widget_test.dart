import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hubi_oyunda/main.dart';

void main() {
  testWidgets('Giriş ekranı yükleme testi', (WidgetTester tester) async {
    // Güncel HubiOyundaApp yapısına göre test çağrılıyor
    await tester.pumpWidget(const HubiOyundaApp());

    expect(find.text('HUBİ OYUNDA'), findsOneWidget);
  });
}