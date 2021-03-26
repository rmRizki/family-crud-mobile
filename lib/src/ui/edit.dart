import 'package:family/src/core/blocs/home/home_bloc.dart';
import 'package:family/src/core/models/family.dart';
import 'package:family/src/core/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditPage extends StatefulWidget {
  final Family family;

  EditPage({@required this.family});

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  HomeBloc _homeBloc;
  TextEditingController _nameController;
  TextEditingController _genderController;
  TextEditingController _parentIdController;

  @override
  void initState() {
    _homeBloc = HomeBloc(repository: FamilyRepository());
    _nameController = TextEditingController(text: widget.family.nama);
    _genderController = TextEditingController(text: widget.family.kelamin);
    _parentIdController =
        TextEditingController(text: '${widget.family.parentId}');
    super.initState();
  }

  @override
  void dispose() {
    _homeBloc.close();
    _nameController.dispose();
    _genderController.dispose();
    _parentIdController.dispose();
    super.dispose();
  }

  _onDeleted(id) {
    _homeBloc.add(HomeDeleted(id: id));
  }

  _onUpdated(id, nama, kelamin, parentId) {
    _homeBloc.add(
        HomeUpdated(id: id, nama: nama, kelamin: kelamin, parentId: parentId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: BlocProvider(
        create: (context) => _homeBloc,
        child: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is HomeMessage) {
              if (state.message == 'success') {
                Navigator.of(context).pop(state.message);
              }
            }
          },
          builder: (context, state) {
            if (state is HomeLoadInProgress) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is HomeLoadFailure) {
              return Center(child: Text('${state.err}'));
            }
            return _buildForm();
          },
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text('Family'),
      actions: [
        IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _onDeleted(widget.family.id))
      ],
    );
  }

  Widget _buildForm() {
    return ListView(
      children: [
        TextFormField(
          decoration: InputDecoration(hintText: 'Parent Id (ID Orang Tua)'),
          controller: _parentIdController,
        ),
        TextFormField(
          decoration: InputDecoration(hintText: 'Nama'),
          controller: _nameController,
        ),
        TextFormField(
          decoration: InputDecoration(hintText: 'Kelamin'),
          controller: _genderController,
        ),
        ElevatedButton(
            onPressed: () => _onUpdated(widget.family.id, _nameController.text,
                _genderController.text, int.parse(_parentIdController.text)),
            child: Text('Update'))
      ],
    );
  }
}
