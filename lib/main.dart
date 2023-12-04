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

class NewsHomePage extends StatefulWidget {
  @override
  _NewsHomePageState createState() => _NewsHomePageState();
}

class _NewsHomePageState extends State<NewsHomePage> {
  int _currentTabIndex = 0;
  List<Map<String, String>> _newsContent = [
    {
      'title':
          'Promotoria antiterrorista investiga assassinato de turista próximo à Torre Eiffel em Paris',
      'content':
          'A Promotoria Nacional Antiterrorista (Pnat) abriu uma investigação por assassinato e tentativa de assassinato relacionada a atividade terrorista e por associação criminosa terrorista. Outras três pessoas de seu círculo também foram detidas, informou a Pnat neste domingo.O promotor antiterrorismo Jean-François Ricard disse à imprensa que o agressor havia jurado lealdade ao grupo Estado Islâmico (EI) em um vídeo no início de outubro, onde, falando em árabe, expressou "apoio a jihadistas que operam em diferentes áreas".O ataque ocorreu por volta das 21h locais (17h em Brasília) perto da ponte Bir Hakeim, um lugar muito frequentado por turistas devido à sua proximidade com a Torre Eiffel.',

      'image':
          'https://s2-oglobo.glbimg.com/Kf31PTBMhQCqsh7s5ZmHgpoQjmk=/0x0:8256x5504/888x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_da025474c0c44edd99332dddb09cabe8/internal_photos/bs/2023/5/A/BoR9UJQdWf9X7cGlSUNg/105195127-police-officers-stand-guard-in-a-security-perimetre-set-after-one-person-was-killed-and-t.jpg', // Notícia 1
    },
    {
      'title':
          'Trecho da BR-040 em Minas registra uma morte a cada 2 km em 2023',
      'content':
          'Um trecho de 54 km da BR-040, entre o condomínio Alphaville, em Nova Lima, na Grande BH, e Congonhas, região Central de Minas, registrou 27 mortes em acidentes de dezembro de 2022 até agora. O dado faz parte uma uma prévia de um relatório feito pelo engenheiro civil Hérzio Mansur, integrante de um grupo de trabalho de segurança no trânsito do Conselho Federal de Engenharia e Agronomia (Confea).',
      'image':
          'https://www.hojeemdia.com.br/image/policy:1.730296.1628590779:1628590779/image.jpg?f=2x1&w=1000&', // Noticia 2
    },
    {
      'title':
          'Vídeo mostra ex-marido de Naiara Azevedo dando tapa em celular para parar gravação',
      'content':
          'Na gravação, Naiara e Rafael mostram alguns ferimentos nos braços. "Rafael está falando que eu agredi ele porque ele juntou a mão nas minhas duas orelhas. Olha os meus braços", diz ela. Rafael então questiona: "Quem me deu um murro na cara primeiro, Naiara?". A cantora responde: "Eu não te dei murro na cara. Você falou que minha mãe é uma puta".Nesse momento, Rafael diz para Naiara falar a verdade e bate no celular para parar a gravação.',
      'image':
          'https://p2.trrsf.com/image/fget/cf/774/0/images.terra.com/2023/12/04/fotos-(74)-t4idgnhfkaxv.jpg', // Notícia 3
    },
  ];

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
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 600) {
              // Se a largura da tela for maior que 600 (modo tablet), exibe o layout Row
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Imagem da notícia à esquerda
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      _newsContent[_currentTabIndex]['image']!,
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Texto da notícia à direita
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _newsContent[_currentTabIndex]['title']!,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          _newsContent[_currentTabIndex]['content']!,
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              // Se a largura da tela for menor que 600 (modo celular), exibe o layout Column
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Imagem da notícia
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      _newsContent[_currentTabIndex]['image']!,
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Texto da notícia
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _newsContent[_currentTabIndex]['title']!,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          _newsContent[_currentTabIndex]['content']!,
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTabIndex,
        onTap: _onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Notícia 1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Notícia 2',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Notícia 3',
          ),
        ],
      ),
    );
  }
}
