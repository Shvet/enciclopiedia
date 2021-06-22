import 'package:enciclopiedia_deportiva/generated/json/base/json_convert_content.dart';

class CategoryMainEntity with JsonConvert<CategoryMainEntity> {
  String? id;
  String? title;
  String? image;
  List<CategoryMainSub>? sub;
}

class CategoryMainSub with JsonConvert<CategoryMainSub> {
  String? name;
  String? id;
}
