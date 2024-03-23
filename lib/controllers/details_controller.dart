import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../model/detail_model.dart';
import '../model/header_model.dart';
import '../services/db_service/db_helper.dart';

class DetailController extends GetxController{

  final dbHelper = DatabaseHelper();
  var headers = <Header>[].obs;
  List<Detail> details = [];


  TextEditingController productNameController=TextEditingController();
  TextEditingController productCodeController=TextEditingController();
  TextEditingController productQtyController=TextEditingController(text: "0");
  TextEditingController productRateController=TextEditingController(text:"0");
  TextEditingController totalController=TextEditingController(text: "0");
  double total=0.00;
  double rate=0.00;
  double qty=0.00;




  Future<List<Detail>> fetchDetails(int headerId) async {

    details = await dbHelper.getDetails(headerId);


    return details;
    //update();

  }



  Future<void> insertDetail(Detail detail) async {
    await dbHelper.insertDetail(detail);
    fetchDetails(detail.headerId);
  }

  Future<void> updateDetail(Detail detail) async {
    await dbHelper.updateDetail(detail);
    fetchDetails(detail.headerId);
  }

  Future<void> deleteDetail(int id, int headerId) async {
    await dbHelper.deleteDetail(id);
    update();
    fetchDetails(headerId);
  }

  void calculateTotal() {
    qty=double.parse(productQtyController.text);
    rate=double.parse(productRateController.text);

    total=rate*qty;
    totalController.text=total.toStringAsFixed(2).toString();


  }
}
