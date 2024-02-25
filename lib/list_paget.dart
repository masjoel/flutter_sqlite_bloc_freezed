import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqlite_bloc/blocs/categories/categories_bloc.dart';

import 'add_page.dart';
import 'edit_page.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  void initState() {
    super.initState();
    context.read<CategoriesBloc>().add(const CategoriesEvent.loadTodos());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('List Kategori'),
          elevation: 0,
          centerTitle: true,
        ),
        body: BlocBuilder<CategoriesBloc, CategoriesState>(
          builder: (context, state) {
            return state.maybeWhen(orElse: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }, loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }, loaded: (data) {
              // if (data.isEmpty) {
              //   return const Center(
              //     child: Text('Belum ada data'),
              //   );
              // }
              return Column(
                children: [
                  Flexible(
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 30.0),
                      itemCount: data.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10.0),
                      itemBuilder: (context, index) => ListTile(
                        // contentPadding: const EdgeInsets.all(10.0),
                        minVerticalPadding: 4.0,
                        title: Text(data[index].title),
                        subtitle: Text(data[index].description),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EditPage(data: data[index]),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Konfirmasi'),
                                    content: const Text(
                                        'Yakin ingin menghapus data ini?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Batal'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          context.read<CategoriesBloc>().add(
                                              DeleteTodoEvent(data[index].id!));
                                          context
                                              .read<CategoriesBloc>()
                                              .add(const LoadTodos());
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Ya'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddPage(),
                          ),
                        );
                      },
                      child: const Icon(Icons.add),
                    ),
                  ),
                ],
              );
            });
          },
        ));
  }
}
