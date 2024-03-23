import 'package:axolon_test/controllers/header_controller.dart';
import 'package:axolon_test/view/widgets/common_widgets_and_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/header_model.dart';
import 'headers.dart';





class EditHeader extends StatefulWidget {
  late Header header;
  EditHeader({super.key, required this.header});
  @override
  State<StatefulWidget> createState()=>_EditHeader();

}

class _EditHeader extends State<EditHeader>{



  final formKey = GlobalKey<FormState>();
  final hController=Get.put(HeaderController());



  @override
  Widget build(BuildContext context) {

  return  PopScope(
    canPop: false,
    onPopInvoked: (didPop){
      Get.off(const HeaderScreen());
    },
    child: Scaffold(
      resizeToAvoidBottomInset: true ,
      appBar:  AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text("Edit Header"),
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  TextFieldWidget(hint: "Name",
                      confirm: hController.nameController,
                      //initialValue: header.customer,
                      type: TextInputType.text,
                      errMsg: "Username required *", controller: hController.nameController,),
                  TextFieldWidget(hint: "Note",
                    confirm: hController.notesController,
                   // initialValue: header.note,
                    maxLines: 5,
                    type: TextInputType.text,
                    errMsg: "Note required *", controller: hController.notesController,),

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

                  //ElevatedButton(onPressed: (){}, child: const Text("Save")),
                    buttonWidget(context, false),


                ],
              ),
            ),
          ),



        ),
      ),
    ),
  );

}






   ButtonWidget buttonWidget(BuildContext context, bool isLoading) {
     return ButtonWidget(
       isLoading: isLoading,
       buttonName: "Save",
       onpressed: () {
         if (formKey.currentState!.validate()) {

           Header hTemp = Header(id:widget.header.id ,
               customer: hController.nameController.text,
               note: hController.notesController.text,
               date: DateTime.parse(hController.selectedDate));
           try {
             hController.updateHeader(hTemp);
             AppToast.showToast("Updated successfully");
             Get.off(const HeaderScreen());
           } catch (e) {
             AppToast.showToast("Error while saving! Please try again!");
           }
         }
       },
     );
   }

  @override
  void dispose() {
    hController.nameController.text='';
    hController.notesController.text='';
    hController.dateController.text='';
    hController.totalController.text='';
    super.dispose();

  }

  @override
  void initState() {
    hController.nameController.text=widget.header.customer;
    hController.notesController.text=widget.header.note;
    hController.dateController.text=dateTimetoFormattedString(widget.header.date.toString());
    hController.totalController.text=widget.header.grandTotal.toString();
    super.initState();
  }
}