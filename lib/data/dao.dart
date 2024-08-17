import 'package:e_comm_app/models/category.dart';
import 'package:sembast/sembast.dart';
import 'app_database.dart';

class CategoryDao {
  static const String folderName = "Category";
  final _categoryFolder = intMapStoreFactory.store(folderName);


  Future<Database> get  _db  async => await AppDatabase.instance.database;

  Future insertCategory(Category category) async{

    await  _categoryFolder.add(await _db, category.toJson() );
    print('category Inserted successfully !!');
  }

  Future<List<Category>> getAllCategory() async{
    final recordSnapshot = await _categoryFolder.find(await _db);
    return recordSnapshot.map((snapshot){
      final category = Category.fromJson(snapshot.value);
      return category;
    }).toList();
  }
}