import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:enciclopiedia_deportiva/models/models.dart';
import 'package:enciclopiedia_deportiva/repository/category_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final CategoryRepository repository;

  SearchBloc({@required this.repository})
      : assert(repository != null),
        super(SearchInitial());

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is SearchData) {
      yield SearchLoading();
      try {
        yield SearchLoaded(list: await repository.searchData(event.keyWord));
      } catch (error) {
        yield SearchError(error.toString());
      }
    }
  }
}
