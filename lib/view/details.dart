import 'package:axolon_test/controllers/details_controller.dart';
import 'package:axolon_test/view/add_details.dart';
import 'package:axolon_test/view/edit_details.dart';
import 'package:axolon_test/view/headers.dart';
import 'package:axolon_test/view/widgets/common_widgets_and_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/detail_model.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreen();
}

class _DetailsScreen extends State<DetailsScreen> {
  String headerId = Get.arguments['headerId'];

  final detailsController = Get.put(DetailController());

  @override
  void initState() {
    super.initState();
    _getDetail = Future<List<Detail>>.delayed(const Duration(seconds: 0),
        () => detailsController.fetchDetails(int.parse(headerId)));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Get.to(() => const HeaderScreen());

      },
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: const Text("Details"),
            leading: IconButton(
                onPressed: () {

                  Get.to(() => const HeaderScreen());

                },
                icon: const Icon(Icons.arrow_back_ios)),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              var arguments = <String, String>{
                "headerId": headerId,
              };
              Get.off(const AddDetails(), arguments: arguments);
            },
            label: const Text("Add"),
            icon: const Icon(Icons.add_circle_outline_rounded),
          ),
          body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<List<Detail>>(
                  future: _getDetail,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return GetBuilder<DetailController>(

                          // init: HeaderController().fetchDetails(1),
                          builder: (_) => detailsController.details.isNotEmpty
                              ? Center(
                                  child: ListView.builder(
                                      padding: const EdgeInsets.all(20),
                                      physics: const BouncingScrollPhysics(),
                                      itemCount:
                                          detailsController.details.length,
                                      itemBuilder: (context, i) {
                                        return Card(
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
                                                    const EdgeInsets.all(15),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          detailsController
                                                              .details[i]
                                                              .productName
                                                              .toUpperCase(),
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: Colors
                                                                  .grey[800],
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 10),
                                                    const Divider(
                                                      height: 1,
                                                      indent: 0,
                                                      endIndent: 0,
                                                      color: Colors.black,
                                                      thickness: 0.5,
                                                    ),
                                                    const SizedBox(height: 10),
                                                    listItems(
                                                        "Product Code :",
                                                        detailsController
                                                            .details[i]
                                                            .productCode,
                                                        context),
                                                    const SizedBox(height: 10),
                                                    listItems(
                                                        "Rate :",
                                                        detailsController
                                                            .details[i].rate
                                                            .toString(),
                                                        context),
                                                    const SizedBox(height: 10),
                                                    listItems(
                                                        "Quantity :",
                                                        detailsController
                                                            .details[i].quantity
                                                            .toString(),
                                                        context),
                                                    const SizedBox(height: 10),
                                                    listItems(
                                                        "Grand Total :",
                                                        detailsController
                                                            .details[i].total
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
                                                          child: const Text(
                                                            "Edit",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .blueAccent),
                                                          ),
                                                          onPressed: () {
                                                            Get.off(EditDetails(
                                                              detail:
                                                                  detailsController
                                                                      .details[i],
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
                                                          child: const Text(
                                                            "Delete",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .blueAccent),
                                                          ),
                                                          onPressed: () async {
                                                            bool? confirmed =
                                                                await showConfirmationDialog();
                                                            if (confirmed !=
                                                                    null &&
                                                                confirmed) {
                                                              detailsController.deleteDetail(
                                                                  int.parse(detailsController
                                                                      .details[
                                                                          i]
                                                                      .id
                                                                      .toString()),
                                                                  detailsController
                                                                      .details[
                                                                          i]
                                                                      .headerId);


                                                            }
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              // const SizedBox(height: 5),
                                            ],
                                          ),
                                        );
                                        // return Card(
                                        //   elevation: 1,
                                        //   //margin: EdgeInsets.all(8),
                                        //   child: Column(
                                        //       mainAxisAlignment:
                                        //           MainAxisAlignment.center,
                                        //       children: <Widget>[
                                        //         const SizedBox(
                                        //           height: 20,
                                        //         ),
                                        //         Text(detailsController
                                        //             .details[i].productName),
                                        //         const SizedBox(
                                        //           height: 20,
                                        //         ),
                                        //         Text(detailsController
                                        //             .details[i].productCode),
                                        //         const SizedBox(
                                        //           height: 20,
                                        //         ),
                                        //         const SizedBox(
                                        //           height: 20,
                                        //         ),
                                        //         Text(detailsController
                                        //             .details[i].quantity.toString()),
                                        //         Text(detailsController
                                        //             .details[i].rate
                                        //             .toString()),
                                        //         const SizedBox(
                                        //           height: 20,
                                        //         ),
                                        //         Text(detailsController
                                        //             .details[i].total
                                        //             .toString()),
                                        //         const SizedBox(
                                        //           height: 20,
                                        //         ),
                                        //       ]),
                                        // );
                                      }))
                              : const Center(
                                  child: Text("No details to show!")));
                    }
                    return const Center(child: Text("No details to show!"));
                  }))),
    );
  }

  Future<List<Detail>>? _getDetail;
}
