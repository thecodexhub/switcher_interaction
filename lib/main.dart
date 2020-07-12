import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Animated Switcher Interaction',
      home: AnimatedOnOffSwitcher(),
    );
  }
}

class AnimatedOnOffSwitcher extends StatefulWidget {
  @override
  _AnimatedOnOffSwitcherState createState() => _AnimatedOnOffSwitcherState();
}

class _AnimatedOnOffSwitcherState extends State<AnimatedOnOffSwitcher>
    with TickerProviderStateMixin {
  bool reverse = false;

  AnimationController _controller1, _controller2;

  Animation<double> _scaleAnimation, _widthAnimation;
  Animation<Color> _colorAnimation1, _colorAnimation2;

  @override
  void initState() {
    super.initState();
    _controller1 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    )..addListener(() {
        setState(() {});
      });
    _scaleAnimation = Tween(begin: 1.0, end: 0.9).animate(_controller1);
    _widthAnimation = Tween(begin: 100.0, end: 200.0).animate(_controller1); 
    _controller2 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 50))
          ..addListener(() {});
    _colorAnimation1 =
        ColorTween(begin: Color(0xFF000081), end: Color(0xFFFFEEEE))
            .animate(_controller2);
    _colorAnimation2 =
        ColorTween(begin: Color(0xFFFFEEEE), end: Color(0xFF000081))
            .animate(_controller2);
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  void onTapUp(TapUpDetails details) {
    _controller1.reverse();
    reverse ? _controller2.reverse() : _controller2.forward();
  }

  void onTapDown(TapDownDetails details) {
    _controller1.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent[100],
      body: Center(
        child: GestureDetector(
          onTapUp: onTapUp,
          onTapDown: onTapDown,
          onTap: () {
            setState(() {
              reverse = !reverse;
            });
            print("$reverse");
          },
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              height: 100.0, 
              width: 200.0, 
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60.0), 
                color: Color(0xFFFFEEEE),
              ),
              padding: EdgeInsets.all(0.0),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment:
                        reverse ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      height: 100.0, 
                      width: _widthAnimation.value,
                      decoration: BoxDecoration(
                        color: Color(0xFF000081),
                        borderRadius: BorderRadius.circular(60.0),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 37.0, 
                    bottom: 37.0, 
                    left: 37.0, 
                    child: Container(
                      height: 26.0, 
                      width: 26.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _colorAnimation2.value
                      ),
                    ),
                  ),
                  Positioned(
                    top: 25.0, 
                    bottom: 25.0, 
                    right: 43.0, 
                    child: Container(
                      height: 50.0, 
                      width: 14.0, 
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: _colorAnimation1.value),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
