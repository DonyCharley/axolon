import 'package:axolon_test/controllers/header_controller.dart';
import 'package:axolon_test/view/add_header.dart';
import 'package:axolon_test/view/details.dart';
import 'package:axolon_test/view/widgets/common_widgets_and_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/header_model.dart';
import 'edit_header.dart';

class HeaderScreen extends StatefulWidget {
  const HeaderScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HeaderScreen();
}

class _HeaderScreen extends State<HeaderScreen> {
  final headerController = Get.put(HeaderController());


  @override
  Widget build(BuildContext context) {

    //final headerController=Get.put(HeaderController());
    //controller.fetchHeaders();
    return PopScope(
      canPop: false,

      child: Scaffold(
          appBar:  AppBar(
            elevation: 0,
            centerTitle: true,
            title: const Text("Header"),
           automaticallyImplyLeading: false,
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Get.off(const AddHeader());
            },
            label: const Text("Add"),
            icon: const Icon(Icons.add),
          ),
          body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<List<Header>>(
                  future: _getHeader,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                    //  print("header list: "+headerController.header.isNotEmpty.toString()+headerController.header[0].customer);
      
      
      
                     return GetBuilder<HeaderController>(
      
                          builder: (_) =>
                          headerController.header.isNotEmpty?
      
      
                              Center(
                                  child: ListView.builder(
                                      padding: const EdgeInsets.all(20),
                                      physics: const BouncingScrollPhysics(),
      
                                      itemCount: headerController.header.length,
                                      itemBuilder: (context, i) {
      
      
                                        return  GestureDetector(
                                                onTap: () {
                                                  // print("headerId${headerController
                                                  //     .header[i].id}");
                                                  var arguments =
                                                      <String, String>{
                                                    "headerId": headerController
                                                        .header[i].id
                                                        .toString(),
                                                  };
                                                  Get.to(const DetailsScreen(),
                                                      arguments: arguments);
                                                },
                                                child: Card(
                                                  color: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(8),
                                                  ),
                                                  clipBehavior:
                                                      Clip.antiAliasWithSaveLayer,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Container(
                                                        //width: MediaQuery.of(context).size.width*.75,
                                                        padding:
                                                            const EdgeInsets.all(
                                                                15),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  headerController
                                                                      .header[i]
                                                                      .customer,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize: 16,
                                                                    color: Colors
                                                                            .grey[
                                                                        800],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                                height: 10),
                                                            const Divider(
                                                              height: 1,
                                                              indent: 0,
                                                              endIndent: 0,
                                                              color: Colors.black,
                                                              thickness: 0.5,
                                                            ),
                                                            const SizedBox(
                                                                height: 10),
                                                            listItems(
                                                                "Notes",
                                                                headerController
                                                                    .header[i]
                                                                    .note,
                                                                context),
                                                            const SizedBox(
                                                                height: 10),
      
                                                            listItems(
                                                                "Date :",
                                                                dateTimetoFormattedString(headerController
                                                                    .header[i]
                                                                    .date
                                                                    .toString())
                                                                ,
                                                                context),
                                                            const SizedBox(
                                                                height: 10),
                                                            listItems(
                                                                "Grand Total :",
                                                                headerController
                                                                    .header[i]
                                                                    .grandTotal
                                                                    .toString(),
                                                                context),
                                                            Row(
                                                              children: <Widget>[
                                                                const Spacer(),
                                                                TextButton(
                                                                  style: TextButton
                                                                      .styleFrom(
                                                                    foregroundColor:
                                                                        Colors
                                                                            .transparent,
                                                                  ),
                                                                  child:
                                                                      const Text(
                                                                    "Edit",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .blueAccent),
                                                                  ),
                                                                  onPressed: () {
                                                                    Get.off(
                                                                        EditHeader(
                                                                      header: headerController
                                                                          .header[i],
                                                                    ));
                                                                  },
                                                                ),
                                                                TextButton(
                                                                  style: TextButton
                                                                      .styleFrom(
                                                                    foregroundColor:
                                                                        Colors
                                                                            .transparent,
                                                                  ),
                                                                  child:
                                                                      const Text(
                                                                    "Delete",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .blueAccent),
                                                                  ),
                                                                  onPressed:
                                                                      () async {
                                                                        bool? confirmed = await showConfirmationDialog();
                                                                        if (confirmed != null && confirmed) {
                                                                          headerController.deleteHeader(int.parse(headerController.header[i].id.toString()));

                                                                        }

      
                                                                      },
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      // Add a small space between the card and the next widget
                                                      Container(height: 5),
                                                    ],
                                                  ),
                                                ),
                                                /* child: Card(
                        elevation: 1,
                        //margin: EdgeInsets.all(8),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const SizedBox(height: 20,),
                                Text(controller.headers[i].customer),
                                const SizedBox(height: 20,),
                                Text(controller.headers[i].note),
                                const SizedBox(height: 20,),
                                Text(controller.headers[i].date.toString()),
                                const SizedBox(height: 20,),
                                Text(controller.headers[i].grandTotal.toString()),
                                const SizedBox(height: 20,),
      
                                GestureDetector(child: const Text("edit",style: TextStyle(fontSize: 13),
      
      
      
                                ), onTap: (){
      
      
      
                                },),
      
      
                              ]),
                        ),
                      ),*/
                                              );
      
                                      }))
                               :const Center(child: Text("No data found!!")));}
                     else {
                      return const Center(child: Text("No data found!!"));
                    }
                  }))),
    );
  }


  Future<List<Header>>? _getHeader;

  @override
  void initState() {
    super.initState();
    _getHeader = Future<List<Header>>.delayed(
        const Duration(seconds: 0), () => headerController.fetchHeaders());
  }



}
