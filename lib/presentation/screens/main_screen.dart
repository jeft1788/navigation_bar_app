import 'package:flutter/material.dart';
import 'package:navigation_bar_app/presentation/screens/LoginScreen.dart';
import 'package:navigation_bar_app/presentation/screens/maps_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedItem = 0;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 8),
                child: const Text(
                  'Parque Natural Nacional Puracé',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              Text(
                'Puracé, Cauca, Colombia',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 20,
                ),
              )
            ],
          )),
          const FavoriteWidget(),
        ],
      ),
    );
    Color color = Theme.of(context).primaryColor;
    Widget buttonSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButtonColumn(color, Icons.call, 'LLAMAR'),
        _buildButtonColumn(color, Icons.near_me, 'RUTA'),
        _buildButtonColumn(color, Icons.share, 'COMPARTIR'),
      ],
    );
    Widget textSection = Container(
      padding: const EdgeInsets.all(32),
      child: const Text(
        'Declarado por la UNESCO como Reserva de la Biosfera en 1979, el Parque'
        'Nacional Natural Puracé es una zona volcánica y lo refleja tanto en sus '
        'numerosas fuentes azufradas como en su nombre, que en lengua quechua sig'
        'nifica “montaña de fuego”. Allí nacen los principales ríos de Colombia:'
        'Magdalena, Cauca, Patía y Caquetá y también 30 lagunas tranquilas y cla'
        'ras, ideales para la contemplación. Dentro de su estupendo paisaje se '
        'levanta la cadena volcánica de los Coconucos, también conocida como'
        'Serranía de los Coconucos, compuesta por 11 volcanes. De éstos los mas'
        'destacados son el Pan de Azúcar (5.000 msnm), el Puracé (4.780 msnm) el '
        'único activo, y el Coconuco (4.600 msnm). A comienzos de siglo XX, toda'
        'la Serranía permanecía nevada; actualmente, ni siquiera el cerro más al'
        'to, el Pan de Azúcar, conserva nieve. Dicen los indígenas que el hacha'
        'de los blancos ahuyento a “Jucas” el dueño de la nieve y el granizo.',
        softWrap: true,
        textAlign: TextAlign.justify,
      ),
    );
    return MaterialApp(
      title: 'Matrial App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: //codigo de main
            ListView(
          children: [
            Image.asset(
              'images/volcan.jpg',
              width: 600,
              height: 240,
              fit: BoxFit.cover,
            ),
            titleSection,
            buttonSection,
            textSection,
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          currentIndex: selectedItem,
          onTap: (value) {
            if (value == 0) {}
            if (value == 1) {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => LoginScreen()));
            }
            if (value == 2) {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => MapScreen()));
            }
          },
          elevation: 0,
          items: [
            //Item 1
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              activeIcon: const Icon(Icons.home_filled),
              label: 'Inicio',
              backgroundColor: colors.primary,
            ),
            //Item 2
            BottomNavigationBarItem(
              icon: const Icon(Icons.person_3_outlined),
              activeIcon: const Icon(Icons.person_3),
              label: 'Perfíl',
              backgroundColor: colors.tertiary,
            ),
            //Item 3
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings_outlined),
              activeIcon: const Icon(Icons.settings),
              label: 'Configutacion',
              backgroundColor: colors.tertiary,
            ),
          ],
        ),
      ),
    );
  }

  void startHammering() {
    print('bang bang bang');
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
            //OnPressed: startHammering(),
          ),
        ),
      ],
    );
  }
}

class FavoriteWidget extends StatefulWidget {
  const FavoriteWidget({super.key});

  @override
  State<FavoriteWidget> createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = true;
  int _favoriteCount = 41;

  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _favoriteCount -= 1;
        _isFavorited = false;
      } else {
        _favoriteCount += 1;
        _isFavorited = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(0),
          child: IconButton(
            padding: const EdgeInsets.all(0),
            alignment: Alignment.centerRight,
            icon: (_isFavorited
                ? const Icon(Icons.star)
                : const Icon(Icons.star_border)),
            color: Colors.red[500],
            onPressed: _toggleFavorite,
          ),
        ),
        SizedBox(
          width: 18,
          child: SizedBox(
            child: Text('$_favoriteCount'),
          ),
        ),
      ],
    );
  }
}
