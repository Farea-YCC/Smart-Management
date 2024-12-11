import '../db_helper/db_sales_helper.dart'; // import library
import '../models/SaleModel.dart';

class SalesRepository{ //class name
  Future<List<SaleModel>> getAllFromDb()async{ // model type

    try{
      await Future.delayed(Duration(milliseconds: 300));
      var res = await DbHelper().getAll(DbTables.Sales);//table name
      List<SaleModel> items = [];// model
      if(res != null){
        for (var e in res) {
          items.add(SaleModel.fromJson(e));// type of model
        }
        return items;
      }

      return items;
    }
    catch(ex){
      rethrow;
    }
  }

  Future<bool> addToDb(SaleModel obj)async{ // model type
    try{
      await Future.delayed(Duration(milliseconds: 300));
      var addRes = await DbHelper().add(DbTables.Sales, obj.toJson());// table name
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

  Future<SaleModel?> getById(int Id)async{ /// model type
    try{
      await Future.delayed(Duration(milliseconds: 300));
      var res = await DbHelper().getById(DbTables.Sales, Id);/// table name
      SaleModel? item ;/// model
      if(res != null){
        item = SaleModel.fromJson(res);///
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
      var delRes = await DbHelper().delete(DbTables.Sales, id); // table name
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

  Future<bool> updateToDb(SaleModel obj)async{
    try{
      await Future.delayed(Duration(milliseconds: 300));
      var delRes = await DbHelper().update(DbTables.Sales, obj.toJson());
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