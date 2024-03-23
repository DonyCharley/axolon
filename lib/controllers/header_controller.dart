import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../model/header_model.dart';
import '../services/db_service/db_helper.dart';

class HeaderController extends GetxController{

  final dbHelper = DatabaseHelper();
 // var headers = <Header>[].obs;

  List<Header> header = [];
  String selectedDate='';

  TextEditingController nameController=TextEditingController();
  TextEditingController notesController=TextEditingController();
  TextEditingController totalController=TextEditingController();
  TextEditingController dateController=TextEditingController();




  @override
  void onInit() {
    super.onInit();
    //fetchHeaders();
  }

  Future<List<Header>> fetchHeaders() async {
    print("fetched Header data");
   // headers.value = await dbHelper.getHeaders();
    header=await dbHelper.getHeaders();
    update();
    for(Header m in header)
      {
        print(m.customer);
      }
    return header;
    //

  }



  Future<void> insertHeader(Header header) async {



      await dbHelper.insertHeader(header);
      update();

    fetchHeaders();
  }

  Future<void> updateHeader(Header header) async {
    await dbHelper.updateHeader(header);
    fetchHeaders();
  }

  Future<void> deleteHeader(int id) async {
    await dbHelper.deleteHeader(id);
    update();
    fetchHeaders();
  }




}
