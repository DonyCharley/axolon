import 'package:axolon_test/controllers/details_controller.dart';
import 'package:axolon_test/model/detail_model.dart';
import 'package:axolon_test/view/details.dart';
import 'package:axolon_test/view/widgets/common_widgets_and_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AddDetails extends StatefulWidget {
  const AddDetails({super.key});

  @override
  State<StatefulWidget> createState() => _AddDetails();
}

class _AddDetails extends State<AddDetails> {
  String headerId = Get.arguments['headerId'];
  final formKey = GlobalKey<FormState>();
  final dController = Get.put(DetailController());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop){
        var arguments = <String, String>{
          "headerId": headerId,
        };
        //dController.clearAllTextFields();
        Get.off(const DetailsScreen(), arguments: arguments);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar:  AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text("Add Details"),
          leading: IconButton(
              onPressed: () {
               // Get.to(const HeaderScreen());
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
                    errMsg: "Product name required *",
                    controller: dController.productNameController,
                  ),
                  TextFieldWidget(
                    hint: "Product Code",
                    maxLines: 1,
                    type: TextInputType.text,
                    errMsg: "Product Code required *",
                    controller: dController.productCodeController,
                  ),
                  TextFieldWidget(
                    hint: "Rate",
                    maxLines: 1,

                    onChanged: (value) {
                      dController.calculateTotal();
                    },
                    type: TextInputType.number,
                    errMsg: "Product rate required *",
                    controller: dController.productRateController,
                  ),
                  TextFieldWidget(
                    hint: "Quantity",
                    maxLines: 1,
                    onChanged: (value) {
                      dController.calculateTotal();
                    },
                    type: TextInputType.number,
                    errMsg: "Product rate required *",
                    controller: dController.productQtyController,
                  ),
                  TextFieldWidget(
                    hint: "Total",
                    maxLines: 1,
                    type: TextInputType.number,
                    errMsg: "Total required *",
                    readOnly: true,
                    controller: dController.totalController,
                  ),

                  //ElevatedButton(onPressed: (){}, child: const Text("Save")),
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

    dController.productRateController.text = '';
    dController.productQtyController.text = '';
    dController.totalController.text = '';
    dController.productCodeController.text = '';
    dController.productNameController.text = '';
    super.dispose();
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
              headerId: int.parse(headerId),
              productCode: dController.productCodeController.text);
          try {
            dController.insertDetail(dTemp);
            AppToast.showToast("Added successfully");

            var arguments = <String, String>{
              "headerId": headerId,
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

}
