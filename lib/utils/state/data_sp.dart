// import 'package:flutter_openim_sdk/flutter_openim_sdk.dart';
// import '/models/login_certificate.dart';
import 'dart:convert';

import 'package:flutter_rust_bridge_template/models/wallet/wallets_group.dart';
import 'package:flutter_rust_bridge_template/models/wallet/wallets_group_read.dart';
import 'package:flutter_rust_bridge_template/utils/log/logger.dart';
import 'package:get/get.dart';
import 'package:sprintf/sprintf.dart';
import 'package:uuid/uuid.dart';
import 'package:vara_sdk/polkawallet_sdk.dart';
import 'package:vara_sdk/storage/keyring.dart';

import '../../models/wallet/wallets.dart';
import '../config/config.dart';
import '../storage/general.dart';
import 'sp_util.dart';

class DataSp {
  static const _walletKey = 'zkTransfer';

  // data key
  static const _loginCertificate = 'loginCertificate';
  // read only, no sensitive info
  static const _walletGroupRead = '%s_walletGroupRead';

  // wallet
  static const _selectedWalletGroupIdx = '%s_selectedWalletGroupIdx';
  static const _selectedWalletIdx = '%s_selectedWalletIdx';
  static const _maxWalletGroupIdx = '_maxWalletGroupIdx';

  // managers
  // late WalletSDK varaSdk;
  static late WalletSDK varaSdk;
  static late Keyring keyRing;

  DataSp._() {
    // varaSdk = WalletSDK();
  }

  static init() async {
    await SpUtil().init();
    varaSdk = WalletSDK();
    keyRing = Keyring();
  }

  //  wallet
  static void setSS58(int ss58) {
    keyRing.setSS58(ss58);
  }

  static int getSelectedWalletGroupIdx() {
    return SpUtil().getInt(getKey(_selectedWalletGroupIdx), defValue: 0) ?? 0;
  }

  static int getSelectedWalletIdx() {
    return SpUtil().getInt(getKey(_selectedWalletIdx), defValue: 0) ?? 0;
  }

  static WalletRead get selectedWalletRead {
    var walletGroupIdx = getSelectedWalletGroupIdx();
    var walletIdx = getSelectedWalletIdx();
    var walletGroup = walletGroupRead[walletGroupIdx];
    var wallet = walletGroup.wallets[walletIdx];
    return wallet;
  }

  static int getWalletGroupMaxID() {
    return SpUtil().getInt(_maxWalletGroupIdx, defValue: 0) ?? 0;
  }

  static void setWalletGroupMaxID(int id) {
    SpUtil().putInt(_maxWalletGroupIdx, id);
  }

  static int increaseWalletGroupMaxID() {
    var id = getWalletGroupMaxID();
    id++;
    setWalletGroupMaxID(id);
    return id;
  }

  static String getKey(String key) {
    // return sprintf(key, [OpenIM.iMManager.userID]);
    return sprintf(key, [_walletKey]);
  }

  static void addWalletGroup(WalletGroup walletGroup) {
    dbAddSafe(HiveDBName.walletGroup, walletGroup);
    var walletGroupRead = walletGroup.toWalletGroupRead();
    addWalletGroupRead(walletGroupRead);
  }

  // wallet group read
  static void addWalletGroupRead(WalletGroupRead walletGroup) async {
    List<WalletGroupRead> walletGroupRead = getWalletGroupRead() ?? [];
    walletGroupRead.add(walletGroup);

    final dataList =
        walletGroupRead.map((value) => json.encode(value.toJson())).toList();

    await SpUtil().putStringList(getKey(_walletGroupRead), dataList);
  }

  static List<WalletGroupRead> get walletGroupRead =>
      getWalletGroupRead() ?? [];
  static List<WalletGroupRead>? getWalletGroupRead() {
    final dataList = SpUtil().getStringList(getKey(_walletGroupRead));
    final walletList = dataList?.map((value) {
      return WalletGroupRead.fromJson(json.decode(value));
    }).toList();
    return walletList;
  }
}
