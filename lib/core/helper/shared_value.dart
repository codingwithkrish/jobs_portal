import 'dart:developer';

import 'package:get_storage/get_storage.dart';

class SharedValue{
  static final _sharedBox=GetStorage();


  updateToken(String token){
  log(token);
    _sharedBox.write('userToken', token);
  }
  writeTokenIfNull(){
    _sharedBox.writeIfNull('userToken', '');
  }
 String? getToken(){
    return _sharedBox.read('userToken');
  }
}