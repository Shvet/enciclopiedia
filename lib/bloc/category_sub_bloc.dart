import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:enciclopiedia_deportiva/models/models.dart';
import 'package:enciclopiedia_deportiva/repository/category_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'category_sub_event.dart';
part 'category_sub_state.dart';

class CategorySubBloc extends Bloc<CategorySubEvent, CategorySubState> {
  final CategoryRepository repository;

  CategorySubBloc({@required this.repository})
      : assert(repository != null),
        super(CategorySubInitial());

  @override
  Stream<CategorySubState> mapEventToState(CategorySubEvent event) async* {
    if (event is FetchCategorySub) {
      yield CategorySubLoading();
      try {
        /*List<CategorySubEntity> temp = new List();
        for (CategorySubEntity sub in list) {
          String introtext = sub.introtext
              .replaceAll("<span style=\"font-size: 14pt;\">", "")
              .replaceAll("<\/span>", "");
          log(introtext);
          CategorySubEntity entity = new CategorySubEntity();
          entity.introtext = introtext;
          entity.title = sub.title;
          entity.metadesc = sub.metadesc;
          entity.state = sub.state;
          entity.fulltext = sub.fulltext;
          entity.id = sub.id;
          entity.access = sub.access;
          entity.xreference = sub.xreference;
          entity.urls = sub.urls;
          entity.readmore = sub.readmore;
          entity.ratingCount = sub.ratingCount;
          entity.modifiedByName = sub.modifiedByName;
          entity.layout = sub.layout;
          entity.language = sub.language;
          entity.state = sub.state;
          entity.metadesc = sub.metadesc;
          entity.images = sub.images;
          entity.featured = sub.featured;
          temp.add(entity);
        }*/
        yield CategorySubLoaded(list: await repository.fetchSubCategory(event.id));
      } catch (error) {
        log("Error $error");
        yield CategorySubError(error.toString());
      }
    }

    if (event is SearchCategorySub) {
      log("SearchCategorySub start");
      try {
        final List<CategorySubEntity> _tempList = [];

        for (int i = 0; i < event.list.length; i++) {
          CategorySubEntity data = event.list[i];
          if (data.introtext.toLowerCase().contains(event.search.toLowerCase())) {
            log("${data.introtext}");
            _tempList.add(data);
          }
        }
        yield CategorySubLoaded(list: _tempList);
      } catch (e) {
        yield CategorySubError(e.toString());
      }
    }
  }
}
