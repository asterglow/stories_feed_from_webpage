import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_readonlinejson/online_data.dart';
import 'package:provider_readonlinejson/widgets/stories_card.dart';


class StoriesPage extends StatelessWidget {
  const StoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<OnlineData>().fetchData;

    return Scaffold(
      appBar: AppBar(
        title: const Text('NDTV Top Stories'),
        actions: [
          IconButton(
              onPressed: () {
                context.read<OnlineData>().initialValues();
                // sleep(Duration(seconds: 5));
                context.read<OnlineData>().fetchData;
              },
              icon: const Icon(
                Icons.refresh,
              )),
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
                  ? const CircularProgressIndicator()
                  : value.error
                      ? Text(
                          'Oops, something went wrong. \n ${value.errorMessage}',
                          textAlign: TextAlign.center,
                        )
                      : ListView.builder(
                          itemCount: value.map['rss']['channel']['item'].length,
                          itemBuilder: (context, index) {
                            // return Text('hi');
                            return StoriesCard(
                                map: value.map['rss']['channel']['item'][index]);
                          },
                        );
            },
          ),
        ),
      ),
    );
  }
}


