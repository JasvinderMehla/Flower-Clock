import "package:flutter/material.dart";
import 'dart:math';

class ColorLoader2 extends StatefulWidget {
  final double radius;

  ColorLoader2({this.radius = 90.0});

  @override
  _ColorLoader2State createState() => _ColorLoader2State();
}

class _ColorLoader2State extends State<ColorLoader2>
    with SingleTickerProviderStateMixin {
  Animation<double> animation_rotation;
  Animation<double> animation_radius_in;
  Animation<double> animation_radius_out;
  AnimationController controller;

  double radius;

  @override
  void initState() {
    super.initState();

    radius = widget.radius;

    controller = AnimationController(
        lowerBound: 0.0,
        upperBound: 1.0,
        duration: const Duration(milliseconds: 10090),
        vsync: this);

    animation_rotation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 1.0, curve: Curves.linear),
      ),
    );

    animation_radius_in = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.75, 1.0, curve: Curves.easeInCirc),
      ),
    );

    animation_radius_out = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 0.25, curve: Curves.easeOutCirc),
      ),
    );

    controller.addListener(() {
      setState(() {
        if (controller.value >= 0.75 && controller.value <= 1.0)
          radius = widget.radius * animation_radius_in.value;
        else if (controller.value >= 0.0 && controller.value <= 0.25)
          radius = widget.radius * animation_radius_out.value;
      });
    });

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {}
    });

    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    final animation = Tween(
      begin: 0.00,
      end: 0.80,
    ).animate(controller);
    return Container(
      width: 100.0,
      height: 100.0,
      //color: Colors.black12,
      child: new Center(
        child: new RotationTransition(
          turns: animation_rotation,
          child: new Container(
            //color: Colors.limeAccent,
            child: new Center(
              child: Stack(
                children: <Widget>[
                  new Transform.translate(
                    child: Image(
                      image: AssetImage('assets/P5.png'),
                      fit: BoxFit.fill,
                    ),
                    offset: Offset(
                      radius * cos(-0.3 + 3 * pi / 8),
                      radius * sin(0.0 + 3 * pi / 8),
                    ),
                  ),
                  new Transform.translate(
                    child: Image(
                      image: AssetImage('assets/P4.png'),
                      fit: BoxFit.fill,
                    ),
                    offset: Offset(
                      radius * cos(0.0 + 5 * pi / 8),
                      radius * sin(0.0 + 5 * pi / 8),
                    ),
                  ),
                  new Transform.translate(
                    child: Image(
                      image: AssetImage('assets/P3.png'),
                      fit: BoxFit.fill,
                    ),
                    offset: Offset(
                      radius * cos(0.0 + 7 * pi / 8),
                      radius * sin(-0.3 + 7 * pi / 8),
                    ),
                  ),
                  new Transform.translate(
                    child: Image(
                      image: AssetImage('assets/P2.png'),
                      fit: BoxFit.fill,
                    ),
                    offset: Offset(
                      radius * cos(0.0 + 9 * pi / 8),
                      radius * sin(0.0 + 9 * pi / 8),
                    ),
                  ),
                  new Transform.translate(
                    child: Image(
                      image: AssetImage('assets/P1.png'),
                      fit: BoxFit.fill,
                    ),
                    offset: Offset(
                      radius * cos(-0.3 + 11 * pi / 8),
                      radius * sin(0.0 + 11 * pi / 8),
                    ),
                  ),
                  new Transform.translate(
                    child: Image(
                      image: AssetImage('assets/P8.png'),
                      fit: BoxFit.fill,
                    ),
                    offset: Offset(
                      radius * cos(0.0 + 13 * pi / 8),
                      radius * sin(0.0 + 13 * pi / 8),
                    ),
                  ),
                  new Transform.translate(
                    child: Image(
                      image: AssetImage('assets/P7.png'),
                      fit: BoxFit.fill,
                    ),
                    offset: Offset(
                      radius * cos(0.0 + 15 * pi / 8),
                      radius * sin(-0.3 + 15 * pi / 8),
                    ),
                  ),
                  new Transform.translate(
                    child: Image(
                      image: AssetImage('assets/P6.png'),
                      fit: BoxFit.fill,
                    ),
                    offset: Offset(
                      radius * cos(0.0 + 1 * pi / 8),
                      radius * sin(0.0 + 1 * pi / 8),
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

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
