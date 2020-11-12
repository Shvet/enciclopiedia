import 'dart:async';
import 'dart:developer' as log;

import 'package:bloc/bloc.dart';
import 'package:enciclopiedia_deportiva/models/models.dart';
import 'package:enciclopiedia_deportiva/repository/category_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository repository;

  CategoryBloc({@required this.repository})
      : assert(repository != null),
        super(CategoryInitial());

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    if (event is FetchCategory) {
      yield CategoryLoading();
      try {
        final List<CategoryEntity> entity = await repository.fetchCategory();
        yield CategoryLoaded(entity: entity);
      } catch (e) {
        log.log(e.toString());
        yield CategoryError();
      }
    } else {
      log.log("Fetching Category else");
    }
  }
}
