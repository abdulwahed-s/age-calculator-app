// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:hijri/hijri_calendar.dart';

class Hijry extends StatefulWidget {
  const Hijry({super.key});

  @override
  State<Hijry> createState() => _HijryState();
}

DateTime? date;
var as;
getdate() async {
  SharedPreferences sw = await SharedPreferences.getInstance();
  sw.setString("date", date!.toIso8601String());
}

class _HijryState extends State<Hijry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xff816797), actions: [
        Spacer(
          flex: 1,
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).pushReplacementNamed("milad");
          },
          child: Center(
            child: Text(
              "Gregorian calendar",
              style: TextStyle(fontFamily: 'Do', color: Color(0xffE7F6F2)),
            ),
          ),
        ),
        Spacer(),
        InkWell(
          onTap: () {},
          child: Center(
            child: Text(
              "التقويم الهجري",
              style: TextStyle(fontFamily: 'foda', color: Color(0xffE7F6F2)),
            ),
          ),
        ),
        Spacer()
      ]),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xff2C3333),
                    ),
                  )),
              Expanded(
                flex: 5,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xff395B64),
                  ),
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
                color: Color(0xffA5C9CA),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20)),
                border: Border(),
                boxShadow: [BoxShadow(blurRadius: 10)]),
            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
            height: 300,
            child: SfHijriDateRangePicker(
              selectionColor: Color.fromARGB(255, 0, 43, 87),
              todayHighlightColor: Color(0xff51557E),
              onSubmit: (p0) async {
                if (p0 == null) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('please select a date'),
                    duration: Duration(seconds: 1),
                  ));
                } else {
                  as = p0.toString();
                  List<String> parts = as.split('-');
                  int year = int.parse(parts[0]);
                  int month = int.parse(parts[1]);
                  int day = int.parse(parts[2]);
                  date = HijriCalendar().hijriToGregorian(year, month, day);
                  await getdate();
                  Navigator.of(context).pushNamed("ageh");
                }
              },
              showActionButtons: true,
            ),
          )
        ],
      ),
    );
  }
}
