import 'package:flutter/material.dart';
import 'package:sos_v_2/screen/contact/contact_list.dart';
import 'package:sos_v_2/screen/home/home.dart';
import 'package:sos_v_2/screen/notification/notification.dart';
import 'package:sos_v_2/screen/profile/profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter_',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  // List of pages to display based on the selected index
  final List<Widget> _pages = [
    const HomeScreen(),
    const ContactScreen(),
    const NotificationPage(),
     const ProfileScreen(),



  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: const TextStyle(color: Colors.blueAccent),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home,color: Colors.grey,),
            label: 'Home',
            activeIcon: Icon(Icons.home,color: Colors.blueAccent,),

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_phone,color: Colors.grey,),
            label: 'Contact',
            activeIcon: Icon(Icons.contact_phone,color: Colors.blueAccent,),

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications,color: Colors.grey,),
            label: 'Notification',
            activeIcon: Icon(Icons.notifications,color: Colors.blueAccent,),

      ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,color: Colors.grey),
            label: 'Profile',
            activeIcon: Icon(Icons.person,color: Colors.blueAccent,),

          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        onTap: _onItemTapped,
      ),
    );
  }

}
