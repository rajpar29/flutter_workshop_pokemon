import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/models/pokemon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PokemonManager extends StatefulWidget {
  PokemonManager();
  @override
  State<StatefulWidget> createState() {
    return PokemonManagerState();
  }
}

class PokemonManagerState extends State {
  final pokemonCollection = Firestore.instance.collection("Pokemons");
  final formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _formBuilder(),
      appBar: AppBar(
        title: Text("Pokemon Manager"),
      ),
    );
  }

  _formBuilder() {
    return ListView(children: [
      FormBuilder(
        key: formKey,
        autovalidate: true,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              child: FormBuilderTextField(
                attribute: 'name',
                decoration: InputDecoration(
                    labelText: "Name", border: OutlineInputBorder()),
                validators: [FormBuilderValidators.required()],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: FormBuilderTextField(
                keyboardType: TextInputType.number,
                validators: [FormBuilderValidators.required()],
                attribute: 'height',
                decoration: InputDecoration(
                    labelText: "Height", border: OutlineInputBorder()),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: FormBuilderTextField(
                validators: [FormBuilderValidators.required()],
                keyboardType: TextInputType.number,
                attribute: 'weight',
                decoration: InputDecoration(
                    labelText: "Weight", border: OutlineInputBorder()),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: FormBuilderCheckboxList(
                validators: [
                  (val) {
                    if (val.length == 0) {
                      return "Select atleast one type";
                    }
                  }
                ],
                decoration: InputDecoration(
                    labelText: "Type", border: OutlineInputBorder()),
                attribute: "type",
                options: [
                  FormBuilderFieldOption(value: "Fire"),
                  FormBuilderFieldOption(value: "Water"),
                  FormBuilderFieldOption(value: "Wind"),
                  FormBuilderFieldOption(value: "grass"),
                  FormBuilderFieldOption(value: "Electric"),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                MaterialButton(
                  color: Colors.blueAccent,
                  child: Text("Submit"),
                  onPressed: _submit,
                ),
                MaterialButton(
                  child: Text("Reset"),
                  color: Colors.redAccent,

                  onPressed: () {
                    formKey.currentState.reset();
                  },
                ),
              ],
            )
          ],
        ),
      ),
    ]);
  }


  _submit() {
    if (!formKey.currentState.saveAndValidate()) {
      return;
    }
    var data = formKey.currentState.value;
    showDialog(
        context: context,
        builder: (context) => Center(
              child: Container(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(),
              ),
            ));

    Pokemon pokemon = Pokemon(
        height: data["height"],
        weight: data["weight"],
        name: data["name"],
        imageUrl: 'SomeSampleImage',
        type: data["type"]);
    pokemonCollection.document().setData(pokemon.toJson()).then((res) {
      Navigator.pop(context);
      _showSnackbar("Success");
      formKey.currentState.reset();

      pokemonCollection.getDocuments().then((snapshot) {
        print(snapshot.metadata);
        snapshot.documents.forEach((doc) {
          print(doc);
          print(Pokemon.fromMap(doc.data));
        });
      });
    }).catchError((err) {
      Navigator.pop(context);
      _showSnackbar("Failure");
    });
  }

  _showSnackbar(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.lightGreen,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
