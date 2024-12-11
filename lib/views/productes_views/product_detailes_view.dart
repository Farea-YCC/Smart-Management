import 'package:flutter/material.dart';
import 'package:smart_management/models/ProducteModel.dart';
import 'package:smart_management/repository/productes_repository.dart';
import 'package:smart_management/widget/custom_appbar.dart';
class ProductsDetailesView extends StatefulWidget {///
  ProductsDetailesView({Key? key, required this.Id}) : super(key: key);///
  final int Id;


  @override
  State<ProductsDetailesView> createState() => _ProductsDetailesViewState();///
}

class _ProductsDetailesViewState extends State<ProductsDetailesView> {///

  Future<ProducteModel?> onPressed ()async {///
    var res = await ProductesRepository().getById(widget.Id);///
    return res;
  }
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customeAppBar(context, "  "),
      body:loading ?const Center(child: CircularProgressIndicator()):Container(
        child: FutureBuilder<ProducteModel?>(///
            future: onPressed(),
            builder: (context, snapshot){

              if(snapshot.connectionState == ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator(),);

              }
              else if(snapshot.connectionState == ConnectionState.done){
                if(snapshot.hasError){
                  return Center(child: Text("Error: ${snapshot.error}"),);

                }
                else if(snapshot.hasData){
                  var list = snapshot.data;

                  return RefreshIndicator(
                    onRefresh: ()async{
                      setState(() {

                      });
                    }, child: Column(
                    children: [
                      const SizedBox(height: 20,),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 3.0),
                                      child:const Text('اسم المنتج',style: TextStyle(///
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),)),
                                  const SizedBox(height: 15,),
                                  Text("${list?.productName}",style: const TextStyle(///
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                    fontSize: 17,
                                  )),
                                ],
                              ),
                            ],
                          ),

                          // color:Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 3.0),
                                      child:const Text('الكمية',style: TextStyle(///
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),)),
                                  const SizedBox(height: 15,),
                                  Text("${list?.quantity}",style: const TextStyle(///
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                    fontSize: 17,
                                  )),
                                ],
                              ),
                            ],
                          ),

                          // color:Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Directionality(
                        textDirection: TextDirection.rtl,

                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 3.0),
                                      child:const Text(' تاريخ الشراء',style: TextStyle(///
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),)),
                                  const SizedBox(height: 15,),
                                  Text("${list?.purchasePrice}",style: const TextStyle(///
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                    fontSize: 17,
                                  )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 3.0),
                                      child:const Text('سعر البيع',style: TextStyle(///
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),)),
                                  const SizedBox(height: 15,),
                                  Text("${list?.salePrice}",style: const TextStyle(///
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                    fontSize: 17,
                                  )),
                                ],
                              ),
                            ],
                          ),

                          // color:Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 3.0),
                                      child:const Text('الوصف',style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),)),
                                  const SizedBox(height: 5,),
                                  Text("${list?.description}",style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                    fontSize: 17,
                                  )),
                                ],
                              ),
                            ],
                          ),

                          // color:Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 3.0),
                                      child:const Text('الأجمالي',style: TextStyle(///
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),)),
                                  const SizedBox(height: 15,),

                                  const Text(" ",style: TextStyle(///
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                    fontSize: 17,
                                  )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),);
                }
              }
              throw '';  }
        ),
      ),
    );
  }
}