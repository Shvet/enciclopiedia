import 'package:enciclopiedia_deportiva/generated/json/base/json_convert_content.dart';
import 'package:enciclopiedia_deportiva/generated/json/base/json_field.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class CategoryEntity extends Equatable with JsonConvert<CategoryEntity> {
  String id;
  @JSONField(name: "asset_id")
  String assetId;
  @JSONField(name: "parent_id")
  String parentId;
  String lft;
  String rgt;
  String level;
  String path;
  String extension;
  String title;
  String alias;
  String note;
  String description;
  String published;
  @JSONField(name: "checked_out")
  String checkedOut;
  @JSONField(name: "checked_out_time")
  String checkedOutTime;
  String access;
  String params;
  String metadesc;
  String metakey;
  String metadata;
  @JSONField(name: "created_user_id")
  String createdUserId;
  @JSONField(name: "created_time")
  String createdTime;
  @JSONField(name: "modified_user_id")
  String modifiedUserId;
  @JSONField(name: "modified_time")
  String modifiedTime;
  String hits;
  String language;
  String version;

  @override
  List<Object> get props => [id, title];

  @override
  String toString() {
    return id;
  }
}
