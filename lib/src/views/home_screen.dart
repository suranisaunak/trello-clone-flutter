import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trelloapp/src/constants/constants.dart';
import 'package:trelloapp/src/providers/auth_provider.dart';
import 'package:trelloapp/src/views/auth/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  handleDrawer() {
    if (_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openEndDrawer();
    } else {
      _scaffoldKey.currentState!.openDrawer();
    }
  }

  String cardText =
      "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like";

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: handleDrawer,
          child: Icon(
            Icons.sort,
            color: primaryBlue,
            size: 40,
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          children: <Widget>[
            new Container(
              height: height * 0.3,
              decoration: BoxDecoration(gradient: buttonBgGradient),
              child: new DrawerHeader(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: new CircleAvatar(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    child: Text(
                      "D",
                      style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: primaryBlue),
                    )),
              )),
            ),
            Container(
                height: height * 0.77,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: <Widget>[
                        ListTile(
                          title: Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              'Home',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ),
                          onTap: () {
                            _scaffoldKey.currentState!.openEndDrawer();
                          },
                          leading: Icon(
                            Icons.home,
                            color: Colors.black,
                          ),
                        ),
                        Divider(),
                        ListTile(
                          title: Text('Privacy Policy',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14)),
                          leading: Icon(Icons.book, color: Colors.black),
                          onTap: () {},
                        ),
                        Divider(),
                        ListTile(
                          title: Text('Logout',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14)),
                          leading: Icon(Icons.logout, color: Colors.black),
                          onTap: () {
                               authProvider.logout().then((value) => {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()))
                                }); 
                          },
                        ),
                      ],
                    ),
                    Container(
                      width: width,
                      color: Colors.black,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        "hello",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
      body: Container(
        height: height,
        width: width,
        margin: EdgeInsets.symmetric(vertical: height * 0.05),
        child: ListView(
          scrollDirection: Axis.horizontal,
          physics: AlwaysScrollableScrollPhysics(),
          children: [
            Container(
              //    height: height * 0.4,
              //  width: width,
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Container(
                      child: Stack(
                        children: [
                          Container(
                            //  height: height * 0.4,
                            width: width * 0.7,
                            margin: EdgeInsets.symmetric(
                              horizontal: width * 0.03,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey)),
                            child: Container(
                              margin: EdgeInsets.only(top: height * 0.08),
                              child: ListView.builder(
                                  itemCount: 2,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: height * 0.02),
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: width * 0.7,

                                            /*  margin: EdgeInsets.symmetric(
                                              horizontal: width * 0.03), */
                                            padding: EdgeInsets.only(
                                                top: height * 0.05,
                                                right: width * 0.02,
                                                left: width * 0.02,
                                                bottom: height * 0.01),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: Colors.black)),
                                            child: Text(
                                              cardText,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Container(
                                            width: width * 0.7,
                                            height: height * 0.04,
                                            /* margin: EdgeInsets.symmetric(
                                              horizontal: width * 0.03),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: width * 0.05,
                                              vertical: height * 0.008), */
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: Colors.black)),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          ),
                          Container(
                            width: width * 0.7,
                            margin:
                                EdgeInsets.symmetric(horizontal: width * 0.03),
                            padding: EdgeInsets.symmetric(
                                horizontal: width * 0.05,
                                vertical: height * 0.008),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.black)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Authenication for admin ",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black),
                                ),
                                Icon(
                                  Icons.add,
                                  size: 30,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: width * 0.03),
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.05, vertical: height * 0.008),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Add Card",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Icon(
                        Icons.add,
                        size: 40,
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
