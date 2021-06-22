part of 'category_sub_bloc.dart';

abstract class CategorySubEvent extends Equatable {
  const CategorySubEvent();
}

class FetchCategorySub extends CategorySubEvent {
  final String id;

  const FetchCategorySub({required this.id});

  @override
  List<Object> get props => [id];
}

class SearchCategorySub extends CategorySubEvent {
  final String search;
  final List<CategorySubEntity> list;

  const SearchCategorySub({required this.search, required this.list});

  @override
  List<Object> get props => [search, list];
}
