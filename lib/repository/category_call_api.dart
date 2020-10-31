import 'dart:convert';

import 'package:enciclopiedia_deportiva/generated/json/category_entity_helper.dart';
import 'package:enciclopiedia_deportiva/models/category_entity.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class CategoryApi {
  final _baseUrl = "http://www.enciclopediadeportiva.com/index.php?";
  final http.Client httpClient;

  CategoryApi({@required this.httpClient}) : assert(httpClient != null);

  Future<List<CategoryEntity>> fetchCategories() async {
    final url = '$_baseUrl' +
        "option=com_hoicoiapi&task=getContents&token=MobileAppData21222324252627282930";
    final result = await httpClient.get(url);
    if (result.statusCode != 200) {
      throw new Exception("error getting categories");
    }
    List<dynamic> jsonArray = jsonDecode(result.body);

    List<CategoryEntity> list = jsonArray
        .map((categoryEntity) =>
            categoryEntityFromJson(new CategoryEntity(), categoryEntity))
        .toList();
    return list;
  }
}
