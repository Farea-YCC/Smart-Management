import '../db_helper/db_expenses_helper.dart'; // import library
import '../models/ExpensesModel.dart';

class ExpensesRepository{ //class name
  Future<List<ExpensesModel>> getAllFromDb()async{ // model type

    try{
      await Future.delayed(Duration(milliseconds: 300));
      var res = await DbHelper().getAll(DbTables.Expenses);//table name
      List<ExpensesModel> items = [];// model
      if(res != null){
        for (var e in res) {
          items.add(ExpensesModel.fromJson(e));// type of model
        }
        return items;
      }

      return items;
    }
    catch(ex){
      rethrow;
    }
  }

  Future<bool> addToDb(ExpensesModel obj)async{ // model type
    try{
      await Future.delayed(Duration(milliseconds: 300));
      var addRes = await DbHelper().add(DbTables.Expenses, obj.toJson());// table name
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

  Future<ExpensesModel?> getById(int Id)async{ /// model type
    try{
      await Future.delayed(Duration(milliseconds: 300));
      var res = await DbHelper().getById(DbTables.Expenses, Id);/// table name
      ExpensesModel? item ;/// model
      if(res != null){
        item = ExpensesModel.fromJson(res);///
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
      var delRes = await DbHelper().delete(DbTables.Expenses, id); // table name
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

  Future<bool> updateToDb(ExpensesModel obj)async{
    try{
      await Future.delayed(Duration(milliseconds: 300));
      var delRes = await DbHelper().update(DbTables.Expenses, obj.toJson());
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