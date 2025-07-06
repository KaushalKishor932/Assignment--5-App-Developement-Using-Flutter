import 'package:flutter/material.dart';

void main() => runApp(InfoApp());

class InfoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Info App',
      debugShowCheckedModeBanner: false,
      home: NavigationController(),
    );
  }
}

class NavigationController extends StatefulWidget {
  @override
  State<NavigationController> createState() => _NavigationControllerState();
}

class _NavigationControllerState extends State<NavigationController> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = [
    FeedbackPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.info_outline), label: 'About'),
          BottomNavigationBarItem(icon: Icon(Icons.contact_mail), label: 'Contact'),
          BottomNavigationBarItem(icon: Icon(Icons.feedback), label: 'Feedback'),
        ],
      ),
    );
  }
}

// Existing HomePage, AboutPage, ContactPage code remains unchanged...

class FeedbackPage extends StatefulWidget {
  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  double _sliderValue = 5;
  String? _selectedCategory;
  bool agree = false;
  List<String> features = ['Easy to Use', 'Design', 'Speed', 'Support'];
  Map<String, bool> selectedFeatures = {};

  @override
  void initState() {
    super.initState();
    for (var f in features) {
      selectedFeatures[f] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(),
          centerTitle: true,
          title: const Text('Flutter Feedback Form', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Name'),
              const SizedBox(height: 5),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter your name',
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 15),
              const Text('Roll Number'),
              const SizedBox(height: 5),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter your roll number',
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 15),
              const Text('Enter your feedback...'),
              const SizedBox(height: 5),
              TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 20),
              Text('Rate your experience  ${_sliderValue.toInt()}'),
              Slider(
                value: _sliderValue,
                min: 1,
                max: 10,
                divisions: 9,
                onChanged: (value) {
                  setState(() {
                    _sliderValue = value;
                  });
                },
              ),
              const SizedBox(height: 10),
              const Text('Select a category'),
              const SizedBox(height: 5),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                value: _selectedCategory,
                hint: Text('Choose a category'),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
                items: ['Bug Report', 'Feature Request', 'General']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
              ),
              const SizedBox(height: 20),
              const Text('What features did you like?', style: TextStyle(fontWeight: FontWeight.bold)),
              ...features.map((feature) => CheckboxListTile(
                value: selectedFeatures[feature],
                title: Text(feature),
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (val) {
                  setState(() {
                    selectedFeatures[feature] = val ?? false;
                  });
                },
              )),
              CheckboxListTile(
                value: agree,
                title: const Text('I agree to the terms and conditions'),
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (value) {
                  setState(() {
                    agree = value ?? false;
                  });
                },
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
