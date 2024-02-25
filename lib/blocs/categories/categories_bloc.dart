import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../db/database_helper.dart';
import '../../model/category_model.dart';

part 'categories_event.dart';
part 'categories_state.dart';
part 'categories_bloc.freezed.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(const CategoriesState.initial()) {
    on<LoadTodos>(_loadTodos);
    on<AddTodo>(_addTodo);
    on<DeleteTodoEvent>(_deleteTodo);
    on<UpdateTodoEvent>(_updateTodo);
  }

  void _loadTodos(LoadTodos event, Emitter<CategoriesState> emit) async {
    emit(const CategoriesState.loading());
    final categories = await DatabaseHelper.instance.getTodos();
    emit(CategoriesState.loaded(categories));
  }

  void _addTodo(AddTodo event, Emitter<CategoriesState> emit) async {
    await DatabaseHelper.instance.insertTodo(event.categoryModel);
    emit(const CategoriesState.success());
  }

  void _updateTodo(UpdateTodoEvent event, Emitter<CategoriesState> emit) async {
    await DatabaseHelper.instance.updateTodo(event.categoryModel);
    emit(const CategoriesState.success());
  }

  void _deleteTodo(DeleteTodoEvent event, Emitter<CategoriesState> emit) async {
    await DatabaseHelper.instance.deleteTodo(event.id);
    emit(const CategoriesState.success());
  }
}
