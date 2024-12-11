import 'package:flutter/material.dart';
import 'package:smart_management/common/widget/custom_appbar.dart';
import 'package:smart_management/models/ExpensesModel.dart';
import 'package:smart_management/repository/expenses_repository.dart';
class ExepensesDetailesView extends StatefulWidget {///
  ExepensesDetailesView({Key? key, required this.Id}) : super(key: key);///
  final int Id;


  @override
  State<ExepensesDetailesView> createState() => _ExepensesDetailesViewState();///
}

class _ExepensesDetailesViewState extends State<ExepensesDetailesView> {///

  Future<ExpensesModel?> onPressed ()async {///
    var res = await ExpensesRepository().getById(widget.Id);///
    return res;
  }
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customeAppBar(context, " "),
      body:loading ?const Center(child: CircularProgressIndicator()):Container(
        child: FutureBuilder<ExpensesModel?>(
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
                                      child:const Text('جهة الصرف',style: TextStyle(///
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),)),
                                  const SizedBox(height: 15,),
                                  Text("${list?.exchangeDestination}",style: const TextStyle(///
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
                                      child:const Text('المبلغ المصروفة',style: TextStyle(///
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),)),
                                  const SizedBox(height: 15,),
                                  Text("${list?.amountSpent}",style: const TextStyle(///
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
                                      child:const Text('تاريخ الصرف',style: TextStyle(///
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),)),
                                  const SizedBox(height: 15,),
                                  Text("${list?.dateOfExchange}",style: const TextStyle(///
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