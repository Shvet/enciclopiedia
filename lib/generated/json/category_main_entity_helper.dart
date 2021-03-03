import 'package:enciclopiedia_deportiva/models/category_main_entity.dart';

categoryMainEntityFromJson(CategoryMainEntity data, Map<String, dynamic> json) {
  if (json['id'] != null) {
    data.id = json['id']?.toString();
  }
  if (json['title'] != null) {
    data.title = json['title']?.toString();
  }
  if (json['image'] != null) {
    data.image = json['image']?.toString();
  }
  if (json['sub'] != null) {
    data.sub = <CategoryMainSub>[];
    (json['sub'] as List).forEach((v) {
      data.sub.add(new CategoryMainSub().fromJson(v));
    });
  }
  return data;
}

Map<String, dynamic> categoryMainEntityToJson(CategoryMainEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = entity.id;
  data['title'] = entity.title;
  data['image'] = entity.image;
  if (entity.sub != null) {
    data['sub'] = entity.sub.map((v) => v.toJson()).toList();
  }
  return data;
}

categoryMainSubFromJson(CategoryMainSub data, Map<String, dynamic> json) {
  if (json['name'] != null) {
    data.name = json['name']?.toString();
  }
  if (json['id'] != null) {
    data.id = json['id']?.toString();
  }
  return data;
}

Map<String, dynamic> categoryMainSubToJson(CategoryMainSub entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['name'] = entity.name;
  data['id'] = entity.id;
  return data;
}
