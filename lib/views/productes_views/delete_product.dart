import 'package:flutter/material.dart';
import '../../repository/productes_repository.dart';

class DeleteProduct extends StatefulWidget {
  DeleteProduct({Key? key, required this.testId}) : super(key: key);
  final int testId;
  @override
  State<DeleteProduct> createState() => _DeleteProductState();
}

class _DeleteProductState extends State<DeleteProduct> {
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
        scrollable: true,
        titlePadding: const EdgeInsets.all(16),
        title: const Center(child: Icon(Icons.delete)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        insetPadding: const EdgeInsets.all(0),
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
              loading?const Center(child: CircularProgressIndicator()):Container(child: Center(child: Text(txt),)),
              isError?Container(child: Center(child: Text("Error: $error", style: const TextStyle(color: Colors.red),),)):const SizedBox(),
              isSuccess?Container(child: const Center(child: Icon(Icons.check_circle_outline, color: Colors.green,),)):const SizedBox(),

              isSuccess
                  ?TextButton(onPressed: (){
                Navigator.of(context).pop(true);
              }, child: const Text("OK"))
                  :Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    TextButton(onPressed: ()async{
                      try {
                        setState(() {
                          loading = true;
                        });
                        var res= await ProductesRepository().deleteFromDb(widget.testId);
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
                            error ="فشلت العلية!!!";
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
                    }, child: const Text("نعم")),
                    TextButton(onPressed: (){
                      Navigator.of(context).pop(false);
                    }, child: const Text("لا")),
                ],),
                  ),

            ],
          ),
        ),

      ),
    );
  }
}
