import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PokeView extends StatelessWidget {
  Widget _buildList(BuildContext context, DocumentSnapshot document) {
    return Card(
        color: Colors.cyanAccent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(document['name']),
            Text(document['height']),
            Text(document['weight']),
            Flexible(
              fit: FlexFit.tight,
              child: Image.network(
                'https://picsum.photos/250?image=9',
                fit: BoxFit.scaleDown,
              ),
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("StreamBuilder with FireStore")),
      body: StreamBuilder(
        stream: Firestore.instance.collection('Pokemons').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text("Loading..");
          }
          return GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            // itemExtent: 100,
            itemCount: 6,
            itemBuilder: (context, index) {
              return _buildList(context, snapshot.data.documents[index]);
            },
          );
        },
      ),
    );
  }
}
