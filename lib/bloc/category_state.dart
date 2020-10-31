part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<CategoryEntity> entity;

  const CategoryLoaded({@required this.entity}) : assert(entity != null);

  @override
  List<Object> get props => [entity];
}

class CategoryError extends CategoryState {}
