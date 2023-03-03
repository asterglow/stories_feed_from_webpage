// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_readonlinejson/online_data.dart';

class StoriesPage extends StatelessWidget {
  const StoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<OnlineData>().fetchData;

    return Scaffold(
      appBar: AppBar(
        title: Text('Top Stories'),
        actions: [
          IconButton(onPressed:() {
            context.read<OnlineData>().initialValues();
            context.read<OnlineData>().fetchData;
          }, icon: Icon(Icons.refresh,)),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
         await context.read<OnlineData>().fetchData;
        },
        child: Center(
          child: Consumer<OnlineData>(
            builder: (context, value, child) {
              return value.map.isEmpty && !value.error
                  ? CircularProgressIndicator()
                  : value.error
                      ? Text(
                          'Oops, something went wrong. \n ${value.errorMessage}',
                          textAlign: TextAlign.center,
                        )
                      : ListView.builder(
                        itemCount: value.map['stories'].length,
                          itemBuilder: (context, index) {
                            return StoriesCard(map: value.map['stories'][index]);
                          },
                        );
            },
          ),
        ),
      ),
    );
  }
}
