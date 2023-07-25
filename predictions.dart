// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore: use_key_in_widget_constructors
class PredictionScreen extends StatefulWidget {
  @override
  _PredictionScreenState createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

  // ignore: unused_field
  String _prediction = '';

  void _getPrediction() async {
    final form = _formKey.currentState;
    if (form!.validate()) {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                title: Text('Mensaje'),
                content: Text('Formulario enviado'),
              ));
    }

    const apiUrl = 'http://127.0.0.1:5000/predict';
    final headers = {'Content-Type': 'application/json'};
    final data = jsonEncode({'feature': double.parse(_controller.text)});

    final response =
        await http.post(apiUrl as Uri, headers: headers, body: data);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      setState(() {
        _prediction = responseData['prediction'].toString();
      });
    } else {
      setState(() {
        _prediction = 'Error en la predicción';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const CircleAvatar(
                radius: 100.0,
                backgroundColor: Colors.grey,
                backgroundImage: AssetImage('assets/student.png'),
              ),
              const Text(
                'Calificaciones',
                style: TextStyle(fontFamily: 'Lumanosimo', fontSize: 50.0),
              ),
              const Text(
                'Alumnos: ',
                style: TextStyle(fontFamily: 'Lumanosimo', fontSize: 20.0),
              ),
              const SizedBox(height: 20),
              TextFormField(
                  controller: _controller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por Favor Ingresa Una Nota';
                    }
                    if (value.length > 2) {
                      return 'No Se Pueden poner mas de dos digitos';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Nota1',
                    labelText: 'Ingresa la primer nota',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.note_alt),
                  )),
              const SizedBox(height: 20),
              TextFormField(
                  controller: _controller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'No Puede Estar Vacio Sin Una Nota';
                    }
                    if (value.length > 2) {
                      return 'No Se Pueden poner mas de dos digitos';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Nota2',
                    labelText: 'Ingresa la segunda nota',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.note_alt_outlined),
                  )),
              const SizedBox(height: 20),
              TextFormField(
                  controller: _controller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por Favor Ingresa Una Nota';
                    }
                    if (value.length > 2) {
                      return 'No Se Pueden poner mas de dos digitos';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Nota3',
                    labelText: 'Ingresa la tercera nota',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.note_alt_outlined),
                  )),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _getPrediction,
                child: const Text('Enviar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
