import 'package:dinamik_not_ortalamasi_hesaplama/uygulamadaki_sabitler.dart';
import 'package:dinamik_not_ortalamasi_hesaplama/yardimci_datalar.dart';
import 'package:flutter/material.dart';

import 'ders.dart';

class DersListesi extends StatelessWidget {
  final Function
      onElemanCikarildi; // Çıkarılan elemanaların ortalamaya etki etmesi için fonk. (fonk. kullanılma sebebi stls widget diye bi tık)
  const DersListesi({required this.onElemanCikarildi, super.key});

  @override
  Widget build(BuildContext context) {
    List<Ders> tumDersler = DataHelper.tumEklenenDersler;
    return tumDersler.length > 0
        ? ListView.builder(
            itemCount: DataHelper.tumEklenenDersler.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: UniqueKey(), // birbirinden farklı keyler veriyor
                // otomatik olrak silme
                direction: DismissDirection.startToEnd,
                onDismissed: (a) {
                  // silinen elemanları ortalamaya yansıtma
                  onElemanCikarildi(index);
                },

                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Card(
                    child: ListTile(
                      title: Text(tumDersler[index].ad),
                      leading: CircleAvatar(
                        backgroundColor: Sabitler.anaRenk,
                        child: Text(
                          (tumDersler[index].harfDegeri *
                                  tumDersler[index].krediDegeri)
                              .toStringAsFixed(2),
                        ),
                      ),
                      subtitle: Text(
                          '${tumDersler[index].krediDegeri} Kredi , Not Değeri ${tumDersler[index].harfDegeri}'),
                    ),
                  ),
                ),
              );
            })
        : Container(
            child: Center(
              child: Text(
                'Lütfen Ders Ekleyin',
                style: Sabitler.baslikStyle,
              ),
            ),
          );
  }
}
