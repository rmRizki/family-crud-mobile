import 'package:family/src/core/blocs/home/home_bloc.dart';
import 'package:family/src/core/models/family.dart';
import 'package:family/src/core/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc _homeBloc;

  @override
  void initState() {
    _homeBloc = HomeBloc(repository: FamilyRepository());
    super.initState();
  }

  @override
  void dispose() {
    _homeBloc.close();
    super.dispose();
  }

  _onListRequest() {
    _homeBloc.add(HomeRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final message = await Navigator.of(context).pushNamed('/form');
          if (message != null) {
            _onListRequest();
          }
        },
        child: Icon(Icons.add),
      ),
      appBar: _buildAppBar(),
      body: BlocProvider(
        create: (context) => _homeBloc,
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeInitial) {
              _onListRequest();
            }
            if (state is HomeLoadInProgress) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is HomeLoadFailure) {
              return Center(child: Text('${state.err}'));
            }
            if (state is HomeLoadSuccess) {
              final familyList = state.families;
              return _buildList(familyList);
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text('Family'),
      actions: [
        IconButton(icon: Icon(Icons.refresh), onPressed: () => _onListRequest())
      ],
    );
  }

  Widget _buildList(familyList) {
    return ListView.builder(
      itemCount: familyList.length,
      itemBuilder: (context, index) {
        return _buildItem(context, familyList[index]);
      },
    );
  }

  Widget _buildItem(BuildContext context, Family family) {
    return ListTile(
      leading: Text('ID: ${family.id}'),
      trailing: Text('Parent ID: ${family.parentId}'),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      title: Text("${family.nama}"),
      subtitle: Text("${family.kelamin}"),
      onTap: () async {
        final message =
            await Navigator.of(context).pushNamed('/edit', arguments: family);
        if (message != null) {
          _onListRequest();
        }
      },
    );
  }
}
