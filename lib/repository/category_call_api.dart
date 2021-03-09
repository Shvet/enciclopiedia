import 'dart:async';
import 'dart:convert';

import 'package:enciclopiedia_deportiva/generated/json/category_entity_helper.dart';
import 'package:enciclopiedia_deportiva/generated/json/category_sub_entity_helper.dart';
import 'package:enciclopiedia_deportiva/generated/json/search_entity_helper.dart';
import 'package:enciclopiedia_deportiva/models/category_entity.dart';
import 'package:enciclopiedia_deportiva/models/category_sub_entity.dart';
import 'package:enciclopiedia_deportiva/models/models.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class CategoryApi {
  final _baseUrl = "https://www.enciclopediadeportiva.com/index.php?";
  final http.Client httpClient;

  CategoryApi({@required this.httpClient}) : assert(httpClient != null);

  Future<List<CategoryEntity>> fetchCategories() async {
    final url = '$_baseUrl' + "option=com_hoicoiapi&task=getContents&token=MobileAppData21222324252627282930";
    final result = await httpClient.get(url);
    if (result.statusCode != 200) {
      throw new Exception("error getting categories");
    }
    List<dynamic> jsonArray = jsonDecode(result.body);

    List<CategoryEntity> list =
        jsonArray.map((categoryEntity) => categoryEntityFromJson(new CategoryEntity(), categoryEntity)).toList();
    return list;
  }

  Future<List<CategorySubEntity>> getSubCategory(String id) async {
    final url = '$_baseUrl' +
        "option=com_hoicoiapi&task=getContents&token=Mo"
            "bileAppData21222324252627282930&catid=" +
        id;
    final result = await httpClient.get(url);
    if (result.statusCode != 200) {
      throw new Exception("error getting categories");
    }
    List<dynamic> jsonArray = jsonDecode(result.body);

    List<CategorySubEntity> list = List<CategorySubEntity>.from(jsonArray.map(
      (categorySub) => categorySubEntityFromJson(new CategorySubEntity(), categorySub),
    ));
    return list;
  }

  Future<SearchEntity> getSearchData(String keyword) async {
    // &keyword=ten&ordering=newest&limit=10&token=MobileAppData21222324252627282930
    final url = '$_baseUrl' +
        "option=com_hoicoiapi&task=getContents&task=getSearchResult"
            "&keyword=$keyword&ordering=newest&limit=10&token=MobileAppData21222324252627282930";
    final result = await httpClient.get(url);
    // log("result ${result.body}");

    SearchEntity entity = searchEntityFromJson(new SearchEntity(), jsonDecode(result.body));
    return entity;
  }
}
