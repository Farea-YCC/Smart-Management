import '../db_helper/db_suppliers_helper.dart'; // import library
import '../models/SupplierModel.dart';

class SuppliersRepository{ //class name
  Future<List<SupplierModel>> getAllFromDb()async{ // model type

    try{
      await Future.delayed(Duration(milliseconds: 300));
      var res = await DbHelper().getAll(DbTables.Suppliers);//table name
      List<SupplierModel> items = [];// model
      if(res != null){
        for (var e in res) {
          items.add(SupplierModel.fromJson(e));// type of model
        }
        return items;
      }

      return items;
    }
    catch(ex){
      rethrow;
    }
  }

  Future<bool> addToDb(SupplierModel obj)async{ // model type
    try{
      await Future.delayed(Duration(milliseconds: 300));
      var addRes = await DbHelper().add(DbTables.Suppliers, obj.toJson());// table name
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

  Future<SupplierModel?> getById(int Id)async{ /// model type
    try{
      await Future.delayed(Duration(milliseconds: 300));
      var res = await DbHelper().getById(DbTables.Suppliers, Id);/// table name
      SupplierModel? item ;/// model
      if(res != null){
        item = SupplierModel.fromJson(res);///
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
      var delRes = await DbHelper().delete(DbTables.Suppliers, id); // table name
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

  Future<bool> updateToDb(SupplierModel obj)async{
    try{
      await Future.delayed(Duration(milliseconds: 300));
      var delRes = await DbHelper().update(DbTables.Suppliers, obj.toJson());
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