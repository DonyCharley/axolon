import 'package:axolon_test/controllers/details_controller.dart';
import 'package:axolon_test/view/widgets/common_widgets_and_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/detail_model.dart';
import 'details.dart';






class EditDetails extends StatefulWidget {
  late Detail detail;
  EditDetails({super.key, required this.detail});
  @override
  State<StatefulWidget> createState()=>_EditDetails();

}

class _EditDetails extends State<EditDetails>{



  final formKey = GlobalKey<FormState>();
  final dController=Get.put(DetailController());



  @override
  Widget build(BuildContext context) {

    // TODO: implement build
  return  PopScope(
    canPop: false,
    onPopInvoked: (didPop){
      var arguments = <String, String>{
        "headerId": widget.detail.headerId.toString(),
      };
      //dController.clearAllTextFields();
      Get.off(const DetailsScreen(), arguments: arguments);
    },
    child: Scaffold(
      resizeToAvoidBottomInset: true ,
      appBar:  AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text("Edit Details"),
        leading: IconButton(
            onPressed: () {
              var arguments = <String, String>{
                "headerId": widget.detail.headerId.toString(),
              };
              //dController.clearAllTextFields();
              Get.off(const DetailsScreen(), arguments: arguments);
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

                  TextFieldWidget(hint: "Product Name",
                     // confirm: dController.productNameController,
                      //initialValue: header.customer,
                      type:TextInputType.text,
                      errMsg: "Product Name required *", controller: dController.productNameController,),
                  TextFieldWidget(hint: "Product code",
                   // confirm: dController.productCodeController,
                   // initialValue: header.note,
                    maxLines: 1,
                    type: TextInputType.text,
                    errMsg: "Product code required *", controller: dController.productCodeController),
                  TextFieldWidget(
                    hint: "Rate",
                    onChanged: (value){
                      dController.calculateTotal();
                    },
                    // confirm: hController.totalController,
                    //initialValue: header.grandTotal.toString()  ,
                    type: TextInputType.number,
                    errMsg: "Rate required *", controller: dController.productRateController,),
                  TextFieldWidget(
                    hint: "Quantity",
                    onChanged: (value){
                      dController.calculateTotal();
                    },
                    // confirm: hController.totalController,
                    //initialValue: header.grandTotal.toString()  ,
                    type: TextInputType.number,
                    errMsg: "Quantity required *", controller: dController.productQtyController,),
                  TextFieldWidget(
                    hint: "Total",
                   readOnly: true,
                   // confirm: hController.totalController,
                    //initialValue: header.grandTotal.toString()  ,
                    type: TextInputType.number,
                    errMsg: "Total required *", controller: dController.totalController,),


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
           Detail dTemp = Detail(
               rate: double.parse(dController.productRateController.text),
               total: double.parse(dController.totalController.text),
               quantity: double.parse(
                   dController.productQtyController.text.toString()),
               productName: dController.productNameController.text,
               headerId: widget.detail.headerId,
               id: widget.detail.id,
               productCode: dController.productCodeController.text);
           try {
             dController.updateDetail(dTemp);
             AppToast.showToast("Added successfully");

             var arguments = <String, String>{
               "headerId": widget.detail.headerId.toString(),
             };
             //dController.clearAllTextFields();
             Get.off(const DetailsScreen(), arguments: arguments);
           } catch (e) {
             AppToast.showToast("Error while saving! Please try again!");
           }
         }
       },
     );
   }

  @override
  void dispose() {
   // print("in dispose");
 dController.productRateController.text='';
 dController.productQtyController.text='';
 dController.productCodeController.text='';
 dController.productNameController.text='';
 dController.totalController.text='';



    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    //print("in init");
    dController.productRateController.text=widget.detail.rate.toString();
    dController.productQtyController.text=widget.detail.quantity.toString();
    dController.productCodeController.text=widget.detail.productCode.toString();
    dController.productNameController.text=widget.detail.productName.toString();
    dController.totalController.text=widget.detail.total.toString();

  }
}