@JS('chrome')
library main; // library name can be whatever you want

import 'package:js/js.dart';

@JS('runtime.sendMessage')
external sendMessage(ParameterSendMessage parameterSendMessage);

@JS('runtime.sendMessage')
external setSetting(ParameterSendMessage parameterSendMessage);

@JS('runtime.sendMessage')
external getSetting(ParameterSendMessage parameterSendMessage, Function callbac);

@JS()
@anonymous
class ParameterSendMessage {
  external String get type;
  external String get data;

  external factory ParameterSendMessage({String type, String data});
}