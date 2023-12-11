import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
              Text(
                'Acesse todas as notícias de hoje',
                style: TextStyle(fontSize: 18.0),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
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

class NewsHomePage extends StatefulWidget {
  @override
  _NewsHomePageState createState() => _NewsHomePageState();
}

class _NewsHomePageState extends State<NewsHomePage> {
  int _currentTabIndex = 0;
  List<Map<String, dynamic>> _newsContent = [];

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    final apiKey = '0e390a35e2ac4f9f860a30aa1c75938c';
    final apiUrl =
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      List<dynamic> articles = data['articles'];

      setState(() {
        _newsContent = articles
            .where((article) =>
                article['title'] != null &&
                article['description'] != null &&
                article['urlToImage'] != null)
            .map((article) => {
                  'title': article['title'],
                  'content': article['description'],
                  'image': article['urlToImage'],
                })
            .toList();
      });
    } else {
      print('Falha na requisição: ${response.statusCode}');
    }
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notícias'),
      ),
      body: Center(
        child: _newsContent.isEmpty
            ? CircularProgressIndicator()
            : LayoutBuilder(
                builder: (context, constraints) {
                  final currentNews = _newsContent[_currentTabIndex];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          currentNews['title'] ?? 'Título não disponível',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: currentNews['image'] != null
                            ? Image.network(
                                currentNews['image'],
                                width: double.infinity,
                                height: 200,
                                fit: BoxFit.cover,
                              )
                            : Placeholder(fallbackHeight: 200),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          currentNews['content'] ?? 'Conteúdo não disponível',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ],
                  );
                },
              ),
      ),
      bottomNavigationBar: _newsContent.isEmpty
          ? null
          : BottomNavigationBar(
              currentIndex: _currentTabIndex,
              onTap: _onTabTapped,
              items: _newsContent.map((article) {
                return BottomNavigationBarItem(
                  icon: Icon(
                    Icons.library_books,
                    color: Colors.green,
                  ),
                  label: article['title'].toString(),
                );
              }).toList(),
            ),
    );
  }
}
