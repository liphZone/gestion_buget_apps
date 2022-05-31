import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ChartScreen extends StatelessWidget {
  // const ChartWidget({ Key? key }) : super(key: key);

  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  final List mois = [
    "Jan",
    "Fev",
    "M",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    'December'
  ];

  final List money = [
    "Jan",
    "Fev",
    "M",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    'December'
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.indigo,
            borderRadius: BorderRadius.circular(10),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                  child: Text(
                    'Graphique des dépenses mensuelles',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
               
                Container(
                  margin: EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: LineChart(LineChartData(
                      minX: 0,
                      maxX: 10,
                      minY: 0,
                      maxY: 12,
                      // titlesData: LineTitles.getTitleData(),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 5,
                            getTitles: (value) {
                              switch (value.toInt()) {
                                case 2:
                                  return '500K';
                                case 4:
                                  return '1M';
                                  break;
                                case 6:
                                  return '1.5M';
                                  break;
                                case 8:
                                  return '2M';
                                  break;
                                case 10:
                                  return '2.5M';
                                  break;

                                default:
                              }
                              return '';
                            }),
                        rightTitles: SideTitles(),
                        topTitles: SideTitles(),
                        leftTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 35,
                            getTitles: (value) {
                                return  '${mois[value.toInt()]}';
                              return '';
                            
                              
                              // switch (value.toInt()) {
                              //   case 1:
                              //     return 'Janv';
                              //     break;
                              //   case 2:
                              //     return 'Fev';
                              //     break;
                              //   case 3:
                              //     return 'Mar';
                              //     break;
                              //   case 4:
                              //     return 'Avr';
                              //     break;
                              //   case 5:
                              //     return 'Mai';
                              //     break;
                              //   case 6:
                              //     return 'Juin';
                              //     break;
                              //   case 7:
                              //     return 'Jul';
                              //     break;
                              //   case 8:
                              //     return 'Aout';
                              //     break;
                              //   case 9:
                              //     return 'Sept';
                              //     break;
                              //   case 10:
                              //     return 'Oct';
                              //     break;
                              //   case 11:
                              //     return 'Nov';
                              //     break;
                              //   case 12:
                              //     return 'Dec';
                              //     break;

                              //   default:
                              // }
                            }),
                      ),
                      gridData: FlGridData(
                        show: true,
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                            color: const Color(0xff37434d),
                            strokeWidth: 1,
                          );
                        },
                        drawVerticalLine: true,
                        getDrawingVerticalLine: (value) {
                          return FlLine(
                            color: const Color(0xff37434d),
                            strokeWidth: 1,
                          );
                        },
                      ),
                      borderData: FlBorderData(
                          show: true,
                          border:
                              Border.all(color: Color(0xff37434d), width: 1)),
                      lineBarsData: [
                        LineChartBarData(
                          spots: [
                            FlSpot(0, 3),
                            FlSpot(2, 5),
                            FlSpot(2.3, 4),
                            FlSpot(4, 5),
                            FlSpot(6, 5.5),
                            FlSpot(8, 4),
                          ],
                          isCurved: true,
                          colors: gradientColors,
                          barWidth: 1,
                          belowBarData: BarAreaData(
                              show: true,
                              colors: gradientColors
                                  .map((e) => e.withOpacity(0.3))
                                  .toList()),
                        ),
                      ])),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
