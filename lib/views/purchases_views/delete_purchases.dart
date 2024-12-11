import 'package:flutter/material.dart';
import '../../repository/purchases_repository.dart';

class DeletePurchases extends StatefulWidget {
  DeletePurchases({Key? key, required this.testId}) : super(key: key);
  final int testId;
  @override
  State<DeletePurchases> createState() => _DeletePurchasesState();
}

class _DeletePurchasesState extends State<DeletePurchases> {
  bool loading = false;
  String txt = "هل انت متاكد من الحذف؟ ";
  bool isError = false;
  bool isSuccess = false;
  String error = "";
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        Navigator.of(context).pop(false);
        return false;

      },
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        scrollable: true,
        titlePadding: const EdgeInsets.all(10),
        title: const Center(child: Icon(Icons.delete)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        insetPadding: const EdgeInsets.all(10),
        content: Container(
          //color: Colors.yellow,
          constraints: const BoxConstraints(
              minWidth: 200,
              maxWidth: 300,
              maxHeight: 300,
              minHeight: 150
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              loading?Center(child: CircularProgressIndicator()):Container(child: Center(child: Text(txt),)),
              isError?Container(child: Center(child: Text("Error: $error", style: TextStyle(color: Colors.red),),)):SizedBox(),
              isSuccess?Container(child: Center(child: Icon(Icons.check_circle_outline, color: Colors.green,),)):SizedBox(),

              isSuccess
                  ?TextButton(onPressed: (){
                Navigator.of(context).pop(true);
              }, child: Text("OK"))
                  :Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                    TextButton(onPressed: ()async{
                      try {
                        setState(() {
                          loading = true;
                        });
                        var res= await PurchasesRepository().deleteFromDb(widget.testId);
                        if(res){
                          setState(() {
                            loading = false;
                            isError = false;
                            error="";
                            txt = "تم الحذف بنجاح!!!";
                            isSuccess = true;
                          });
                          //Navigator.of(context).pop(true);
                        }
                        else{
                          setState(() {
                            loading = false;
                            isError = true;
                            error ="فشلت العملية !!!";
                          });
                          //Navigator.of(context).pop(false);
                        }
                      } on Exception catch (e) {
                        setState(() {
                          loading = false;
                          isError = true;
                          error ="${e.toString()}";
                        });
                      }
                    }, child: Text("نعم")),
                    TextButton(onPressed: (){
                      Navigator.of(context).pop(false);
                    }, child: Text("لا")),
                ],),
                  ),

            ],
          ),
        ),

      ),
    );
  }
}
