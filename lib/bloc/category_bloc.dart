import 'dart:async';
import 'dart:developer' as log;

import 'package:bloc/bloc.dart';
import 'package:enciclopiedia_deportiva/models/models.dart';
import 'package:enciclopiedia_deportiva/repository/category_repository.dart';
import 'package:equatable/equatable.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository repository;

  CategoryBloc({required this.repository}) : super(CategoryInitial());

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    if (event is FetchCategory) {
      yield CategoryLoading();
      try {
        yield CategoryLoaded(entity: await repository.fetchCategory());
      } catch (e) {
        log.log(e.toString());
        yield CategoryError(e.toString());
      }
    } else {
      log.log("Fetching Category else");
    }
  }
}
