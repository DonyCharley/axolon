import 'package:axolon_test/controllers/header_controller.dart';
import 'package:axolon_test/view/widgets/common_widgets_and_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../model/header_model.dart';
import 'headers.dart';

class AddHeader extends StatefulWidget {
  const AddHeader({super.key});

  @override
  State<StatefulWidget> createState()=>_AddHeader();


}
class _AddHeader extends State<AddHeader>{


  final formKey = GlobalKey<FormState>();
  final hController = Get.put(HeaderController());


  @override
  Widget build(BuildContext context) {

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop){
        Get.off(const HeaderScreen());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar:  AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text("Add Header"),
          leading: IconButton(
              onPressed: () {
                Get.off(const HeaderScreen());
              },
              icon: const Icon(Icons.arrow_back_ios)),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextFieldWidget(
                    hint: "Name",
                    type: TextInputType.text,

                    errMsg: "Username required *",
                    controller: hController.nameController,
                  ),
                  TextFieldWidget(
                    hint: "Note",
                    maxLines: 5,
                    type: TextInputType.text,
                    errMsg: "Note required *",
                    controller: hController.notesController,
                  ),
                  // TextFieldWidget(
                  //   hint: "Total",
                  //   type: TextInputType.number,
                  //   errMsg: "Total required *",
                  //   controller: hController.totalController,
                  // ),

                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: TextFormField(
                      controller: hController.dateController,
                      onTap: () {

                        pickDate(context,hController);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Date required *";
                        }


                        return null;
                      },
                      readOnly: true,
                      decoration: const InputDecoration(
                                                labelText: 'Date',
                                                border: OutlineInputBorder(),
                                              ),
                    ),
                  ),


                  buttonWidget(context, false),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    hController.notesController.text='';
    hController.nameController.text='';
    hController.totalController.text='';
    hController.dateController.text='';
    super.dispose();
  }

  ButtonWidget buttonWidget(BuildContext context, bool isLoading) {
    return ButtonWidget(
      isLoading: isLoading,
      buttonName: "Save",
      onpressed: () {
        if (formKey.currentState!.validate()) {
          Header hTemp = Header(
              customer: hController.nameController.text,
              note: hController.notesController.text,
              //grandTotal: double.parse(hController.totalController.text),
              date: DateTime.parse(hController.selectedDate));
          try {
            hController.insertHeader(hTemp);
            AppToast.showToast("Added successfully");
            //hController.clearAllTextFields();
            Get.off(const HeaderScreen());
          } catch (e) {
            AppToast.showToast("Error while saving! Please try again!");
          }
        }
      },
    );
  }






}

