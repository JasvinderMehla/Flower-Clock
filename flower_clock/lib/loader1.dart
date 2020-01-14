import "package:flutter/material.dart";
import 'dart:math';

class ColorLoader1 extends StatefulWidget {
  final double radius;

  ColorLoader1({this.radius = 90.0});

  @override
  _ColorLoader1State createState() => _ColorLoader1State();
}

class _ColorLoader1State extends State<ColorLoader1>
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
        duration: const Duration(milliseconds: 10070),
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
        curve: Interval(0.79, 1.0, curve: Curves.easeInCirc),
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
      end: 1.00,
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
                      image: AssetImage('assets/Center.png'),
                      fit: BoxFit.fill,
                    ),
                    offset: Offset(
                      (0.0),
                      (0.0),
                    ),
                  ),
                  new Transform.translate(
                    child: Image(
                      image: AssetImage('assets/petalr.png'),
                      fit: BoxFit.fill,
                    ),
                    offset: Offset(
                      radius * cos(0.0),
                      radius * sin(0.3),
                    ),
                  ),
                  new Transform.translate(
                    child: Image(
                      image: AssetImage('assets/petalrb.png'),
                      fit: BoxFit.fill,
                    ),
                    offset: Offset(
                      radius * cos(0.0 + 1 * pi / 4),
                      radius * sin(0.0 + 1 * pi / 4),
                    ),
                  ),
                  new Transform.translate(
                    child: Image(
                      image: AssetImage('assets/petalb.png'),
                      fit: BoxFit.fill,
                    ),
                    offset: Offset(
                      radius * cos(-0.3 + 2 * pi / 4),
                      radius * sin(0.0 + 2 * pi / 4),
                    ),
                  ),
                  new Transform.translate(
                    child: Image(
                      image: AssetImage('assets/petallb.png'),
                      fit: BoxFit.fill,
                    ),
                    offset: Offset(
                      radius * cos(0.0 + 3 * pi / 4),
                      radius * sin(0.0 + 3 * pi / 4),
                    ),
                  ),
                  new Transform.translate(
                    child: Image(
                      image: AssetImage('assets/petall.png'),
                      fit: BoxFit.fill,
                    ),
                    offset: Offset(
                      radius * cos(0.0 + 4 * pi / 4),
                      radius * sin(-0.3 + 4 * pi / 4),
                    ),
                  ),
                  new Transform.translate(
                    child: Image(
                      image: AssetImage('assets/petallt.png'),
                      fit: BoxFit.fill,
                    ),
                    offset: Offset(
                      radius * cos(0.0 + 5 * pi / 4),
                      radius * sin(0.0 + 5 * pi / 4),
                    ),
                  ),
                  new Transform.translate(
                    child: Image(
                      image: AssetImage('assets/petal.png'),
                      fit: BoxFit.fill,
                    ),
                    offset: Offset(
                      radius * cos(0.3 + 6 * pi / 4),
                      radius * sin(0.0 + 6 * pi / 4),
                    ),
                  ),
                  new Transform.translate(
                    child: Image(
                      image: AssetImage('assets/petalrt.png'),
                      fit: BoxFit.fill,
                    ),
                    offset: Offset(
                      radius * cos(0.0 + 7 * pi / 4),
                      radius * sin(0.0 + 7 * pi / 4),
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
