import 'package:family/src/core/blocs/home/home_bloc.dart';
import 'package:family/src/core/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  HomeBloc _homeBloc;
  TextEditingController _nameController;
  TextEditingController _genderController;
  TextEditingController _parentIdController;

  @override
  void initState() {
    _homeBloc = HomeBloc(repository: FamilyRepository());
    _nameController = TextEditingController();
    _genderController = TextEditingController();
    _parentIdController = TextEditingController();
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

  _onCreated(nama, kelamin, parentId) {
    _homeBloc
        .add(HomeCreated(nama: nama, kelamin: kelamin, parentId: parentId));
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
      actions: [],
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
            onPressed: () => _onCreated(_nameController.text,
                _genderController.text, int.parse(_parentIdController.text)),
            child: Text('Tambah'))
      ],
    );
  }
}
