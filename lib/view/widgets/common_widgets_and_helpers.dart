import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controllers/header_controller.dart';


class TextFieldWidget extends StatefulWidget {
  final String hint;
  final TextEditingController? confirm;
  final TextEditingController controller;

  //final String initialValue;
  final String errMsg;
  final bool? isCapitalize;
  final TextInputType type;
  final bool? readOnly;
  final int? maxLines;
  final Function(String)? onChanged ;

  const TextFieldWidget({
    Key? key,
    required this.hint,
    this.confirm,
    this.maxLines,
    this.onChanged,
    required this.controller,
    //required this.initialValue,
    required this.errMsg,
    required this.type,
    this.readOnly,
    this.isCapitalize,
  }) : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(

      padding: const EdgeInsets.all(20),
      child: TextFormField(
     onTap: (){
       if (widget.controller.text == '0') {
         widget.controller.clear();
       }
     },
        onChanged: widget.onChanged,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: widget.controller,

        textCapitalization: widget.isCapitalize == true
            ? TextCapitalization.characters
            : TextCapitalization.none,
        readOnly: widget.readOnly ?? false,
        maxLines: widget.maxLines,

        keyboardType: widget.type,
        //obscureText: widget.secure == true ? _obscureText : false,
        decoration: InputDecoration(
          labelText: widget.hint,
            errorMaxLines: 2,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                color: Colors.black, //CColors.blackBorderCBCDD4,
                width: 1.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                color: Colors.black, //CColors.blackBorderCBCDD4,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                color: Colors.black, //CColors.blueMain0067FF,
                width: 1.0,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                color: Colors.black, //CColors.blackBorderCBCDD4,
                width: 1.0,
              ),
            ),
            contentPadding:
                const EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),

            fillColor: Colors.white),

        validator: (value) {
          if (value!.isEmpty|| value=="0") {
            return widget.errMsg;
          }


          return null;
        },
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  final String buttonName;
  final double? fontSize;
  final double? height;
  final bool isLoading;
  final void Function()? onpressed;

  const ButtonWidget({
    super.key,
    required this.buttonName,
    this.fontSize,
    this.height,
    this.onpressed,
    required this.isLoading,
  });
  static const txtStyle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20), //Ppadding.defualtPadding,
        child: !isLoading
            ? ElevatedButton(
                onPressed: !isLoading ? onpressed : null,
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all<Color>(
                    Colors.blue, //CColors.blueMain0067FF,
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(vertical: 0),
                  ),
                ),
                child: Ink(
                  decoration: const BoxDecoration(
                    color: Colors.blue, //CColors.blueMain0067FF,
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                  child: Container(
                      constraints: BoxConstraints(
                        minWidth: 88.0,
                        minHeight: height ?? 50,
                      ),
                      alignment: Alignment.center,
                      child:

                          /* isLoading
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          buttonName,
                          style: AppTextStyle.normalDesc(
                              fontColor: CColors.whiteMainffffff,
                              fontWeight: FontWeight.w600),
                        ),
                        horSpace(15),
                        const SizedBox(
                            height: 25,
                            width: 25,
                            child: CircularProgressIndicator()),
                      ],
                    )
                  : */
                          Text(
                        buttonName,
                        // style: AppTextStyle.normalDesc(
                        //     fontColor: CColors.whiteMainffffff,
                        //     fontWeight: FontWeight.w600),
                      )),
                ),
              )
            : const CircularProgressIndicator());
  }
}

class AppToast {
  static showToast(String txt) {
    Fluttertoast.showToast(
        msg: txt,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}

class OutlineButtonWidget extends StatelessWidget {
  final String buttonName;
  final double? fontSize;
  final bool isEnable;
  final double? height;
  final void Function()? onpressed;

  const OutlineButtonWidget({
    super.key,
    required this.buttonName,
    this.fontSize,
    this.height,
    required this.isEnable,
    this.onpressed,
  });
  static const txtStyle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20), //Ppadding.defualtPadding,
      child: ElevatedButton(
        onPressed: isEnable ? onpressed : null,
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all<Color>(
            Colors.lightBlue,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: 0),
          ),
        ),
        child: Ink(
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.blue),
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          ),
          child: Container(
              constraints: BoxConstraints(
                minWidth: 88.0,
                minHeight: height ?? 46,
              ),
              alignment: Alignment.center,
              child: Text(
                buttonName,
                // style: AppTextStyle.normalDesc(
                //     fontColor: Colors.blue,
                //     fontWeight: FontWeight.w600),
              )),
        ),
      ),
    );
  }
}

Row listItems(String key, String value, BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Text(
          key,

          overflow: TextOverflow.visible,
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey[700],
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      Expanded(
        child: Text(
          value,
          maxLines: 10,
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey[700],
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    ],
  );
}
Future<bool?> showConfirmationDialog() async {
  return await Get.defaultDialog(
    title: "",
    titleStyle: const TextStyle(fontSize: 16,),
    content: const Text("Are you sure you want to delete?"),
    actions: [
      TextButton(
        onPressed: () {
          Get.back(result: false); // Return false when "No" is pressed
        },
        child: const Text("No"),
      ),
      TextButton(
        onPressed: () {
          Get.back(result: true); // Return true when "Yes" is pressed
        },
        child: const Text("Yes"),
      ),
    ],
  );
}
String dateTimetoFormattedString(String dateTime) {

  return DateFormat('dd-MM-yyyy').format(DateTime.parse(dateTime));
}
void pickDate(BuildContext context, HeaderController hController) async {
  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2015, 8),
    lastDate: DateTime(2101),
  );

  if (pickedDate != null) {
    String formattedDisplayDate = DateFormat('dd-MM-yyyy').format(pickedDate);
    String formattedControllerDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(pickedDate); // Assumes time as well
    hController.dateController.text = formattedDisplayDate;
    hController.selectedDate=formattedControllerDate;

  }
}