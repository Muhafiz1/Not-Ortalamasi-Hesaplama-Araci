import 'package:dinamik_not_ortalamasi_hesaplama/ortalama_hesaplama_page.dart';
import 'package:dinamik_not_ortalamasi_hesaplama/uygulamadaki_sabitler.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dinamik Ortalama Hesaplama',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Sabitler.anaRenk,
        visualDensity: VisualDensity
            .adaptivePlatformDensity, // diğer ortamlarda da sırıtmasın diye
      ),
      home: OrtalamaHesaplamaPage(),
    );
  }
}
