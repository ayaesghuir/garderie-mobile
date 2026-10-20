
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

// Splash Screen : transition apres 3 secondes
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/garderie.jpg',
              width: 220,
              height: 180,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            const Text(
              'Ma Garderie',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Modele d'une activite
class Activite {
  final int id;
  final String titre;
  final String description;
  final String icone;

  const Activite({
    required this.id,
    required this.titre,
    required this.description,
    required this.icone,
  });
}

// Page principale
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  final List<Activite> activites = const [
    Activite(
      id: 1,
      titre: 'Dessin et coloriage',
      description: 'Developpement de la creativite',
      icone: '🎨',
    ),
    Activite(
      id: 2,
      titre: 'Jeux educatifs',
      description: 'Apprentissage par le jeu',
      icone: '🧩',
    ),
    Activite(
      id: 3,
      titre: 'Musique et chansons',
      description: 'Eveil musical des enfants',
      icone: '🎵',
    ),
    Activite(
      id: 4,
      titre: 'Lecture de contes',
      description: 'Decouverte des histoires',
      icone: '📚',
    ),
    Activite(
      id: 5,
      titre: 'Activites sportives',
      description: 'Developpement de la motricite',
      icone: '⚽',
    ),
  ];

  final List<String> pages = [
    'Accueil',
    'Activites',
    'A propos',
  ];

  void selectPage(int index) {
    setState(() {
      selectedIndex = index;
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ma Garderie'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepOrange,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.child_care,
                    size: 45,
                    color: Colors.white,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Ma Garderie',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Accueil'),
              selected: selectedIndex == 0,
              onTap: () => selectPage(0),
            ),
            ListTile(
              leading: const Icon(Icons.palette),
              title: const Text('Activites'),
              selected: selectedIndex == 1,
              onTap: () => selectPage(1),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('A propos'),
              selected: selectedIndex == 2,
              onTap: () => selectPage(2),
            ),
          ],
        ),
      ),

      body: selectedIndex == 1
          ? ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: activites.length,
              itemBuilder: (context, index) {
                final activite = activites[index];

                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: Text(
                      activite.icone,
                      style: const TextStyle(fontSize: 32),
                    ),
                    title: Text(
                      activite.titre,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(activite.description),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(activite.titre),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                  ),
                );
              },
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    selectedIndex == 0
                        ? Icons.child_care
                        : Icons.info_outline,
                    size: 65,
                    color: Colors.deepOrange,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    selectedIndex == 0
                        ? 'Bienvenue à Ma Garderie !'
                        : 'À propos de Ma Garderie',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Nouvelle activité'),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
