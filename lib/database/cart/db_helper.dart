
import 'package:healthy_food/food.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static const DATABASE_NAME = 'food.db';
  static const DATABASE_VERSION = 1;
  static const TABLE_NAME = 'tb_name';
  static const COLUMN_ID = 'id';
  static const COLUMN_NAME = 'name';
  static const COLUMN_DESC = 'description';
  static const COLUMN_PRICE = 'price';
  static const COLUMN_IMAGE = 'image';
  static const COLUMN_STAR = 'star';
  static const COLUMN_JUMLAH = 'jumlah';

  DbHelper._();
  static final DbHelper myDB = DbHelper._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  Future<Database> createDatabase() async {
    String databasesPath = await getDatabasesPath();
    return await openDatabase(
      join(
        databasesPath,
        DATABASE_NAME,
      ),
      version: DATABASE_VERSION,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE $TABLE_NAME (
          $COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT,
          $COLUMN_NAME TEXT,
          $COLUMN_DESC TEXT,
          $COLUMN_PRICE INTEGER,
          $COLUMN_STAR DOUBLE,
          $COLUMN_JUMLAH INTEGER,
          $COLUMN_IMAGE TEXT
        )
        ''');
        // await db.execute('''
        //           CREATE TABLE penjualan (
        //             id INTEGER PRIMARY KEY AUTOINCREMENT,
        //             name TEXT,
        //             desc TEXT,
        //             jumlah TEXT,
        //             tanggal TEXT
        //           )
        //         ''');
      },
    );
  }

  Future<List<Food>> getAllFood() async {
    final db = await database;
    var foods = await db.query(TABLE_NAME, columns: [
      COLUMN_ID,
      COLUMN_NAME,
      COLUMN_DESC,
      COLUMN_PRICE,
      COLUMN_IMAGE,
      COLUMN_STAR,
      COLUMN_JUMLAH,
    ]);
    List<Food> listFood = List<Food>();
    foods.forEach(
      (element) {
        listFood.add(Food.fromMap(element));
      },
    );
    return listFood;
  }

  Future<int> insertFood(Food food) async {
    final db = await database;
    var foods = await db.query(
      TABLE_NAME,
      columns: [
        COLUMN_ID,
        COLUMN_NAME,
        COLUMN_DESC,
        COLUMN_PRICE,
        COLUMN_IMAGE,
        COLUMN_STAR,
        COLUMN_JUMLAH,
      ],
      where: '$COLUMN_NAME=?',
      whereArgs: [food.name],
    );
    if (foods.length > 0) {
      // print('jumlah=${food[0][COLUMN_JUMLAH] + food.jumlah}');
      Food newfood = Food(
        id: foods[0][COLUMN_ID],
        name: food.name,
        desc: food.desc,
        price: food.price,
        star: food.star,
        image: food.image,
        jumlah: foods[0][COLUMN_JUMLAH] + food.jumlah,
      );
      return await db.update(TABLE_NAME, newfood.toMap(),
          where: '$COLUMN_ID=?', whereArgs: [newfood.id]);
    } else {
      return await db.insert(TABLE_NAME, food.toMap());
    }
  }

  Future<int> deleteWhereId(int id) async {
    final db = await database;
    return await db.delete(
      TABLE_NAME,
      where: '$COLUMN_ID=?',
      whereArgs: [id],
    );
  }

  Future<int> updateWhereId(Food food) async {
    final db = await database;
    return await db.update(
      TABLE_NAME,
      food.toMap(),
      where: '$COLUMN_ID=?',
      whereArgs: [food.id],
    );
  }

  // Future<List<Map<String, dynamic>>> select() async {
  //   Database db = await this.database;
  //   var mapList = await db.query('penjualan', orderBy: 'tanggal');
  //   return mapList;
  // }

  // Future<int> insert(Penjualan object) async {
  //   Database db = await this.database;
  //   int count = await db.insert('penjualan', object.toMap());
  //   return count;
  // }

  // Future<int> update(Penjualan object) async {
  //   Database db = await this.database;
  //   int count = await db.update('penjualan', object.toMap(),
  //       where: 'id=?', whereArgs: [object.id]);
  //   return count;
  // }

  // Future<int> delete(int id) async {
  //   Database db = await this.database;
  //   int count = await db.delete('penjualan', where: 'id=?', whereArgs: [id]);
  //   return count;
  // }

  // Future<List<Penjualan>> getPenjualanList() async {
  //   var penjualanMapList = await select();
  //   int count = penjualanMapList.length;
  //   print("Ini Jumlah $count");
  //   List<Penjualan> penjualanList = List<Penjualan>();
  //   for (int i = 0; i < count; i++) {
  //     penjualanList.add(Penjualan.fromMap(penjualanMapList[i]));
  //   }
  //   return penjualanList;
  // }
}
