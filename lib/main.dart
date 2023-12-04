import 'package:flutter/material.dart';

void main() {
  runApp(NewsApp());
}

class NewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Notícias',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
      routes: {
        '/newsPage': (context) => NewsHomePage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página Inicial'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Texto "Acesse todas as notícias de hoje"
              Text(
                'Acesse todas as notícias de hoje',
                style: TextStyle(fontSize: 18.0),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                  height: 20), // Adiciona um espaço entre o texto e o botão
              // Botão "Acessar Notícias"
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/newsPage');
                },
                child: Text('Acessar Notícias'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
