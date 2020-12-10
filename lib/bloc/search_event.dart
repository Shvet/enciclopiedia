part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class SearchData extends SearchEvent {
  final String keyWord;

  const SearchData({@required this.keyWord}) : assert(keyWord != null);

  @override
  List<Object> get props => [keyWord];
}
