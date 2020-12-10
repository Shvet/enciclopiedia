import 'package:enciclopiedia_deportiva/models/category_entity.dart';
import 'package:enciclopiedia_deportiva/models/category_sub_entity.dart';
import 'package:enciclopiedia_deportiva/models/search_entity.dart';
import 'package:enciclopiedia_deportiva/repository/category_call_api.dart';
import 'package:flutter/widgets.dart';

class CategoryRepository {
  final CategoryApi categoryApi;

  CategoryRepository({@required this.categoryApi})
      : assert(categoryApi != null);

  Future<List<CategoryEntity>> fetchCategory() async {
    return await categoryApi.fetchCategories();
  }

  Future<List<CategorySubEntity>> fetchSubCategory(String id) async {
    return await categoryApi.getSubCategory(id);
  }

  Future<SearchEntity> searchData(String keyWord) async {
    return await categoryApi.getSearchData(keyWord);
  }
}
