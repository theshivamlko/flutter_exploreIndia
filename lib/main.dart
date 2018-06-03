import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  Animation<double> animationScaleDown;
  Animation<double> animationTextSizeDown;
  Animation<double> animationFadeIn;
  Animation<double> animationFadeInInput;
  Animation<double> animationMoveUp;
  Animation<double> animationRotate;
  AnimationController controller, controller2, controller3, controller4;
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passController = new TextEditingController();

  var height = 300.0;
  var width = 300.0;
  var spacing = 350.0;
  var progressDialog;
  bool isProgressDialog = false;

  @override
  void initState() {
    super.initState();

    initData();

    controller.forward();
    controller4.repeat();

    controller.addListener(() {
      setState(() {
        //   print('-------');
        // print(animationFadeIn.status);
        if (animationFadeIn.status == AnimationStatus.completed) {
          controller2.forward();
          new Timer(
              const Duration(milliseconds: 400), () => controller3.forward());
        }
      });
    });

    controller2.addListener(() {
      setState(() {
        // print('controller2-------');
        //   print(animationMoveUp.status);
        if (animationMoveUp.status == AnimationStatus.forward) {
          height = animationScaleDown.value;
          width = height;

          //if (spacing > 0) spacing  --;
        } else if (animationMoveUp.status == AnimationStatus.completed) {}
      });
    });

    controller4.addListener(() {
      setState(() {
        //   print('controller4-----####');
        if (animationRotate.status == AnimationStatus.completed) {
          controller4.forward();
        }
      });
    });
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    //  print('setState######');
    //  print(animationRotate.value/360);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
        type: MaterialType.transparency,
        child: new Container(
            child: Stack(children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                begin: Alignment.topLeft,
                colors: [
                  const Color(0xFF860000),
                  const Color(0xFFbf360c),
                  const Color(0xFF860000)
                ], // whitish to gray
                tileMode:
                    TileMode.repeated, // repeats the gradient over the canvas
              ),
            ),
          ),
          new Opacity(
            opacity: animationFadeIn.value,
            child: new Container(
                alignment: Alignment(0.0, animationMoveUp.value),
                child: new Wrap(
                  spacing: 8.0, // gap between adjacent chips
                  runSpacing: 4.0,
                  children: <Widget>[
                    new Container(
                      child: new Image.asset(
                        'images/namaste2.png',
                        height: height,
                        width: width,
                      ),
                      alignment: Alignment(0.0, animationMoveUp.value),
                    ),
                    new Container(
                      child: Text(
                        'Explore India',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: animationTextSizeDown.value,
                            fontFamily: 'samarn'),
                      ),
                      alignment: Alignment(0.0, animationMoveUp.value),
                    )
                  ],
                )),
          ),
          new Opacity(
              opacity: animationFadeInInput.value,
              child: new Stack(children: <Widget>[
                new Center(
                  child: new Container(
                    width: 320.0,
                    height: 60.0,
                    alignment: Alignment.center,
                    child: TextField(
                      controller: usernameController,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                      decoration: InputDecoration(
                        hintText: 'Username',
                        hintStyle: TextStyle(color: Colors.white70),
                        border: InputBorder.none,
                      ),
                    ),
                    decoration: new BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: new BorderRadius.circular(4.0),
                        border: new Border.all(
                          color: Colors.white,
                          width: 1.0,
                        )),
                  ),
                ),
                new Center(
                  child: new Container(
                    width: 320.0,
                    height: 60.0,
                    margin: new EdgeInsets.only(top: 150.0),
                    child: TextField(
                      controller: passController,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.white70),
                        border: InputBorder.none,
                      ),
                    ),
                    decoration: new BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: new BorderRadius.circular(4.0),
                        border: new Border.all(
                          color: Colors.white,
                          width: 1.0,
                        )),
                  ),
                ),
                new Center(
                  child: new GestureDetector(
                      onTap: () {
                        submit();
                      },
                      child: new Container(
                        width: 320.0,
                        height: 60.0,
                        alignment: Alignment.center,
                        margin: new EdgeInsets.only(top: 350.0),
                        decoration: new BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              new BorderRadius.all(const Radius.circular(30.0)),
                        ),
                        child: new Text(
                          "Sign In",
                          style: new TextStyle(
                            color: Colors.red,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.3,
                          ),
                        ),
                      )),
                ),
                !isProgressDialog
                    ? new Container()
                    : new Container(
                        alignment: Alignment.center,
                        color: new Color.fromARGB(150, 0, 0, 0),
                        child: new Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              new Transform(
                                  alignment: FractionalOffset.center,
                                  transform: new Matrix4.rotationZ(
                                      -animationRotate.value / 360),
                                  child: new Image.asset(
                                    'images/ring_design.png',
                                    height: 150.0,
                                    width: 150.0,
                                  )),
                              new Container(
                                  margin: const EdgeInsets.only(top: 250.0),
                                  child: Text(
                                    'Signing in...',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 40.0,
                                        fontFamily: 'samarn'),
                                  ))
                            ]))
              ])),
        ]
                // This trailing comma makes auto-formatting nicer for build methods.
                )));
  }

  void submit() {
    print(usernameController.text);
    if (passController.text.isNotEmpty) {
      getSignIn(usernameController.text, passController.text);
    } else {
      showMyDialog('Please enter number');
    }
  }

  getSignIn(String user, String pass) async {
    print(pass);
    setState(() {
      isProgressDialog = true;
    });
    await firebaseAuth
        .signInWithEmailAndPassword(email: user, password: pass)
        .then((FirebaseUser user) {
      print('****${user.isEmailVerified}');

      showMyDialog('Successfully signed in');
    }).catchError((e) => showMyDialog('${e}'));
  }

  void showMyDialog(String msg) {
    setState(() {
      isProgressDialog = false;
    });

    var alert = new AlertDialog(
      content: new Stack(
        children: <Widget>[
          new Text(
            'Message',
            style:
                TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
          ),
          new Container(
              margin: new EdgeInsets.only(top: 40.0),
              child: new Text(
                '$msg',
                style: TextStyle(
                    color: Colors.black45, fontWeight: FontWeight.bold),
              )),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: new Text(
              'OK',
              style: TextStyle(color: const Color(0xFF860000)),
            ))
      ],
    );

    showDialog(
        context: context,
        builder: (_) {
          return alert;
        });
  }

  void initData() {
    controller = new AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    animationFadeIn = new Tween(begin: 0.0, end: 1.0).animate(controller);

    controller2 = new AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animationMoveUp = new Tween(begin: 0.0, end: -0.8).animate(controller2);
    animationScaleDown =
        new Tween(begin: 300.0, end: 180.0).animate(controller2);
    animationTextSizeDown =
        new Tween(begin: 70.0, end: 40.0).animate(controller2);

    controller3 = new AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    animationFadeInInput = new Tween(begin: 0.0, end: 1.0).animate(controller3);

    controller4 = new AnimationController(
        duration: new Duration(milliseconds: 700), vsync: this);
    animationRotate = new Tween(begin: 0.0, end: 360.0).animate(controller4);

    /*progressDialog = new AlertDialog(
      content: new Container(
        color: Colors.red,
        child: new Image.asset(
          'images/ring_design.png',
          height: 100.0,
          width: 100.0,
        ),
      ),
    );*/
  }
}
