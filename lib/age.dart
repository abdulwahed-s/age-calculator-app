// ignore_for_file: unused_local_variable, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:age/milad.dart';
import 'package:animated_background/animated_background.dart';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hijri/hijri_array.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:age_calculator/age_calculator.dart';
import 'package:intl/intl.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:random_text_reveal/random_text_reveal.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Hell extends StatefulWidget {
  const Hell({super.key});

  @override
  State<Hell> createState() => _HellState();
}

DateDuration? duration;
DateTime? birth;
int? hy;
int? hm;
var min;
var sec;
var hours;
int? hd;
var dayyy;
var secs;
const colorizeColors = [
  Color(0xff072541),
  ui.Color.fromARGB(255, 255, 0, 191),
  Color.fromARGB(255, 255, 255, 255),
  ui.Color.fromARGB(255, 249, 186, 255),
  ui.Color.fromARGB(255, 0, 68, 73)
];

DateTime myS = DateTime(2005, 12, 17);

class _HellState extends State<Hell> with TickerProviderStateMixin {
  String? _ageResult;
  String? hijage;
  @override
  void initState() {
    getSavedDateTime();
    Timer.periodic(Duration(seconds: 1), (Timer t) {
      fun();
      te();
    });

    super.initState();
  }

  Future<DateTime?> getSavedDateTime() async {
    final prefs = await SharedPreferences.getInstance();
    final dateTimeString = prefs.getString('date');
    birth = DateTime.parse(dateTimeString!);
    print(birth);
    return null;
  }

  void fun() async {
    final prefs = await SharedPreferences.getInstance();
    final dateTimeString = prefs.getString('date');
    birth = DateTime.parse(dateTimeString!);
    //  print(birth);
    // var h_date = HijriCalendar.fromDate(birth!);
    // print(h_date);
    duration = AgeCalculator.age(birth!);
    final now = DateTime.now();
    final diff = now.difference(birth!);
    dayyy = diff.inDays;
    secs = diff.inSeconds;
    hours = diff.inHours;
    final year = diff.inDays ~/ 365;
    final month = (diff.inDays % 365) ~/ 30;
    final days = ((diff.inDays % 365) % 30);
    min = diff.inMinutes % 60;
    sec = diff.inSeconds % 60;
    List<String> components = HijriCalendar.now().toString().split('/');
    int hdaysn = int.tryParse(components[0]) ?? 0;
    int hmonthn = int.tryParse(components[1]) ?? 0;
    int hyearn = int.tryParse(components[2]) ?? 0;

    List<String> hcomponents =
        HijriCalendar.fromDate(birth!).toString().split('/');
    int hdays = int.tryParse(hcomponents[0]) ?? 0;
    int hmonth = int.tryParse(hcomponents[1]) ?? 0;
    int hyear = int.tryParse(hcomponents[2]) ?? 0;
    int tst = hmonthn - hmonth;
    int dt = hdaysn - hdays;
    if (tst >= 0) {
      hy = hyearn - hyear;
    } else if (tst < 0) {
      hy = (hyearn - hyear) - 1;
    }
    if (tst < 0) {
      hm = 12 - tst.abs();
    } else if (tst > 0) {
      hm = tst;
    } else if (tst == 0) {
      hm = 0;
    }
    if (dt > 0) {
      hd = dt;
    } else if (dt < 0) {
      hd = 30 - dt.abs();
    } else if (dt == 0) {
      hd = 0;
    }
    setState(() {
      _ageResult = "$duration, Minutes: $min, Seconds: $sec";
      hijage = "Years : $hy , Months : $hm, days : $hd";
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //  appBar: AppBar(),
        body: _ageResult == null
            ? Center(
                child: SpinKitWaveSpinner(
                color: Color(0xff816797),
                waveColor: Color(0xff51557E),
                trackColor: Color(0xff1B2430),
                size: 100,
              ))
            : Stack(
                children: [
                  Container(color: Color(0xffAEDEFC)),
                  AnimatedBackground(
                    behaviour: duration!.months == 0 &&
                            duration!.days == 0 &&
                            birth == myS
                        ? RacingLinesBehaviour(direction: LineDirection.Ttb)
                        : duration!.months == 0 && duration!.days == 0
                            ? RandomParticleBehaviour(
                                options: ParticleOptions(
                                    image: Image.asset("assets/bb.png"),
                                    spawnMinSpeed: 10,
                                    spawnMaxRadius: 50,
                                    spawnOpacity: 0.6,
                                    spawnMaxSpeed: 100,
                                    particleCount: 50,
                                    minOpacity: 0.7,
                                    maxOpacity: 1))
                            : birth == myS
                                ? RandomParticleBehaviour(
                                options: ParticleOptions(
                                    image: Image.asset("assets/hs.png"),
                                    spawnMinSpeed: 5,
                                    spawnMaxRadius: 13,
                                    spawnOpacity: 0.6,
                                    spawnMaxSpeed: 100,
                                    particleCount: 200,
                                    minOpacity: 0.7,
                                    maxOpacity: 1))
                                : EmptyBehaviour(),
                    vsync: this,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Spacer(
                          flex: 5,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 7),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "your age in different ways :",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Color(0xff072541),
                                    fontSize: 20,
                                    fontFamily: "Th",
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "in seconds: $secs",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Color(0xff072541),
                                    fontSize: 20,
                                    fontFamily: "Th",
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "in hours: $hours",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Color(0xff072541),
                                    fontSize: 20,
                                    fontFamily: "Th",
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "in day: $dayyy",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Color(0xff072541),
                                    fontSize: 20,
                                    fontFamily: "Th",
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "in months: ${duration!.years == 0 ? duration!.months : (duration!.years * 12)}",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Color(0xff072541),
                                    fontSize: 20,
                                    fontFamily: "Th",
                                    fontWeight: FontWeight.bold),
                              ),
                              Divider(
                                thickness: 1,
                                color: Color.fromARGB(255, 66, 25, 42),
                                height: 20,
                              ),
                              Text(
                                "You were born in: ${birth?.year}/${birth?.month}/${birth?.day}",
                                style: TextStyle(
                                    color: Color(0xff072541),
                                    fontSize: 20,
                                    fontFamily: "Th",
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "You were born in(hijri) ${HijriCalendar.fromDate(birth!).hYear}/${HijriCalendar.fromDate(birth!).longMonthName}/${HijriCalendar.fromDate(birth!).hDay}",
                                style: TextStyle(
                                    color: Color(0xff072541),
                                    fontSize: 20,
                                    fontFamily: "Th",
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "the day you were born in is ${DateFormat('EEEE').format(birth!)}",
                                style: TextStyle(
                                    color: Color(0xff072541),
                                    fontSize: 20,
                                    fontFamily: "Th",
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 1,
                          height: 20,
                          color: Color.fromARGB(255, 66, 25, 42),
                        ),
                        Container(
                            child: duration!.months == 0 &&
                                    duration!.days == 0 &&
                                    birth == myS
                                ? RandomTextReveal(
                                    text:
                                        "today is your day,maybe I am not here,maybe I will not send you messages.\nBut I will always love you,enjoy your day siriniiii",
                                    duration: Duration(seconds: 30),
                                    style: TextStyle(
                                        color:
                                            ui.Color.fromARGB(255, 0, 68, 73),
                                        fontSize: 20,
                                        fontFamily: "Sw",
                                        fontWeight: FontWeight.bold),
                                    curve: Curves.easeIn,
                                  )
                                : duration!.months == 0 && duration!.days == 0
                                    ? Text(
                                        "in this day before ${duration!.years} years you were born , just remember to use every second of your life to do good.\nIn the end, it’s not the years in your life that count. It’s the life in your years.",
                                        style: TextStyle(
                                            color: Color(0xff072541),
                                            fontSize: 20,
                                            fontFamily: "Th",
                                            fontWeight: FontWeight.bold),
                                      )
                                    : birth == myS
                                        ? Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                " till that day come",
                                                style: TextStyle(
                                                    color: ui.Color.fromARGB(
                                                        255, 0, 68, 73),
                                                    fontSize: 20,
                                                    fontFamily: "Sw",
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                " I want you to know that",
                                                style: TextStyle(
                                                    color: ui.Color.fromARGB(
                                                        255, 0, 68, 73),
                                                    fontSize: 20,
                                                    fontFamily: "Sw",
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              AnimatedTextKit(
                                                animatedTexts: [
                                                  TyperAnimatedText(
                                                    " I love you",
                                                    textStyle: TextStyle(
                                                        color:
                                                            ui.Color.fromARGB(
                                                                255, 0, 68, 73),
                                                        fontSize: 20,
                                                        fontFamily: "Sw",
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  TyperAnimatedText(
                                                    " Te amo",
                                                    textStyle: TextStyle(
                                                        color:
                                                            ui.Color.fromARGB(
                                                                255, 0, 68, 73),
                                                        fontSize: 20,
                                                        fontFamily: "Sw",
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  TyperAnimatedText(
                                                    " Je t'aime",
                                                    textStyle: TextStyle(
                                                        color:
                                                            ui.Color.fromARGB(
                                                                255, 0, 68, 73),
                                                        fontSize: 20,
                                                        fontFamily: "Sw",
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  TyperAnimatedText(
                                                    " Seni seviyorum",
                                                    textStyle: TextStyle(
                                                        color:
                                                            ui.Color.fromARGB(
                                                                255, 0, 68, 73),
                                                        fontSize: 20,
                                                        fontFamily: "Sw",
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  TyperAnimatedText(
                                                    " Я тебя люблю",
                                                    textStyle: TextStyle(
                                                        color:
                                                            ui.Color.fromARGB(
                                                                255, 0, 68, 73),
                                                        fontSize: 20,
                                                        fontFamily: "Sw",
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                                repeatForever: true,
                                              ),
                                              AnimatedTextKit(
                                                animatedTexts: [
                                                  ColorizeAnimatedText(
                                                    " and I will, forever~♡.",
                                                    textStyle: TextStyle(
                                                        color:
                                                            Color(0xff816797),
                                                        fontSize: 20,
                                                        fontFamily: "Sw",
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    colors: colorizeColors,
                                                  ),
                                                ],
                                                isRepeatingAnimation: true,
                                                repeatForever: true,
                                              ),
                                            ],
                                          )
                                        : null),
                        Divider(
                          thickness: 1,
                          height: duration!.months == 0 && duration!.days == 0
                              ? 20
                              : birth == myS
                                  ? 20
                                  : duration!.months == 0 &&
                                          duration!.days == 0 &&
                                          birth == myS
                                      ? 20
                                      : 0,
                          color: duration!.months == 0 && duration!.days == 0
                              ? const Color.fromARGB(255, 66, 25, 42)
                              : birth == myS
                                  ? const Color.fromARGB(255, 66, 25, 42)
                                  : duration!.months == 0 &&
                                          duration!.days == 0 &&
                                          birth == myS
                                      ? const Color.fromARGB(255, 66, 25, 42)
                                      : Color.fromARGB(0, 0, 0, 0),
                        ),
                        duration!.months == 0 && duration!.days == 0
                            ? Spacer(
                                flex: 1,
                              )
                            : duration!.months == 0 &&
                                    duration!.days == 0 &&
                                    birth == myS
                                ? Spacer(
                                    flex: 100,
                                  )
                                : birth == myS
                                    ? Spacer(
                                        flex: 100,
                                      )
                                    : Spacer(
                                        flex: 10,
                                      ),
                        Center(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            height: 100,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(20),
                                    topLeft: Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(5, 3), blurRadius: 14)
                                ],
                                color: Color(0xffF875AA)),
                            child: Column(
                              children: [
                                Text("youar age is (gregorian)",
                                    style: TextStyle(
                                        color: Color(0xffFFDFDF),
                                        fontSize: 20,
                                        fontFamily: "Th",
                                        fontWeight: FontWeight.bold)),
                                Spacer(),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            "${duration!.years} ",
                                            style: TextStyle(
                                                color: Color(0xffFFDFDF),
                                                fontSize: 20,
                                                fontFamily: "Th",
                                                fontWeight: FontWeight.bold),
                                          ),
                                          duration!.years <= 1
                                              ? Text("year",
                                                  style: TextStyle(
                                                      color: Color(0xffFFDFDF),
                                                      fontSize: 20,
                                                      fontFamily: "Th",
                                                      fontWeight:
                                                          FontWeight.bold))
                                              : Text("years",
                                                  style: TextStyle(
                                                      color: Color(0xffFFDFDF),
                                                      fontSize: 20,
                                                      fontFamily: "Th",
                                                      fontWeight:
                                                          FontWeight.bold))
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            "${duration!.months} ",
                                            style: TextStyle(
                                                color: Color(0xffFFDFDF),
                                                fontSize: 20,
                                                fontFamily: "Th",
                                                fontWeight: FontWeight.bold),
                                          ),
                                          duration!.months <= 1
                                              ? Text("month",
                                                  style: TextStyle(
                                                      color: Color(0xffFFDFDF),
                                                      fontSize: 20,
                                                      fontFamily: "Th",
                                                      fontWeight:
                                                          FontWeight.bold))
                                              : Text("months",
                                                  style: TextStyle(
                                                      color: Color(0xffFFDFDF),
                                                      fontSize: 20,
                                                      fontFamily: "Th",
                                                      fontWeight:
                                                          FontWeight.bold))
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            "${duration!.days} ",
                                            style: TextStyle(
                                                color: Color(0xffFFDFDF),
                                                fontSize: 20,
                                                fontFamily: "Th",
                                                fontWeight: FontWeight.bold),
                                          ),
                                          duration!.days <= 1
                                              ? Text("day",
                                                  style: TextStyle(
                                                      color: Color(0xffFFDFDF),
                                                      fontSize: 20,
                                                      fontFamily: "Th",
                                                      fontWeight:
                                                          FontWeight.bold))
                                              : Text("days",
                                                  style: TextStyle(
                                                      color: Color(0xffFFDFDF),
                                                      fontSize: 20,
                                                      fontFamily: "Th",
                                                      fontWeight:
                                                          FontWeight.bold))
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            "$min ",
                                            style: TextStyle(
                                                color: Color(0xffFFDFDF),
                                                fontSize: 20,
                                                fontFamily: "Th",
                                                fontWeight: FontWeight.bold),
                                          ),
                                          min <= 1
                                              ? Text("minute",
                                                  style: TextStyle(
                                                      color: Color(0xffFFDFDF),
                                                      fontSize: 20,
                                                      fontFamily: "Th",
                                                      fontWeight:
                                                          FontWeight.bold))
                                              : Text("minutes",
                                                  style: TextStyle(
                                                      color: Color(0xffFFDFDF),
                                                      fontSize: 20,
                                                      fontFamily: "Th",
                                                      fontWeight:
                                                          FontWeight.bold))
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            "$sec ",
                                            style: TextStyle(
                                                color: Color(0xffFFDFDF),
                                                fontSize: 20,
                                                fontFamily: "Th",
                                                fontWeight: FontWeight.bold),
                                          ),
                                          sec <= 1
                                              ? Text("second",
                                                  style: TextStyle(
                                                      color: Color(0xffFFDFDF),
                                                      fontSize: 20,
                                                      fontFamily: "Th",
                                                      fontWeight:
                                                          FontWeight.bold))
                                              : Text("seconds",
                                                  style: TextStyle(
                                                      color: Color(0xffFFDFDF),
                                                      fontSize: 20,
                                                      fontFamily: "Th",
                                                      fontWeight:
                                                          FontWeight.bold))
                                        ],
                                      ),
                                    ]),
                                Spacer()
                              ],
                            ),
                          ),
                        ),
                        duration!.months == 0 && duration!.days == 0
                            ? Spacer()
                            : duration!.months == 0 &&
                                    duration!.days == 0 &&
                                    birth == myS
                                ? Spacer()
                                : birth == myS
                                    ? Spacer()
                                    : Spacer(
                                        flex: 5,
                                      ),
                        Center(
                          child: Container(
                            height: 100,
                            width: double.infinity,
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(20),
                                  topLeft: Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(offset: Offset(5, 3), blurRadius: 14)
                              ],
                              color: Color(0xffF875AA),
                            ),
                            child: Column(
                              children: [
                                Text("Your age is (hijri)",
                                    style: TextStyle(
                                        color: Color(0xffFFDFDF),
                                        fontSize: 20,
                                        fontFamily: "Th",
                                        fontWeight: FontWeight.bold)),
                                Spacer(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          "$hy ",
                                          style: TextStyle(
                                              color: Color(0xffFFDFDF),
                                              fontSize: 20,
                                              fontFamily: "Th",
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(hy! > 1 ? "years" : "year",
                                            style: TextStyle(
                                                color: Color(0xffFFDFDF),
                                                fontSize: 20,
                                                fontFamily: "Th",
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "$hm ",
                                          style: TextStyle(
                                              color: Color(0xffFFDFDF),
                                              fontSize: 20,
                                              fontFamily: "Th",
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(hm! > 1 ? "months" : "month",
                                            style: TextStyle(
                                                color: Color(0xffFFDFDF),
                                                fontSize: 20,
                                                fontFamily: "Th",
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "$hd ",
                                          style: TextStyle(
                                              color: Color(0xffFFDFDF),
                                              fontSize: 20,
                                              fontFamily: "Th",
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(hd! > 1 ? "days" : "day",
                                            style: TextStyle(
                                                color: Color(0xffFFDFDF),
                                                fontSize: 20,
                                                fontFamily: "Th",
                                                fontWeight: FontWeight.bold))
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Spacer(
                          flex: 10,
                        )
                      ],
                    ),
                  ),
                ],
              ));
  }
}
te(){
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.bottom]
  );
}