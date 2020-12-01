part of 'category_sub_bloc.dart';

abstract class CategorySubEvent extends Equatable {
  const CategorySubEvent();
}

class FetchCategorySub extends CategorySubEvent {
  final String id;

  const FetchCategorySub({@required this.id}) : assert(id != null);

  @override
  List<Object> get props => [id];
}

class SearchCategorySub extends CategorySubEvent {
  final String search;
  final List<CategorySubEntity> list;

  const SearchCategorySub({@required this.search, @required this.list})
      : assert(search != null && list != null);

  @override
  List<Object> get props => [search, list];
}
