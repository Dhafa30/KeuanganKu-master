import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:keuanganku/database/helper/data_wallet.dart';

class SQLModelWallet {
  SQLModelWallet({required this.id,required this.tipe,required this.judul});

  final int id;
  final String judul;
  final String tipe;

  static List<String> tipeWallet = [
    "Wallet",
    "Bank"
  ];

  static List<Widget> iconTipeWallet = [
    SvgPicture.asset("assets/icons/wallet_item.svg",height: 20,),
    SvgPicture.asset("assets/icons/bank_item.svg",height: 20,),
  ];
  
  Map<String, dynamic> toMap(){
    return {
      'id' : id,
      'tipe' : tipe,
      'judul' : judul
    };
  }

  static SQLModelWallet fromMap(Map<String, dynamic> map){
    return SQLModelWallet(id: map['id'],tipe: map['tipe'],  judul: map['judul']);
  }

  // getter
  Future<double> totalUang () async{
    return await SQLHelperWallet().readTotalUang(this);
  }

  String get iconPath {
    if (tipe == "Wallet") return "assets/icons/wallet_item.svg";
    return "assets/icons/bank_item.svg";
  }
}