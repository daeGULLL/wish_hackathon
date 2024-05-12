import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'dart:async';


void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GENIE',
      theme: ThemeData(

        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        fontFamily: "Pretendard",
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xC7BDB6FF)),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState(){
    super.initState();
    Future.delayed(const Duration(seconds: 2), () async {
      FlutterNativeSplash.remove();
    });}

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    final double AppWidth=MediaQuery.of(context).size.width;
    final double AppHeight = MediaQuery.of(context).size.height;
    return WillPopScope(onWillPop: ()async{return await showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(actionsPadding: EdgeInsets.zero,actionsAlignment: MainAxisAlignment.spaceEvenly,contentPadding: const EdgeInsets.only(top:40,bottom:30),
          content:const Text('앱을 종료하시겠습니까?',textAlign: TextAlign.center,softWrap: true,),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('확인'),
            ),
          ]);});}, child:Scaffold(backgroundColor: const Color(0xffE8E8E8),
      body: SingleChildScrollView(physics:const ClampingScrollPhysics(),child: SizedBox(width:AppWidth,child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height:AppHeight*0.03),
            Image.asset('assets/images/home_logo.png',height: AppHeight*0.11,width: AppHeight*0.11),
            SizedBox(height:AppHeight*0.03),
            const Text(
              'Li+mind와 함께해요!',style: TextStyle(fontWeight: FontWeight.w200, fontSize: 20),
            ),
            SizedBox(height:AppHeight*0.09),
            Image.asset('assets/images/home_rabbit.png',height: AppHeight*0.31),
            SizedBox(height:AppHeight*0.1),
            const Text(
              '시작하기 전에\n당신에 대해서 알려주세요!',textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
              //Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height:AppHeight*0.16),
            TextButton(
              style: TextButton.styleFrom(fixedSize:Size(AppWidth*0.71, AppHeight*0.06), //padding:EdgeInsets.symmetric(vertical: AppHeight*0.02),
                  foregroundColor: Colors.white, backgroundColor: const Color(0xff0A6847),
                  shape:RoundedRectangleBorder(side:const BorderSide(color: Color(0xff0A6847)),
                      borderRadius: BorderRadius.circular(100)),
                      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)
                  ),
              onPressed: () {
    Navigator.push(context, MaterialPageRoute(builder: (context) => survey()));
    },
              child: const Text('LET\'S GO →'),
            ),SizedBox(height:AppHeight*0.07)
          ],
        )),
      ),

    ));
  }
}

class survey extends StatefulWidget {
  const survey({super.key});

  @override
  State<survey> createState() => _surveyState();
}

class _surveyState extends State<survey> {
  late PageController _pageViewController;
  int _currentPageIndex = 0;
  var Qt=['1. 직업', '2. 사용 목적', '목표를 정해주세요.'];
  var Q=[['학생','대학(원)생','직장인','프리랜서','무직','기타'],
    ['규칙적인 생활', '일상 기록', '일상 분석', '목표 달성', '생산적인 삶', '기타'],
    ['규칙적인 식습관 가지기','충분한 수면하기','자기 계발 시간 늘리기', '    +']
  ];
  var R=[[0xffFFFFFF,0xffFFFFFF,0xffFFFFFF,0xffFFFFFF,0xffFFFFFF,0xffFFFFFF],
    [0xffFFFFFF,0xffFFFFFF,0xffFFFFFF,0xffFFFFFF,0xffFFFFFF,0xffFFFFFF],
  [0xffFFFFFF,0xffFFFFFF,0xffFFFFFF,0xffFFFFFF]
  ];
  String selected_s = "";
  bool selected=false;
  bool complete=false;
  bool endPage=false;
  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final double AppWidth=MediaQuery.of(context).size.width;
    final double AppHeight = MediaQuery.of(context).size.height;
    return Scaffold(backgroundColor: const Color(0xffE8E8E8),
      appBar: AppBar(backgroundColor:const Color(0xffE8E8E8),
        automaticallyImplyLeading: false,title:const Text('Li + mind'),actions: null,
        titleTextStyle: TextStyle(fontWeight: FontWeight.w200, fontSize: 20),),
    body: endPage?FutureBuilder(
        future: Future.delayed(const Duration(seconds: 2),()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>CalendarScreen()))),
    builder: (context, snapshot) {
    return Center(child:Column(mainAxisAlignment:MainAxisAlignment.center,
      children: [Image.asset(height:AppHeight*0.37,'assets/images/end_rabbit.png'),Text('수고하셨어요!\n',textAlign: TextAlign.center,
    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 25),),Text('답변을 토대로',textAlign: TextAlign.center,
      style: TextStyle(fontWeight: FontWeight.w300, fontSize: 25),),Text('데이터 정리중입니다.',textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.w300, fontSize: 25),),const SizedBox(height:20)],));}):Column(crossAxisAlignment:CrossAxisAlignment.start,
      //alignment: Alignment.bottomCenter,
      children: <Widget>[
        const Text('    당신에 대해 알려주세요!', style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700)),
        SizedBox(height: AppHeight*0.09),
        SizedBox(height:AppHeight*0.6,width:AppWidth,child:PageView.builder(
          /// [PageView.scrollDirection] defaults to [Axis.horizontal].
          /// Use [Axis.vertical] to scroll vertically.
          physics: NeverScrollableScrollPhysics(),
          controller: _pageViewController,
          itemCount: 3,
          itemBuilder: (c,ir){
            return Padding(padding: EdgeInsets.symmetric(horizontal: 10),child:Column(mainAxisAlignment:MainAxisAlignment.center,crossAxisAlignment:CrossAxisAlignment.start,children: [
              Text('  ${Qt[ir]}', style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300),),
              ListView.builder(
                shrinkWrap: true,
                itemCount: Q[ir].length,
                itemBuilder: (c, i){
                  return Padding(padding:EdgeInsets.symmetric(vertical:10, horizontal: 30),child:TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: Size.fromHeight(50),
                      foregroundColor: Colors.black,
                      backgroundColor: Color(R[ir][i]),
                    ),
                    onPressed: selected==true&&R[ir][i]==0xffFFFFFF? null : (){
                      setState(() {
                        R[ir][i]==0xffFFFFFF?R[ir][i]=0xffB5BCC3:R[ir][i]=0xffFFFFFF;
                        selected=!selected;
                        selected_s=Q[ir][i];
                      });
                    },child:Text(Q[ir][i])));
                },
              ),
            ]));
          },
        )),
        SizedBox(height: AppHeight*0.1),
        Container(alignment:Alignment.bottomRight,padding:const EdgeInsets.symmetric(horizontal: 10),
            child:complete?TextButton(style: TextButton.styleFrom(fixedSize:Size(AppWidth*0.06, AppHeight*0.06), //padding:EdgeInsets.symmetric(vertical: AppHeight*0.02),
                foregroundColor: Colors.white, backgroundColor: const Color(0xff0A6847),
                shape:RoundedRectangleBorder(side:const BorderSide(color: Color(0xff0A6847)),
                    borderRadius: BorderRadius.circular(100)),
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)
            ),onPressed: (){
             setState(() {
               endPage=true;
             });
            }, child: const Text('완료')) : IconButton(onPressed: selected?(){
              setState(() {
              _currentPageIndex<3?_currentPageIndex++ : null;
              selected=false;
              if(_currentPageIndex==2)complete=true;
              _pageViewController.jumpToPage(_currentPageIndex);
            });
            }:null, icon: const Icon(Icons.arrow_forward_ios_rounded)))]
    ));
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
      body: Column(crossAxisAlignment: CrossAxisAlignment.center,children:[
        TableCalendar(availableCalendarFormats: const {CalendarFormat.month : 'Month'},
          firstDay: DateTime.utc(2015, 2, 4),
          lastDay: DateTime.utc(2040, 2, 4),
          focusedDay: _focusedDay,
          calendarFormat: CalendarFormat.month,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
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
        SizedBox(height: 80), // 달력과 바 차트 사이의 간격 조정
        //바 차트
        Container(
          alignment: Alignment.center, // 바 차트를 가운데 정렬
          child: LinearPercentIndicator(
            alignment: MainAxisAlignment.center,
            width: MediaQuery.of(context).size.width - 50,
            animation: true,
            lineHeight: 20.0,
            animationDuration: 2500,
            percent: 0.8,
            center: Text("80.0%"),
            linearStrokeCap: LinearStrokeCap.roundAll,
            progressColor: Colors.green,
          ),
        ),
      ],
      ),
    );
  }

}