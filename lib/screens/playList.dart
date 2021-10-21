import 'package:androidtv/myWidgets/firstRow.dart';
import 'package:androidtv/myWidgets/videoThumb.dart';
import 'package:flutter/material.dart';

class PlayList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              firstRow(),
              SizedBox(height: 20),
              Container(
                height: MediaQuery.of(context).size.height - 130,
                child: ListView(
                  children: [
                    Text(
                      'Live',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    LiveList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LiveList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        children: [
          VideoTumbnail(),
          _space,
          VideoTumbnail(),
          _space,
          VideoTumbnail()
        ],
      ),
    );
  }

  final SizedBox _space = SizedBox(width: 10);
}
