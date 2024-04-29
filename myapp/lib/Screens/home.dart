// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:myapp/Screens/constant.dart';
import 'package:weather/weather.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WeatherFactory wf = WeatherFactory(OpenWHeatherApi);

  Weather? wheather;
  @override
  void initState() {
    super.initState();
    wf.currentWeatherByCityName('Islamabad').then((w) {
      setState(() {
        wheather = w;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: buildUI());
  }

  Widget buildUI() {
    if (wheather == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return SizedBox(
      height: MediaQuery.sizeOf(context).height,
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          locationHeader(),
          addVerticalSpaces(MediaQuery.sizeOf(context).height * 0.05),
          datetimeInfo(),
          addVerticalSpaces(MediaQuery.sizeOf(context).height * 0.05),
          wheatherIcon(),
          addVerticalSpaces(MediaQuery.sizeOf(context).height * 0.02),
          currenttemp(),
          addVerticalSpaces(MediaQuery.sizeOf(context).height * 0.02),
          ExtraInfo(),
        ],
      ),
    );
  }

  Widget locationHeader() {
    return Text(
      wheather?.areaName ?? '',
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
    );
  }

  Widget datetimeInfo() {
    DateTime now = wheather!.date!;
    return Column(
      children: [
        Text(
          DateFormat("h:mm a").format(now),
          style: TextStyle(fontSize: 30),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              DateFormat("EEEE").format(now),
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            Text(
              '${DateFormat(' d.m.y').format(now)}',
              style: TextStyle(fontWeight: FontWeight.w400),
            ),
          ],
        )
      ],
    );
  }

  Widget wheatherIcon() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.sizeOf(context).height * 0.20,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'http://openweathermap.org/img/wn/${wheather?.weatherIcon}@4x.png'))),
        ),
        Text(
          wheather?.weatherDescription ?? '',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ],
    );
  }

  Widget currenttemp() {
    return Text(
      '${wheather?.temperature?.celsius?.toStringAsFixed(0)}° C',
      style: TextStyle(
          color: Colors.black, fontSize: 90, fontWeight: FontWeight.w800),
    );
  }

  Widget ExtraInfo() {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.15,
      width: MediaQuery.sizeOf(context).width * 0.80,
      decoration: BoxDecoration(
        color: Colors.deepPurple,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.all(8.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Max: ${wheather?.tempMax?.celsius?.toStringAsFixed(0)}° C',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                Text(
                  'Mini: ${wheather?.tempMin?.celsius?.toStringAsFixed(0)}° C',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Wind: ${wheather?.windSpeed?.toStringAsFixed(0)}m/s',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                Text(
                  'Humidity: ${wheather?.humidity?.toStringAsFixed(0)} %',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                )
              ],
            ),
          ]),
    );
  }
}
