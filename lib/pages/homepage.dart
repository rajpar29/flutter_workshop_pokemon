import 'package:firebase_crud/pages/createPokemon.dart';
import 'package:firebase_crud/pages/pokeview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MaterialButton(
                  child: Text("Create PokeMon"),
                  color: Colors.cyan,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PokemonManager()));
                  }),
              MaterialButton(
                child: Text("View Pokemon"),
                color: Colors.red,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PokeView()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
