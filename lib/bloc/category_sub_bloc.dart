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
  Stream<CategorySubState> mapEventToState(
    CategorySubEvent event,
  ) async* {
    if (event is FetchCategorySub) {
      yield CategorySubLoading();
      try {
        final List<CategorySubEntity> list =
            await repository.fetchSubCategory(event.id);
        yield CategorySubLoaded(list: list);
      } catch (error) {
        log("Error $error");
        yield CategorySubError();
      }
    }

    if (event is SearchCategorySub) {
      log("SearchCategorySub start");
      try {
        final List<CategorySubEntity> _tempList = new List();

        for (int i = 0; i < event.list.length; i++) {
          CategorySubEntity data = event.list[i];
          if (data.introtext
              .toLowerCase()
              .contains(event.search.toLowerCase())) {
            log("${data.introtext}");
            _tempList.add(data);
          }
        }
        yield CategorySubLoaded(list: _tempList);
      } catch (e) {
        yield CategorySubError();
      }
    }
  }
}
