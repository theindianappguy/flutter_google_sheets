import 'dart:convert' as convert;
import 'package:flutter_google_sheets/model/form.dart';
import 'package:http/http.dart' as http;


class FormController {
  // Callback function to give response of status of current request.
  final void Function(String) callback;

  // Google App Script Web URL
  static const String URL = "https://script.google.com/macros/s/AKfycbzFd5Cw0itASDzFgIrdr97j8PbfWHw1iVcoJWhbChPKfO2c2sA/exec";

  static const STATUS_SUCCESS = "SUCCESS";

  FormController(this.callback);

  void submitForm(FeedbackForm feedbackForm) async{
    try{
      await http.get(URL + feedbackForm.toParams()).then(
          (response){
            callback(convert.jsonDecode(response.body)['status']);
          });
    } catch(e){
      print(e);
    }
  }
}