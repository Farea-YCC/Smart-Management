import '../db_helper/db_purchases_helper.dart'; // import library
import '../models/PurchaseModel.dart';

class PurchasesRepository{ //class name
  Future<List<PurchaseModel>> getAllFromDb()async{ // model type

    try{
      await Future.delayed(Duration(milliseconds: 300));
      var res = await DbHelper().getAll(DbTables.Purchases);//table name
      List<PurchaseModel> items = [];// model
      if(res != null){
        for (var e in res) {
          items.add(PurchaseModel.fromJson(e));// type of model
        }
        return items;
      }

      return items;
    }
    catch(ex){
      rethrow;
    }
  }

  Future<bool> addToDb(PurchaseModel obj)async{ // model type
    try{
      await Future.delayed(Duration(milliseconds: 300));
      var addRes = await DbHelper().add(DbTables.Purchases, obj.toJson());// table name
      if(addRes > 0){
        return true;
      }
      else{
        return false;
      }
    }
    catch(ex){
      rethrow;
    }
  }

  Future<PurchaseModel?> getById(int Id)async{ /// model type
    try{
      await Future.delayed(Duration(milliseconds: 300));
      var res = await DbHelper().getById(DbTables.Purchases, Id);/// table name
      PurchaseModel? item ;/// model
      if(res != null){
        item = PurchaseModel.fromJson(res);///
        return item;
      }
      return item;
    }
    catch(ex){
      rethrow;
    }
  }

  Future<bool> deleteFromDb(int id)async{
    try{
      await Future.delayed(Duration(milliseconds: 300));
      var delRes = await DbHelper().delete(DbTables.Purchases, id); // table name
      if(delRes > 0){
        return true;
      }
      else{
        return false;
      }
    }
    catch(ex){
      rethrow;
    }
  }

  Future<bool> updateToDb(PurchaseModel obj)async{
    try{
      await Future.delayed(Duration(milliseconds: 300));
      var delRes = await DbHelper().update(DbTables.Purchases, obj.toJson());
      if(delRes > 0){
        return true;
      }
      else{
        return false;
      }
    }
    catch(ex){
      rethrow;
    }
  }



}