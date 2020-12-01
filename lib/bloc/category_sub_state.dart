part of 'category_sub_bloc.dart';

abstract class CategorySubState extends Equatable {
  const CategorySubState();

  @override
  List<Object> get props => [];
}

class CategorySubInitial extends CategorySubState {}

class CategorySubLoading extends CategorySubState {}

class CategorySubLoaded extends CategorySubState {
  final List<CategorySubEntity> list;

  const CategorySubLoaded({@required this.list}) : assert(list != null);

  @override
  List<Object> get props => [list];
}

class CategorySubError extends CategorySubState {}
