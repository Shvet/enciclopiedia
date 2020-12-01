import 'package:enciclopiedia_deportiva/models/category_sub_entity.dart';

categorySubEntityFromJson(CategorySubEntity data, Map<String, dynamic> json) {
  if (json['id'] != null) {
    data.id = json['id']?.toString();
  }
  if (json['title'] != null) {
    data.title = json['title']?.toString();
  }
  if (json['alias'] != null) {
    data.alias = json['alias']?.toString();
  }
  if (json['introtext'] != null) {
    data.introtext = json['introtext']?.toString();
  }
  if (json['fulltext'] != null) {
    data.fulltext = json['fulltext']?.toString();
  }
  if (json['checked_out'] != null) {
    data.checkedOut = json['checked_out']?.toString();
  }
  if (json['checked_out_time'] != null) {
    data.checkedOutTime = json['checked_out_time']?.toString();
  }
  if (json['catid'] != null) {
    data.catid = json['catid']?.toString();
  }
  if (json['created'] != null) {
    data.created = json['created']?.toString();
  }
  if (json['created_by'] != null) {
    data.createdBy = json['created_by']?.toString();
  }
  if (json['created_by_alias'] != null) {
    data.createdByAlias = json['created_by_alias']?.toString();
  }
  if (json['modified'] != null) {
    data.modified = json['modified']?.toString();
  }
  if (json['modified_by'] != null) {
    data.modifiedBy = json['modified_by']?.toString();
  }
  if (json['modified_by_name'] != null) {
    data.modifiedByName = json['modified_by_name']?.toString();
  }
  if (json['publish_up'] != null) {
    data.publishUp = json['publish_up']?.toString();
  }
  if (json['publish_down'] != null) {
    data.publishDown = json['publish_down']?.toString();
  }
  if (json['images'] != null) {
    data.images = json['images']?.toString();
  }
  if (json['urls'] != null) {
    data.urls = json['urls']?.toString();
  }
  if (json['attribs'] != null) {
    data.attribs = json['attribs']?.toString();
  }
  if (json['metadata'] != null) {
    data.metadata = json['metadata']?.toString();
  }
  if (json['metakey'] != null) {
    data.metakey = json['metakey']?.toString();
  }
  if (json['metadesc'] != null) {
    data.metadesc = json['metadesc']?.toString();
  }
  if (json['access-view'] != null) {
    data.access = json['access-view']?.toString();
  }
  if (json['hits'] != null) {
    data.hits = json['hits']?.toString();
  }
  if (json['xreference'] != null) {
    data.xreference = json['xreference']?.toString();
  }
  if (json['featured'] != null) {
    data.featured = json['featured']?.toString();
  }
  if (json['language'] != null) {
    data.language = json['language']?.toString();
  }
  if (json['readmore'] != null) {
    data.readmore = json['readmore']?.toString();
  }
  if (json['state'] != null) {
    data.state = json['state']?.toString();
  }
  if (json['category_title'] != null) {
    data.categoryTitle = json['category_title']?.toString();
  }
  if (json['category_route'] != null) {
    data.categoryRoute = json['category_route']?.toString();
  }
  if (json['category_access'] != null) {
    data.categoryAccess = json['category_access']?.toString();
  }
  if (json['category_alias'] != null) {
    data.categoryAlias = json['category_alias']?.toString();
  }
  if (json['author'] != null) {
    data.author = json['author']?.toString();
  }
  if (json['author_email'] != null) {
    data.authorEmail = json['author_email']?.toString();
  }
  if (json['parent_title'] != null) {
    data.parentTitle = json['parent_title']?.toString();
  }
  if (json['parent_id'] != null) {
    data.parentId = json['parent_id']?.toString();
  }
  if (json['parent_route'] != null) {
    data.parentRoute = json['parent_route']?.toString();
  }
  if (json['parent_alias'] != null) {
    data.parentAlias = json['parent_alias']?.toString();
  }
  if (json['rating'] != null) {
    data.rating = json['rating'];
  }
  if (json['rating_count'] != null) {
    data.ratingCount = json['rating_count'];
  }
  if (json['published'] != null) {
    data.published = json['published']?.toString();
  }
  if (json['parents_published'] != null) {
    data.parentsPublished = json['parents_published']?.toString();
  }
  if (json['alternative_readmore'] != null) {
    data.alternativeReadmore = json['alternative_readmore'];
  }
  if (json['layout'] != null) {
    data.layout = json['layout'];
  }
  if (json['params'] != null) {
    data.params = new CategorySubParams().fromJson(json['params']);
  }
  if (json['displayDate'] != null) {
    data.displayDate = json['displayDate']?.toString();
  }
  return data;
}

Map<String, dynamic> categorySubEntityToJson(CategorySubEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = entity.id;
  data['title'] = entity.title;
  data['alias'] = entity.alias;
  data['introtext'] = entity.introtext;
  data['fulltext'] = entity.fulltext;
  data['checked_out'] = entity.checkedOut;
  data['checked_out_time'] = entity.checkedOutTime;
  data['catid'] = entity.catid;
  data['created'] = entity.created;
  data['created_by'] = entity.createdBy;
  data['created_by_alias'] = entity.createdByAlias;
  data['modified'] = entity.modified;
  data['modified_by'] = entity.modifiedBy;
  data['modified_by_name'] = entity.modifiedByName;
  data['publish_up'] = entity.publishUp;
  data['publish_down'] = entity.publishDown;
  data['images'] = entity.images;
  data['urls'] = entity.urls;
  data['attribs'] = entity.attribs;
  data['metadata'] = entity.metadata;
  data['metakey'] = entity.metakey;
  data['metadesc'] = entity.metadesc;
  data['access'] = entity.access;
  data['hits'] = entity.hits;
  data['xreference'] = entity.xreference;
  data['featured'] = entity.featured;
  data['language'] = entity.language;
  data['readmore'] = entity.readmore;
  data['state'] = entity.state;
  data['category_title'] = entity.categoryTitle;
  data['category_route'] = entity.categoryRoute;
  data['category_access'] = entity.categoryAccess;
  data['category_alias'] = entity.categoryAlias;
  data['author'] = entity.author;
  data['author_email'] = entity.authorEmail;
  data['parent_title'] = entity.parentTitle;
  data['parent_id'] = entity.parentId;
  data['parent_route'] = entity.parentRoute;
  data['parent_alias'] = entity.parentAlias;
  data['rating'] = entity.rating;
  data['rating_count'] = entity.ratingCount;
  data['published'] = entity.published;
  data['parents_published'] = entity.parentsPublished;
  data['alternative_readmore'] = entity.alternativeReadmore;
  data['layout'] = entity.layout;
  if (entity.params != null) {
    data['params'] = entity.params.toJson();
  }
  data['displayDate'] = entity.displayDate;
  return data;
}

categorySubParamsFromJson(CategorySubParams data, Map<String, dynamic> json) {
  if (json['token'] != null) {
    data.token = json['token']?.toString();
  }
  if (json['page_title'] != null) {
    data.pageTitle = json['page_title']?.toString();
  }
  if (json['page_description'] != null) {
    data.pageDescription = json['page_description']?.toString();
  }
  if (json['page_rights'] != null) {
    data.pageRights = json['page_rights'];
  }
  if (json['robots'] != null) {
    data.robots = json['robots'];
  }
  if (json['access'] != null) {
    data.access = json['access-view'];
  }
  return data;
}

Map<String, dynamic> categorySubParamsToJson(CategorySubParams entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['token'] = entity.token;
  data['page_title'] = entity.pageTitle;
  data['page_description'] = entity.pageDescription;
  data['page_rights'] = entity.pageRights;
  data['robots'] = entity.robots;
  data['access'] = entity.access;
  return data;
}
