import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'add_todo.dart';

void main() => runApp(MyAPP());

String getToday() {
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat('MMM / dd / yyyy');
  var strToday = formatter.format(now);
  return strToday;
}

class Todo {
  bool isDone = false;
  String title;

  Todo(this.title);
}

class MyAPP extends StatelessWidget {
  const MyAPP({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(41, 80, 40, 0.8),
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer(); // Drawer 열기
          },
          iconSize: 40,
        ),
        actions: [
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage('assets/me.png'),
            backgroundColor: Colors.white,
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/me.png'),
                backgroundColor: Colors.white,
              ),
              accountName: Text('NOWEYTOKKISAN'),
              onDetailsPressed: () {},
              otherAccountsPictures: [],
              accountEmail: null,
              decoration: BoxDecoration(
                color: Color.fromRGBO(41, 80, 40, 0.8),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(40.0),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.view_list, color: Colors.grey[850]),
              title: Text('Schedule'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                  Icons.calendar_today_sharp, color: Colors.grey[850]),
              title: Text('Calendar'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                  Icons.settings_system_daydream, color: Colors.grey[850]),
              title: Text('D-day'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.ios_share, color: Colors.grey[850]),
              title: Text('Share Project'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.grey[850]),
              title: Text('Settings'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            color: Color.fromRGBO(41, 80, 40, 0.8),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello,\nNOWEYTOKKISAN!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    letterSpacing: 1.0,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Checking your schedule!',
                  style: TextStyle(color: Colors.grey, letterSpacing: 1.0),
                ),
                Text(
                  getToday(),
                  style: TextStyle(color: Colors.white, fontSize: 40.0),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
              icon: Icon(Icons.add_box),
              color: Colors.white,
              iconSize: 56.0,
              onPressed: (){},
            ),
          ),
          DraggableSheet(child: Column(
            children: [
              BottomSheetDummyUI(),
            ],
          )),
        ],
      ),
    );
  }
}

class DraggableSheet extends StatefulWidget {
  final Widget child;
  const DraggableSheet({super.key, required this.child});

  @override
  State<DraggableSheet> createState() => _DraggableSheetState();
}

class _DraggableSheetState extends State<DraggableSheet> {
  final sheet = GlobalKey();
  final controller = DraggableScrollableController();

  @override
  void initState() {
    super.initState();
    controller.addListener(onChanged);
  }

  void onChanged() {
    final currentSize = controller.size;
    if (currentSize <= 0.05) collapse();
  }

  void collapse() => animateSheet(getSheet.snapSizes!.first);
  void anchor() => animateSheet(getSheet.snapSizes!.first);
  void expand() => animateSheet(getSheet.maxChildSize);
  void hide() => animateSheet(getSheet.minChildSize);

  void animateSheet(double size){
    controller.animateTo(size, duration: const Duration(microseconds: 50), curve: Curves.easeInOut);
  }

  DraggableScrollableSheet get getSheet => (sheet.currentWidget as DraggableScrollableSheet);

  
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (builder, constraints){
      return DraggableScrollableSheet(
          key:sheet,
          initialChildSize: 0.5,
          maxChildSize: 0.95,
          minChildSize: 0,
          expand: true,
          snap: true,
          snapSizes: [
            60 / constraints.maxHeight,
            0.5
          ],
          builder: (BuildContext context, ScrollController scrollController) {
            return DecoratedBox(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 10,
                      spreadRadius: 1,
                      offset: Offset(0,1),
                    )
                  ],
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(22), topRight: Radius.circular(22))
                ),
              child: CustomScrollView(
                controller: scrollController,
                slivers: [
                  SliverToBoxAdapter(
                    child: widget.child,
                  )
                ]
              )
            );
          }
      );
    }
    );
  }
}


