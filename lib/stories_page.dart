// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_readonlinejson/online_data.dart';
import 'package:provider_readonlinejson/widgets/stories_card.dart';
import 'package:intl/intl.dart';

class StoriesPage extends StatelessWidget {
  StoriesPage({super.key});
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    context.read<OnlineData>().fetchData;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('NDTV Top Stories'),
            SizedBox(
              height: 3,
            ),
            Text(
              DateFormat('yyyy-MM-dd hh:mm:ss').format(now),
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
            ),
          ],
        ),
        leading: Icon(Icons.rss_feed_sharp),
        actions: [
          IconButton(
              onPressed: () {
                context.read<OnlineData>().initialValues();
                // sleep(Duration(seconds: 5));
                context.read<OnlineData>().fetchData;
              },
              icon: Icon(
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
                  ? CircularProgressIndicator()
                  : value.error
                      ? Text(
                          'Oops, something went wrong. \n ${value.errorMessage}',
                          textAlign: TextAlign.center,
                        )
                      : ListView.builder(
                          itemCount: value.map['rss']['channel']['item'].length,
                          itemBuilder: (context, index) {
                            // return Text('hello AsterGlow');
                            return StoriesCard(
                                map: value.map['rss']['channel']['item'][index]);
                            // return Text(
                            //     '${value.map['rss']['channel']['item'][index]['pubDate']}');
                          },
                        );
            },
          ),
        ),
      ),
    );
  }
}
