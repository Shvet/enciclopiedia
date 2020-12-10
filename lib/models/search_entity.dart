import 'package:enciclopiedia_deportiva/generated/json/base/json_convert_content.dart';

class SearchEntity with JsonConvert<SearchEntity> {
  List<SearchData> data;
  SearchPagination pagination;
}

class SearchData with JsonConvert<SearchData> {
  String title;
  String text;
  String created;
  String browsernav;
  String catid;
  String slug;
  String href;
  String section;
  String metadesc;
  String metakey;
  String language;
  String catslug;
}

class SearchPagination with JsonConvert<SearchPagination> {
  int limitstart;
  int limit;
  int total;
  int pagesStart;
  int pagesStop;
  int pagesCurrent;
  int pagesTotal;
}
