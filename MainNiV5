import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/profile.dart';
import 'pages/message.dart';
import 'pages/settings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppsDev2B Mobile App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  late AnimationController _pageAnimController;
  late Animation<double> _pageFadeAnim;

  final List<Widget> _pages = [
    HomePage(),
    ProfilePage(),
    MessagePage(),
    SettingsPage(),
  ];

  @override
  void initState() {
    super.initState();
    _pageAnimController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    _pageFadeAnim = CurvedAnimation(
      parent: _pageAnimController,
      curve: Curves.easeInOut,
    );
    _pageAnimController.forward();
  }

  @override
  void dispose() {
    _pageAnimController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) async {
    if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
      Navigator.pop(context);
    }

    if (_selectedIndex == index) return;

    await _pageAnimController.reverse();

    setState(() {
      _selectedIndex = index;
    });

    _pageAnimController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color.fromARGB(255, 206, 59, 74),
      appBar: AppBar(
        title: Text(
          'AppsDev2B Mobile App',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 92, 37, 35),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration:
                  BoxDecoration(color: Color.fromARGB(255, 206, 59, 74)),
              child: Text(
                'Menu',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 30),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              splashColor: Colors.red.withOpacity(0.2),
              onTap: () => _onItemTapped(0),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              splashColor: Colors.red.withOpacity(0.2),
              onTap: () => _onItemTapped(1),
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Message'),
              splashColor: Colors.red.withOpacity(0.2),
              onTap: () => _onItemTapped(2),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              splashColor: Colors.red.withOpacity(0.2),
              onTap: () => _onItemTapped(3),
            ),
          ],
        ),
      ),
      body: FadeTransition(
        opacity: _pageFadeAnim,
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: const Color.fromARGB(255, 92, 37, 35),
        selectedItemColor: const Color.fromARGB(255, 247, 1, 1),
        unselectedItemColor: const Color.fromARGB(255, 252, 252, 252),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Message'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
