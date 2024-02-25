part of 'categories_bloc.dart';

@freezed
class CategoriesEvent with _$CategoriesEvent {
  const factory CategoriesEvent.loadTodos() = LoadTodos;
  const factory CategoriesEvent.addTodo(CategoryModel categoryModel) = AddTodo;
  const factory CategoriesEvent.deleteTodo(int id) = DeleteTodoEvent;
    const factory CategoriesEvent.updateTodo(CategoryModel categoryModel) = UpdateTodoEvent;
}
