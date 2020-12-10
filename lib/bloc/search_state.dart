part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final SearchEntity list;

  const SearchLoaded({@required this.list}) : assert(list != null);

  @override
  List<Object> get props => [list];
}

class SearchError extends SearchState {}
