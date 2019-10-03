import 'package:flutter/material.dart';
import 'package:anweshan_admin/pages/change_password.dart';
import 'package:anweshan_admin/pages/edit_quiz.dart';
import 'package:anweshan_admin/pages/messaging.dart';
import 'package:anweshan_admin/pages/new_quiz.dart';
import 'package:anweshan_admin/pages/register.dart';
import 'package:anweshan_admin/pages/review_quiz.dart';
import 'package:anweshan_admin/pages/start_quiz.dart';
import 'package:anweshan_admin/pages/top_gems.dart';
import 'package:anweshan_admin/pages/top_score.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<String> _pageTitle = [
    'Welcome',
    'New Quiz',
    'Edit Quiz',
    'Review Quiz',
    'Start Quiz',
    'Password',
    'New Contestant',
    'Score',
    'Gems',
    'Broadcast',
  ];
  int _currentPage = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      keepPage: false,
      initialPage: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(_pageTitle[_currentPage]),
      ),
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        child: Drawer(
          child: Column(
            children: <Widget>[
              DrawerHeader(
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Container(
                  height: 150,
                  alignment: Alignment.center,
                  child: Text(
                    'Only Admins !',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    ListTile(
                      title: Text('New Quiz'),
                      onTap: () {
                        Navigator.of(context).pop();
                        setState(() {
                          _currentPage = 1;
                          _pageController.jumpToPage(_currentPage);
                        });
                      },
                    ),
                    ListTile(
                      title: Text('Edit Quiz'),
                      onTap: () {
                        Navigator.of(context).pop();
                        setState(() {
                          _currentPage = 2;
                          _pageController.jumpToPage(_currentPage);
                        });
                      },
                    ),
                    ListTile(
                      title: Text('Review Quiz'),
                      onTap: () {
                        Navigator.of(context).pop();
                        setState(() {
                          _currentPage = 3;
                          _pageController.jumpToPage(_currentPage);
                        });
                      },
                    ),
                    ListTile(
                      title: Text('Start Quiz'),
                      onTap: () {
                        Navigator.of(context).pop();
                        setState(() {
                          _currentPage = 4;
                          _pageController.jumpToPage(_currentPage);
                        });
                      },
                    ),
                    Divider(
                      color: Color(0xffaaaaaa),
                    ),
                    ListTile(
                      title: Text('Change My Password'),
                      onTap: () {
                        Navigator.of(context).pop();
                        setState(() {
                          _currentPage = 5;
                          _pageController.jumpToPage(_currentPage);
                        });
                      },
                    ),
                    ListTile(
                      title: Text('Manual Registration'),
                      onTap: () {
                        Navigator.of(context).pop();
                        setState(() {
                          _currentPage = 6;
                          _pageController.jumpToPage(_currentPage);
                        });
                      },
                    ),
                    Divider(
                      color: Color(0xffaaaaaa),
                    ),
                    ListTile(
                      title: Text('Top Score'),
                      onTap: () {
                        Navigator.of(context).pop();
                        setState(() {
                          _currentPage = 7;
                          _pageController.jumpToPage(_currentPage);
                        });
                      },
                    ),
                    ListTile(
                      title: Text('Top Gems'),
                      onTap: () {
                        Navigator.of(context).pop();
                        setState(() {
                          _currentPage = 8;
                          _pageController.jumpToPage(_currentPage);
                        });
                      },
                    ),
                    Divider(
                      color: Color(0xffaaaaaa),
                    ),
                    ListTile(
                      title: Text('Broadcast'),
                      onTap: () {
                        Navigator.of(context).pop();
                        setState(() {
                          _currentPage = 9;
                          _pageController.jumpToPage(_currentPage);
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: PageView(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          Welcome(),
          NewQuiz(),
          EditQuiz(),
          ReviewQuiz(),
          StartQuiz(),
          ChangePassword(),
          Register(),
          TopScore(),
          TopGems(),
          Messaging(),
        ],
      ),
    );
  }
}

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'Welcome!',
          style: TextStyle(
            fontSize: 30,
            color: Colors.blueAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'You can use this app to manage the database for Anweshan app. All actions are listed in the left side drawer.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xff808080),
              fontSize: 18.0,
            ),
          ),
        ),
      ],
    );
  }
}
