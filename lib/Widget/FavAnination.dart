import 'dart:async';

import 'package:flutter/material.dart';

class AnimatePositiveIcon extends StatefulWidget {
  final double size;
  AnimatePositiveIcon({Key key, this.size}) : super(key: key);

  @override
  _AnimatePositiveIconState createState() => _AnimatePositiveIconState();
}

class _AnimatePositiveIconState extends State<AnimatePositiveIcon>
    with TickerProviderStateMixin {
  AnimationController controller1;
  AnimationController controller2;
  AnimationController controller3;

  Animation<double> animation1;
  Animation<double> animation2;
  Animation<double> animation3;

  Animation<double> currAnimation;

  Color curColor;
  @override
  void initState() {
    super.initState();
    controller1 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100));
    controller2 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    controller3 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 80));
    curColor = Colors.grey[100];
    animation1 = Tween(begin: 1.0, end: 0.0).animate(controller1)
      ..addListener(() {
        setState(() {});
      })..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          print(0);
          controller2.forward(from: 0);
          currAnimation = animation2;
          curColor = Colors.redAccent;
        }
      });
    animation2 = Tween(begin: 0.0, end: 1.2).animate(controller2)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          print(1);
          controller3.forward(from: 0);
          currAnimation = animation3;
        }
      });
    animation3 = Tween(begin: 1.2, end: 1.0).animate(controller3)
      ..addListener(() {
        setState(() {});
      });
    currAnimation = animation1;
    controller1.forward(from: 0);
    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Icon(
        Icons.favorite,
        size: widget.size * currAnimation.value,
        color: curColor,
      )
    );
  }
}

class AnimateNegtiveIcon extends StatefulWidget {
  AnimateNegtiveIcon({Key key,@required this.size,@required this.icon,
  @required this.callback,@required this.startColor,@required this.endColor}) : super(key: key);
  final Color startColor;
  final Color endColor;
  final double size;
  final IconData icon;
  final VoidCallback callback;
  @override
  _AnimateNegtiveIconState createState() => _AnimateNegtiveIconState();
}

class _AnimateNegtiveIconState extends State<AnimateNegtiveIcon> with TickerProviderStateMixin{

  AnimationController controller1;
  AnimationController controller2;

  Animation<double> animation1;
  Animation<double> animation2;

  Animation<double> currAnimation;

  Color curColor;
  @override
  void initState() {
    super.initState();
    controller1 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100));
    controller2 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100));
    
    curColor = widget.startColor;
    animation1 = Tween(begin: 1.0, end: 1.2).animate(controller1)
      ..addListener(() {
        setState(() {});
      })..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          print(0);
          controller2.forward(from: 0);
          currAnimation = animation2;
          curColor = widget.endColor;
        }
      });
    animation2 = Tween(begin: 1.2, end: 1.0).animate(controller2)
      ..addListener(() {
        setState(() {});
      })..addStatusListener((status){
        if(status==AnimationStatus.completed){
          Timer(Duration(milliseconds: 100),(){
            widget.callback();
          });
          
        }
      });

    currAnimation = animation1;
    
    
  }
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed:(){
          controller1.forward(from: 0);
        },
        icon: Icon(
          widget.icon,
          size: widget.size*currAnimation.value,
        ),
    );
  }
}
