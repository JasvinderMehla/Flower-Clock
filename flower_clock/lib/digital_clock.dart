// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'loader1.dart';
import 'loader2.dart';
import 'loader3.dart';
import 'package:flutter/services.dart';

enum _Element {
  background,
  text,
  shadow,
}

final _darkTheme = {
  _Element.background: Colors.black,
  _Element.text: Colors.white,
  _Element.shadow: Colors.deepOrange,
};

/// A basic digital clock.
///
/// You can do better than this!
class DigitalClock extends StatefulWidget {
  const DigitalClock(this.model);

  final ClockModel model;

  @override
  _DigitalClockState createState() => _DigitalClockState();
}

class _DigitalClockState extends State<DigitalClock> {
  DateTime _dateTime = DateTime.now();
  Timer _timer;
  final _daystyle = TextStyle(
    fontFamily: 'Alatsi',
    fontSize: 17,
    shadows: [Shadow(offset: Offset(0, 0), blurRadius: 0)],
  );
  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    _updateTime();
    _updateModel();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  void didUpdateWidget(DigitalClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    widget.model.dispose();
    super.dispose();
  }

  void _updateModel() {
    setState(() {
      // Cause the clock to rebuild when the model changes.
    });
  }

  void _updateTime() {
    setState(() {
      _dateTime = DateTime.now();
      // Update once per minute. If you want to update every second, use the
      // following code.
      _timer = Timer(
        Duration(minutes: 1) -
            Duration(seconds: _dateTime.second) -
            Duration(milliseconds: _dateTime.millisecond),
        _updateTime,
      );
      // Update once per second, but make sure to do it at the beginning of each
      // new second, so that the clock is accurate.
      // _timer = Timer(
      //   Duration(seconds: 1) - Duration(milliseconds: _dateTime.millisecond),
      //   _updateTime,
      // );
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).brightness == Brightness.light
        ? _darkTheme
        : _darkTheme; //force dark theme
    final hour =
        DateFormat(widget.model.is24HourFormat ? 'HH' : 'hh').format(_dateTime);
    final minute = DateFormat('mm').format(_dateTime);
    final day = DateFormat('EEEE').format(_dateTime);
    final fontSize = MediaQuery.of(context).size.width / 3.5;
    final offset = -fontSize / 7;
    final defaultStyle = TextStyle(
      color: colors[_Element.text],
      fontFamily: 'KosugiMaru',
      fontSize: 70,
      shadows: [
        Shadow(
          blurRadius: 5,
          color: colors[_Element.shadow],
          offset: Offset(5, 0),
        ),
      ],
    );
    return Container(
      color: colors[_Element.background],
      child: Center(
        child: AspectRatio(
          aspectRatio: 5 / 3,
          child: DefaultTextStyle(
            style: defaultStyle,
            child: Stack(alignment: Alignment.center, children: <Widget>[
              FittedBox(
                child: ColorLoader2(),
                fit: BoxFit.fitHeight,
              ),
              FittedBox(
                child: ColorLoader1(),
                fit: BoxFit.fitHeight,
              ),
              FittedBox(
                child: ColorLoader3(),
                fit: BoxFit.fitHeight,
              ),

              //Positioned(left: 20, top: 10,child: Text('$hour'':''$minute' ),),
              Positioned(
                child: Center(child: Text('$hour' ':' '$minute')),
              ),
              Positioned(
                bottom: 20,
                child: Center(child: Text('$day', style: _daystyle)),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
