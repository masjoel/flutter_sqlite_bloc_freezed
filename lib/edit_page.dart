import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqlite_bloc/model/category_model.dart';

import 'blocs/categories/categories_bloc.dart';

class EditPage extends StatelessWidget {
  final CategoryModel data;

  const EditPage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _titleController = TextEditingController(text: data.title);
    final _descriptionController =
        TextEditingController(text: data.description);

    return BlocProvider(
      create: (context) => CategoriesBloc(),
      child: BlocListener<CategoriesBloc, CategoriesState>(
        listener: (context, state) {
          state.maybeWhen(
            success: () {},
            orElse: () {},
          );
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Edit Kategori'),
          ),
          body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Title tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Description tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        var data = CategoryModel(
                          id: this.data.id,
                          title: _titleController.text,
                          description: _descriptionController.text,
                        );
                        context
                            .read<CategoriesBloc>()
                            .add(UpdateTodoEvent(data));
                        print('data berhasil diupdate');
                        context.read<CategoriesBloc>().add(const LoadTodos());
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Update'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
