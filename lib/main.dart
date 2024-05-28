import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Portfolio/aboutme.dart';
import 'Portfolio/educationPage.dart';
import 'Portfolio/workExperience.dart';
import 'Portfolio/skills.dart';
import 'Portfolio/projects.dart';
import 'Portfolio/comments.dart';
import 'package:fin/Calculator/CalculatorScreen.dart';
import 'package:fin/QUIZ/QuizScreen.dart';
import 'package:fin/Weather/Weather.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const FirstScreen(),
        '/aboutMe': (context) => const AboutMe(),
        '/education': (context) => const EducationPage(),
        '/workexperience': (context) => WorkExpPage(),
        '/skills': (context) => Skills(),
        '/project': (context) => const project(),
        '/calculator': (context) => const CalculatorScreen(),
        '/quiz': (context) => const QuizScreen(),
        '/weather': (context) => const WeatherWidget(),
        '/comments': (context) => const BlogHomePage(),
      },
    );
  }
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "My Portfolio",
            style: TextStyle(
              fontFamily: "Comfortaa",
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 30, 122, 44),
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 205, 196, 196),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/drawer.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Text(
                  "App List",
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.calculate),
                title: const Text('Calculator'),
                onTap: () {
                  Navigator.pushNamed(context, '/calculator');
                },
              ),
              ListTile(
                leading: const Icon(Icons.quiz_outlined),
                title: const Text('QUIZZ'),
                onTap: () {
                  Navigator.pushNamed(context, '/quiz');
                },
              ),
              ListTile(
                leading: const Icon(Icons.sunny_snowing),
                title: const Text('Weather'),
                onTap: () {
                  Navigator.pushNamed(context, '/weather');
                },
              ),
              ListTile(
                leading: const Icon(Icons.developer_mode_sharp),
                title: const Text('My Portfolio'),
                onTap: () {
                  Navigator.pushNamed(context, '/');
                },
              ),
              ListTile(
                leading: const Icon(Icons.lightbulb_outline),
                title: Text(_isDarkMode ? 'Switch to Light Mode' : 'Switch to Dark Mode'),
                onTap: () {
                  setState(() {
                    _isDarkMode = !_isDarkMode;
                  });
                },
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/background.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: <Widget>[
                const CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage("images/IMG_2085.jpg"),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Khandaker Rezoanul Haque",
                  style: TextStyle(
                    fontFamily: 'Sniglet',
                    fontSize: 40.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  "Student of Daffodil International University \n\n"
                  "    Studing CSE ID: 212-15-4204",
                  style: TextStyle(
                    fontFamily: 'Caveat Brush',
                    fontSize: 17,
                    color: Colors.white,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const SizedBox(
                  height: 27,
                  width: 250,
                  child: Divider(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 10.0,
                    runSpacing: 10.0,
                    children: [
                      _buildButton(
                        context,
                        Icons.face_outlined,
                        "About Me",
                        '/aboutMe',
                        Colors.deepPurple,
                        Colors.purple,
                      ),
                      _buildButton(
                        context,
                        Icons.school_outlined,
                        "My Education",
                        '/education',
                        Colors.purple,
                        Colors.deepPurple,
                      ),
                      _buildButton(
                        context,
                        Icons.work_outline,
                        "Experience",
                        '/workexperience',
                        Colors.deepPurple,
                        Colors.purple,
                      ),
                      _buildButton(
                        context,
                        Icons.code_outlined,
                        "My Skills",
                        '/skills',
                        Colors.purple,
                        Colors.deepPurple,
                      ),
                      _buildButton(
                        context,
                        Icons.dashboard_outlined,
                        "My Project",
                        '/project',
                        Colors.purple,
                        Colors.deepPurple,
                      ),
                      _buildButton(
                        context,
                        Icons.comment_outlined,
                        "Comment Section",
                        '/comments',
                        Colors.purple,
                        Colors.deepPurple,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 29,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.twitter),
                      color: Colors.lightBlue,
                      iconSize: 40,
                      onPressed: twitter_url,
                    ),
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.github),
                      color: Colors.white,
                      iconSize: 40,
                      onPressed: github_url,
                    ),
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.linkedin),
                      color: Colors.indigoAccent,
                      iconSize: 43,
                      onPressed: linked_in_url,
                    ),
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.quora),
                      color: Colors.red,
                      iconSize: 43,
                      onPressed: quora_url,
                    ),
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.medium),
                      color: Colors.white,
                      iconSize: 43,
                      onPressed: medium_url,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, IconData icon, String label, String route, Color startColor, Color endColor) {
    return SizedBox(
      height: 60.0,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
        padding: const EdgeInsets.all(0.0),
        splashColor: Colors.blueAccent,
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [startColor, endColor],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 260.0, minHeight: 60.0),
            alignment: Alignment.center,
            child: ListTile(
              leading: Icon(
                icon,
                color: Colors.white,
                size: 30,
              ),
              title: Text(
                label,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: "Comfortaa",
                ),
              ),
            ),
          ),
        ),
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
      ),
    );
  }
}

void linked_in_url() async {
  const url = 'https://www.linkedin.com';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

void twitter_url() async {
  const url = 'https://twitter.com';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

void github_url() async {
  const url = 'https://github.com/Kh-rez1';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

void quora_url() async {
  const url = 'https://quora.com';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

void medium_url() async {
  const url = 'https://medium.com';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
