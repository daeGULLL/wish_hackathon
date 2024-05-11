import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:percent_indicator/percent_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GENIE',
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      home: const CalendarScreen(),
    );
  }
}

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Li + Mind'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TableCalendar(
            availableCalendarFormats: const {CalendarFormat.month: 'Month'},
            firstDay: DateTime.utc(2015, 2, 4),
            lastDay: DateTime.utc(2040, 2, 4),
            focusedDay: _focusedDay,
            calendarFormat: CalendarFormat.month,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) => null,
              selectedBuilder: (context, day, focusedDay) {
                return Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.green[800],
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    day.day.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              },
              todayBuilder: (context, day, focusedDay) {
                return Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.green[300],
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    day.day.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 50), // Adjust spacing as needed
          Container(
            padding: EdgeInsets.all(15), // Set padding inside the container
            decoration: BoxDecoration(
              color: Colors.grey[300], // Light grey color
              borderRadius: BorderRadius.circular(25), // Rounded corners
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "   하루 돌아보기 성실도",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 10), // Spacing between text and bar
                LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width - 70, // Consider padding
                  animation: true,
                  lineHeight: 20.0,
                  animationDuration: 2500,
                  percent: 0.8,
                  center: Text("80.0%"),
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  progressColor: Colors.green,
                  barRadius: const Radius.circular(7),
                ),
              ],
            ),
          ),
          SizedBox(height: 22), // Space after the container
          Container(
            padding: EdgeInsets.all(15), // Set padding inside the container
            decoration: BoxDecoration(
              color: Colors.grey[300], // Light grey color
              borderRadius: BorderRadius.circular(25), // Rounded corners
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "   한 달 돌아보기 성실도",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 10), // Spacing between text and bar
                LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width - 70, // Consider padding
                  animation: true,
                  lineHeight: 20.0,
                  animationDuration: 2500,
                  percent: 0.8,
                  center: Text("80.0%"),
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  progressColor: Colors.green,
                  barRadius: const Radius.circular(7),
                ),
              ],
            ),
          ),
        ]
      ),
    );
  }
}
