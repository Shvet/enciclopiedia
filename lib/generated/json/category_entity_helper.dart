import 'package:enciclopiedia_deportiva/models/category_entity.dart';

categoryEntityFromJson(CategoryEntity data, Map<String, dynamic> json) {
  if (json['id'] != null) {
    data.id = json['id'].toString();
  }
  if (json['asset_id'] != null) {
    data.assetId = json['asset_id'].toString();
  }
  if (json['parent_id'] != null) {
    data.parentId = json['parent_id'].toString();
  }
  if (json['lft'] != null) {
    data.lft = json['lft'].toString();
  }
  if (json['rgt'] != null) {
    data.rgt = json['rgt'].toString();
  }
  if (json['level'] != null) {
    data.level = json['level'].toString();
  }
  if (json['path'] != null) {
    data.path = json['path'].toString();
  }
  if (json['extension'] != null) {
    data.extension = json['extension'].toString();
  }
  if (json['title'] != null) {
    data.title = json['title'].toString();
  }
  if (json['alias'] != null) {
    data.alias = json['alias'].toString();
  }
  if (json['note'] != null) {
    data.note = json['note'].toString();
  }
  if (json['description'] != null) {
    data.description = json['description'].toString();
  }
  if (json['published'] != null) {
    data.published = json['published'].toString();
  }
  if (json['checked_out'] != null) {
    data.checkedOut = json['checked_out'].toString();
  }
  if (json['checked_out_time'] != null) {
    data.checkedOutTime = json['checked_out_time'].toString();
  }
  if (json['access'] != null) {
    data.access = json['access'].toString();
  }
  if (json['params'] != null) {
    data.params = json['params'].toString();
  }
  if (json['metadesc'] != null) {
    data.metadesc = json['metadesc'].toString();
  }
  if (json['metakey'] != null) {
    data.metakey = json['metakey'].toString();
  }
  if (json['metadata'] != null) {
    data.metadata = json['metadata'].toString();
  }
  if (json['created_user_id'] != null) {
    data.createdUserId = json['created_user_id'].toString();
  }
  if (json['created_time'] != null) {
    data.createdTime = json['created_time'].toString();
  }
  if (json['modified_user_id'] != null) {
    data.modifiedUserId = json['modified_user_id'].toString();
  }
  if (json['modified_time'] != null) {
    data.modifiedTime = json['modified_time'].toString();
  }
  if (json['hits'] != null) {
    data.hits = json['hits'].toString();
  }
  if (json['language'] != null) {
    data.language = json['language'].toString();
  }
  if (json['version'] != null) {
    data.version = json['version'].toString();
  }
  return data;
}

Map<String, dynamic> categoryEntityToJson(CategoryEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = entity.id;
  data['asset_id'] = entity.assetId;
  data['parent_id'] = entity.parentId;
  data['lft'] = entity.lft;
  data['rgt'] = entity.rgt;
  data['level'] = entity.level;
  data['path'] = entity.path;
  data['extension'] = entity.extension;
  data['title'] = entity.title;
  data['alias'] = entity.alias;
  data['note'] = entity.note;
  data['description'] = entity.description;
  data['published'] = entity.published;
  data['checked_out'] = entity.checkedOut;
  data['checked_out_time'] = entity.checkedOutTime;
  data['access'] = entity.access;
  data['params'] = entity.params;
  data['metadesc'] = entity.metadesc;
  data['metakey'] = entity.metakey;
  data['metadata'] = entity.metadata;
  data['created_user_id'] = entity.createdUserId;
  data['created_time'] = entity.createdTime;
  data['modified_user_id'] = entity.modifiedUserId;
  data['modified_time'] = entity.modifiedTime;
  data['hits'] = entity.hits;
  data['language'] = entity.language;
  data['version'] = entity.version;
  return data;
}
