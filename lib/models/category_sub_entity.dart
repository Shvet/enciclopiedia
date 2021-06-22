import 'package:enciclopiedia_deportiva/generated/json/base/json_convert_content.dart';
import 'package:enciclopiedia_deportiva/generated/json/base/json_field.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class CategorySubEntity extends Equatable with JsonConvert<CategorySubEntity> {
  String? id;
  String? title;
  String? alias;
  String? introtext;
  String? fulltext;
  @JSONField(name: "checked_out")
  String? checkedOut;
  @JSONField(name: "checked_out_time")
  String? checkedOutTime;
  String? catid;
  String? created;
  @JSONField(name: "created_by")
  String? createdBy;
  @JSONField(name: "created_by_alias")
  String? createdByAlias;
  String? modified;
  @JSONField(name: "modified_by")
  String? modifiedBy;
  @JSONField(name: "modified_by_name")
  String? modifiedByName;
  @JSONField(name: "publish_up")
  String? publishUp;
  @JSONField(name: "publish_down")
  String? publishDown;
  String? images;
  String? urls;
  String? attribs;
  String? metadata;
  String? metakey;
  String? metadesc;
  String? access;
  String? hits;
  String? xreference;
  String? featured;
  String? language;
  String? readmore;
  String? state;
  @JSONField(name: "category_title")
  String? categoryTitle;
  @JSONField(name: "category_route")
  String? categoryRoute;
  @JSONField(name: "category_access")
  String? categoryAccess;
  @JSONField(name: "category_alias")
  String? categoryAlias;
  String? author;
  @JSONField(name: "author_email")
  String? authorEmail;
  @JSONField(name: "parent_title")
  String? parentTitle;
  @JSONField(name: "parent_id")
  String? parentId;
  @JSONField(name: "parent_route")
  String? parentRoute;
  @JSONField(name: "parent_alias")
  String? parentAlias;
  dynamic rating;
  @JSONField(name: "rating_count")
  dynamic ratingCount;
  String? published;
  @JSONField(name: "parents_published")
  String? parentsPublished;
  @JSONField(name: "alternative_readmore")
  dynamic alternativeReadmore;
  dynamic layout;
  CategorySubParams? params;
  String? displayDate;

  @override
  List<Object> get props => [
        id!,
        parentId!,
        params!,
        parentAlias!,
        parentRoute!,
        parentsPublished!,
        parentTitle!,
        publishDown!,
        published!,
        publishUp!,
        hits!,
        metakey!,
        metadesc!,
        metadata!,
        checkedOutTime!,
        checkedOut!,
        categoryAccess!,
        categoryAlias!,
        categoryRoute!,
        categoryTitle!,
        catid!,
        created!,
        createdBy!,
        createdByAlias!,
        alias!,
        access!,
        title!,
        alternativeReadmore,
        attribs!,
        author!,
        authorEmail!,
        displayDate!,
        featured!,
        fulltext!,
        images!,
        introtext!,
        language!,
        layout,
        modified!,
        modifiedBy!,
        modifiedByName!,
        rating,
        ratingCount,
        readmore!,
        state!,
        urls!,
        xreference!
      ];

  @override
  String toString() {
    return id!;
  }
}

// ignore: must_be_immutable
class CategorySubParams extends Equatable with JsonConvert<CategorySubParams> {
  String? token;
  @JSONField(name: "page_title")
  String? pageTitle;
  @JSONField(name: "page_description")
  String? pageDescription;
  @JSONField(name: "page_rights")
  dynamic pageRights;
  dynamic robots;
  @JSONField(name: "access-view")
  bool? access;

  @override
  List<Object> get props => [token!, pageDescription!, pageRights, pageTitle!, robots, access!];

  @override
  String toString() {
    return token!;
  }
}
