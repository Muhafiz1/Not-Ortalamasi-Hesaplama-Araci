import 'dart:ffi';
import 'package:dinamik_not_ortalamasi_hesaplama/ders_listesi.dart';
import 'package:dinamik_not_ortalamasi_hesaplama/yardimci_datalar.dart';
import 'package:dinamik_not_ortalamasi_hesaplama/ortalama_goster.dart';
import 'package:dinamik_not_ortalamasi_hesaplama/uygulamadaki_sabitler.dart';
import 'package:flutter/material.dart';
import 'ders.dart';

class OrtalamaHesaplamaPage extends StatefulWidget {
  const OrtalamaHesaplamaPage({super.key});

  @override
  State<OrtalamaHesaplamaPage> createState() => _OrtalamaHesaplamaPageState();
}

class _OrtalamaHesaplamaPageState extends State<OrtalamaHesaplamaPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  double secilenHarfDegeri =
      4; // sürekli çalışmasın diye fonksiyonun içinden yukarı aldık
  double secilenKrediDegeri = 1; // aşağıda fonksiyonları için ikisininde
  String girilenDersAdi = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset:
            false, // Özellikle yan döndürmede klavye hatası
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0, // transparan için
          title: Center(
            child: Text(
              Sabitler.baslikText,
              style: Sabitler.baslikStyle,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment:
              CrossAxisAlignment.stretch, // her yeri kaplaması için yatayda
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: _buildForm(),
                ),
                Expanded(
                  flex: 2,
                  child: OrtalamaGoster(
                      dersSayisi: DataHelper.tumEklenenDersler.length,
                      ortalama: DataHelper.OrtalamaHesapla()),
                ),
              ],
            ),
            Expanded(
              flex: 1,
              child: DersListesi(
                // silinen elemanları ortalamaya yansıtma
                onElemanCikarildi: (index) {
                  DataHelper.tumEklenenDersler.removeAt(index);
                  setState(() {});
                },
              ),
            ),
          ],
        ));
  }

  Widget _buildForm() {
    return Form(
      key: formKey,
      child: Column(children: [
        Padding(
          padding: Sabitler.yatayPadding8,
          child: _buildTextFormField(),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              // 2 EXPANDITTA DA PADDİNG BOYUTUNDA HATA VERİYOR !
              child: _buildHarfler(),
            ),
            Expanded(
              child: _buildKrediler(),
            ),
            IconButton(
              onPressed: _dersEkleOrtalamaHesapla,
              icon: Icon(Icons.arrow_forward_ios_sharp),
              color: Sabitler.anaRenk,
              iconSize: 29,
            ),
          ],
        ),
        SizedBox(
          height: 26,
        ),
      ]),
    );
  }

  _buildTextFormField() {
    return TextFormField(
      onSaved: (deger) {
        setState(() {
          girilenDersAdi = deger!;
        });
      },
      validator: (s) {
        if (s!.length <= 0) {
          return 'Ders adini giriniz';
        } else
          return null;
      },
      decoration: InputDecoration(
        hintText: 'Matematik',
        border: OutlineInputBorder(
            borderRadius: Sabitler.borderRadius, borderSide: BorderSide.none),
        filled: true,
        fillColor: Sabitler.anaRenk.shade100.withOpacity(0.2),
      ),
    );
  }

  _buildHarfler() {
    return Container(
      alignment: Alignment.center,
      padding: Sabitler.dropdownPadding,
      // margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Sabitler.anaRenk.shade100.withOpacity(0.3),
          borderRadius: Sabitler.borderRadius),
      child: DropdownButton<double>(
        value: secilenHarfDegeri,
        elevation: 16,
        iconEnabledColor: Sabitler.anaRenk.shade200,
        onChanged: (deger) {
          // değişiklik olması için gerekli
          setState(() {
            secilenHarfDegeri = deger!;
            print(deger);
          });
        },
        underline: Container(),
        items: DataHelper.tumDerslerinHarflerii(),
        //alttakinin yerine data helperda yapıp burada çağırdık

        /*[DropdownMenuItem(
            child: Text('AA'),
            value: 4,
          ),
          DropdownMenuItem(
            child: Text('BA'),
            value: 3.5,
          ),
          DropdownMenuItem(
            child: Text('BB'),
            value: 3.0,
          ),
          DropdownMenuItem(
            child: Text('CB'),
            value: 2.5,
          ),
          ],
          */
      ),
    );
  }

  _buildKrediler() {
    return Container(
      alignment: Alignment.center,
      padding: Sabitler.dropdownPadding,
      // margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Sabitler.anaRenk.shade100.withOpacity(0.3),
          borderRadius: Sabitler.borderRadius),
      child: DropdownButton<double>(
        value: secilenKrediDegeri,
        elevation: 16,
        iconEnabledColor: Sabitler.anaRenk.shade200,
        onChanged: (deger) {
          // değişiklik olması için gerekli
          setState(() {
            secilenKrediDegeri = deger!;
            print(deger);
          });
        },
        underline: Container(),
        items: DataHelper.tumDerslerinKredileri(),
      ),
    );
  }

  dynamic _dersEkleOrtalamaHesapla() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      var eklenecekDers = Ders(
        ad: girilenDersAdi, // yukarıdaki sabitler yerine bunları atadık
        harfDegeri: secilenHarfDegeri,
        krediDegeri: secilenKrediDegeri,
      );
      DataHelper.dersEkle(eklenecekDers);
      setState(() {});
    }
  }
}

/*
  Bölümler yapılırken tek tek fonksiyonlara atandı . Silinen derslerin ortalamaya etkisi için fonk. tanımlanıp sayfalara atandı.

  



 */
//  Not :
//Her şey tek tek atandı , fonksiyonalrı ve klasları inceleyerek bak

// Extra kendime not :ana sayfada ortalama goster oluşturulup içine ortalama hesaplama atanıp işlemlerin ders.dart çağrılarak yapıldı.