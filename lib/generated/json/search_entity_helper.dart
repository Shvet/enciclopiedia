import 'package:enciclopiedia_deportiva/models/search_entity.dart';

searchEntityFromJson(SearchEntity data, Map<String, dynamic> json) {
  if (json['data'] != null) {
    data.data = (json['data'] as List).map((v) => SearchData().fromJson(v)).toList();
  }
  if (json['pagination'] != null) {
    data.pagination = SearchPagination().fromJson(json['pagination']);
  }
  return data;
}

Map<String, dynamic> searchEntityToJson(SearchEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  data['pagination'] = entity.pagination?.toJson();
  return data;
}

searchDataFromJson(SearchData data, Map<String, dynamic> json) {
  if (json['title'] != null) {
    data.title = json['title'].toString();
  }
  if (json['text'] != null) {
    data.text = json['text'].toString();
  }
  if (json['created'] != null) {
    data.created = json['created'].toString();
  }
  if (json['browsernav'] != null) {
    data.browsernav = json['browsernav'].toString();
  }
  if (json['catid'] != null) {
    data.catid = json['catid'].toString();
  }
  if (json['slug'] != null) {
    data.slug = json['slug'].toString();
  }
  if (json['href'] != null) {
    data.href = json['href'].toString();
  }
  if (json['section'] != null) {
    data.section = json['section'].toString();
  }
  if (json['metadesc'] != null) {
    data.metadesc = json['metadesc'].toString();
  }
  if (json['metakey'] != null) {
    data.metakey = json['metakey'].toString();
  }
  if (json['language'] != null) {
    data.language = json['language'].toString();
  }
  if (json['catslug'] != null) {
    data.catslug = json['catslug'].toString();
  }
  return data;
}

Map<String, dynamic> searchDataToJson(SearchData entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['title'] = entity.title;
  data['text'] = entity.text;
  data['created'] = entity.created;
  data['browsernav'] = entity.browsernav;
  data['catid'] = entity.catid;
  data['slug'] = entity.slug;
  data['href'] = entity.href;
  data['section'] = entity.section;
  data['metadesc'] = entity.metadesc;
  data['metakey'] = entity.metakey;
  data['language'] = entity.language;
  data['catslug'] = entity.catslug;
  return data;
}

searchPaginationFromJson(SearchPagination data, Map<String, dynamic> json) {
  if (json['limitstart'] != null) {
    data.limitstart = json['limitstart'] is String ? int.tryParse(json['limitstart']) : json['limitstart'].toInt();
  }
  if (json['limit'] != null) {
    data.limit = json['limit'] is String ? int.tryParse(json['limit']) : json['limit'].toInt();
  }
  if (json['total'] != null) {
    data.total = json['total'] is String ? int.tryParse(json['total']) : json['total'].toInt();
  }
  if (json['pagesStart'] != null) {
    data.pagesStart = json['pagesStart'] is String ? int.tryParse(json['pagesStart']) : json['pagesStart'].toInt();
  }
  if (json['pagesStop'] != null) {
    data.pagesStop = json['pagesStop'] is String ? int.tryParse(json['pagesStop']) : json['pagesStop'].toInt();
  }
  if (json['pagesCurrent'] != null) {
    data.pagesCurrent =
        json['pagesCurrent'] is String ? int.tryParse(json['pagesCurrent']) : json['pagesCurrent'].toInt();
  }
  if (json['pagesTotal'] != null) {
    data.pagesTotal = json['pagesTotal'] is String ? int.tryParse(json['pagesTotal']) : json['pagesTotal'].toInt();
  }
  return data;
}

Map<String, dynamic> searchPaginationToJson(SearchPagination entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['limitstart'] = entity.limitstart;
  data['limit'] = entity.limit;
  data['total'] = entity.total;
  data['pagesStart'] = entity.pagesStart;
  data['pagesStop'] = entity.pagesStop;
  data['pagesCurrent'] = entity.pagesCurrent;
  data['pagesTotal'] = entity.pagesTotal;
  return data;
}
