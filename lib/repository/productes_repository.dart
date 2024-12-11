import '../db_helper/db_productes_helper.dart'; // import library
import '../models/ProducteModel.dart';

class ProductesRepository{ //class name
  Future<List<ProducteModel>> getAllFromDb()async{ // model type

    try{
      await Future.delayed(Duration(milliseconds: 300));
      var res = await DbHelper().getAll(DbTables.Productes);//table name
      List<ProducteModel> items = [];// model
      if(res != null){
        for (var e in res) {
          items.add(ProducteModel.fromJson(e));// type of model
        }
        return items;
      }

      return items;
    }
    catch(ex){
      rethrow;
    }
  }

  Future<bool> addToDb(ProducteModel obj)async{ // model type
    try{
      await Future.delayed(Duration(milliseconds: 300));
      var addRes = await DbHelper().add(DbTables.Productes, obj.toJson());// table name
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
  Future<ProducteModel?> getById(int Id)async{ /// model type
    try{
      await Future.delayed(Duration(milliseconds: 300));
      var res = await DbHelper().getById(DbTables.Productes, Id);/// table name
      ProducteModel? item ;/// model
      if(res != null){
        item = ProducteModel.fromJson(res);///
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
      var delRes = await DbHelper().delete(DbTables.Productes, id); // table name
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

  Future<bool> updateToDb(ProducteModel obj)async{
    try{
      await Future.delayed(Duration(milliseconds: 300));
      var delRes = await DbHelper().update(DbTables.Productes, obj.toJson());
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