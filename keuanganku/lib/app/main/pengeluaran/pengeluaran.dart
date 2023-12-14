import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/main/pengeluaran/widgets/form_data_pengeluaran/form_data_pengeluaran.dart';
import 'package:keuanganku/app/reusable%20widgets/heading_text/heading_text.dart';
import 'package:keuanganku/app/reusable%20widgets/ringkasan_grafik/ringkasan_grafik.dart';
import 'package:keuanganku/app/state_bridge.dart';
import 'package:keuanganku/enum/data_transaksi.dart';
import 'package:keuanganku/util/date_util.dart';

class HalamanPengeluaran extends StatefulWidget {
  const HalamanPengeluaran({super.key});
  static StateBridge state = StateBridge();
  static Data data = Data();

  @override
  State<HalamanPengeluaran> createState() => _HalamanPengeluaranState();
}

class Data {
  RuCRingkasanGrafikData ringkasanGrafik = RuCRingkasanGrafikData();
  Data(){
    ringkasanGrafik.waktuTransaksi = WaktuTransaksi.Mingguan;
  }
}

class _HalamanPengeluaranState extends State<HalamanPengeluaran> {

  @override
  void initState() {
    super.initState();
    HalamanPengeluaran.state.init(() { 
      setState(() {
        
      });
    });
  }

  void updateState(){
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Events
    void tambahDataBaru(){
      showModalBottomSheet(
        context: context, 
        isScrollControlled: true,
        builder: (context) => FormDataPengeluaran(
          onSaveCallback: (){
            setState(() {});
          },
        ),
      );
    }

    widgetRingkasanGrafik(){
      
      return 
      Column(
        children: [
          RuCGrafikBarRingkasanTransaksi(
            context, 
            data: HalamanPengeluaran.data.ringkasanGrafik, 
            onUpdate: updateState, 
            title: enumDataTransaksiInfo(HalamanPengeluaran.data.ringkasanGrafik.waktuTransaksi),
            isSingleTransaction: true
          ).getWidget()
        ],
      );
    }

    Widget buildBody(){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeadingText().h1("Ringkasan", fontFamily: "QuickSand_Medium"),
          widgetRingkasanGrafik(),
        ],
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: ApplicationColors.primary,
        onPressed: tambahDataBaru,
        child: const Icon(Icons.add, color: Colors.white,),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildBody()
        ],
      )
    );
  }
}