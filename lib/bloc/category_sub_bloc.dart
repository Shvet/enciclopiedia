import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:enciclopiedia_deportiva/models/models.dart';
import 'package:enciclopiedia_deportiva/repository/category_repository.dart';
import 'package:equatable/equatable.dart';

part 'category_sub_event.dart';
part 'category_sub_state.dart';

class CategorySubBloc extends Bloc<CategorySubEvent, CategorySubState> {
  final CategoryRepository repository;

  CategorySubBloc({required this.repository}) : super(CategorySubInitial());

  @override
  Stream<CategorySubState> mapEventToState(CategorySubEvent event) async* {
    if (event is FetchCategorySub) {
      yield CategorySubLoading();
      try {
        yield CategorySubLoaded(list: await repository.fetchSubCategory(event.id));
      } catch (error) {
        log("Error $error");
        yield CategorySubError(error.toString());
      }
    }

    if (event is SearchCategorySub) {
      try {
        final List<CategorySubEntity> _tempList = [];

        for (int i = 0; i < event.list.length; i++) {
          CategorySubEntity data = event.list[i];
          if (data.introtext!.toLowerCase().contains(event.search.toLowerCase())) {
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
