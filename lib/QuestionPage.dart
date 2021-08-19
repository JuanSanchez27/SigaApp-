import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sigaweb_app/CovidSubmitPage.dart';
import 'package:sigaweb_app/DashboardPage.dart';

class QuestionPage extends StatefulWidget {
  static String id = 'QuestionPage';
  final Map<String, dynamic> datos;
  Map<String, dynamic> lista;

  QuestionPage(this.datos, this.lista);

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  GlobalKey<FormState> globalKey = new GlobalKey<FormState>();
  PageController pageController = new PageController();
  int pageChanged = 0;
  String selectedValue = '';
  bool value = false;
  List<dynamic> lista = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Encuesta COVID Diaria",
            style: TextStyle(
              color: Colors.teal.shade600,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: Container(
            child: Container(
              margin: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.teal.shade600,
                width: 2.0,),
              ),
              child: IconButton(
                icon: Icon(
                  FontAwesomeIcons.arrowLeft,
                  color: Colors.teal.shade600,
                ),
                onPressed: () {
                  var data = widget.datos;
                  Navigator.of(context).pop(
                      MaterialPageRoute(builder: (context) => DashboardPage(data)));
                },
              ),
            ),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Form(
                    key: globalKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          height: 600.0,
                          child: PageView.builder(
                            controller: pageController,
                            onPageChanged: (index) {
                              setState(() {
                                pageChanged = index;
                              });
                            },
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.lista['questions'].length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  Container(
                                    width: 300.0,
                                    child: Text(
                                      widget.lista['questions'][index]
                                          ['statement'],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: "Nunito",
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 70.0,
                                  ),
                                  Container(
                                    height: 430.0,
                                    width: 400.0,
                                    child: ListView.builder(
                                      itemCount: widget
                                          .lista['questions'][index]['answers']
                                          .length,
                                      itemBuilder:
                                          (BuildContext context, int preg) {
                                        if (widget.lista['questions'][index]
                                                ['selection_type'] ==
                                            'UNIQUE') {
                                          return Column(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.teal.shade100,
                                                    borderRadius: BorderRadius.circular(100.0)
                                                ),
                                                margin: EdgeInsets.all(10.0),
                                                child: RadioListTile(
                                                  value: widget.lista['questions']
                                                  [index]['answers'][preg]
                                                  ['statement']
                                                      .toString(),
                                                  groupValue: selectedValue,
                                                  controlAffinity:
                                                  ListTileControlAffinity
                                                      .leading,
                                                  activeColor:
                                                  Colors.teal.shade600,
                                                  title: Text(
                                                      widget.lista['questions']
                                                      [index]['answers']
                                                      [preg]['statement']),
                                                  onChanged: (val) =>
                                                      setState(() {
                                                        Map<String, dynamic> resp =
                                                        new Map();
                                                        selectedValue =
                                                        widget.lista['questions']
                                                        [index]['answers']
                                                        [preg]['statement'];
                                                        resp.addAll({
                                                          "id": widget
                                                              .lista['questions']
                                                          [index]['id'],
                                                          "responses": [
                                                            widget.lista['questions']
                                                            [index]['answers']
                                                            [preg]['id']
                                                          ],
                                                        });
                                                        lista.add(resp);
                                                      }),
                                                  //acá va la configuracion del color
                                                ),
                                              ),
                                            ],
                                          );
                                        } else {
                                          return Column(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.teal.shade100,
                                                  borderRadius: BorderRadius.circular(100.0)
                                                ),
                                                margin: EdgeInsets.all(10.0),
                                                child: CheckboxListTile(
                                                  controlAffinity:
                                                  ListTileControlAffinity
                                                      .leading,
                                                  activeColor:
                                                  Colors.teal.shade600,
                                                  title: Text(
                                                      widget.lista['questions']
                                                      [index]['answers']
                                                      [preg]['statement']),
                                                  value: widget.lista['questions']
                                                  [index]['answers'][preg]
                                                  ['correct'],
                                                  onChanged: (value) =>
                                                      setState(() {
                                                        Map<String, dynamic> resp =
                                                        new Map();
                                                        widget.lista['questions']
                                                        [index]['answers']
                                                        [preg]['correct'] = value;
                                                        resp.addAll({
                                                          "id": widget
                                                              .lista['questions']
                                                          [index]['id'],
                                                          "responses": [
                                                            widget.lista['questions']
                                                            [index]['answers']
                                                            [preg]['id']
                                                          ],
                                                        });
                                                        lista.add(resp);
                                                      }),
                                                ),
                                              ),
                                            ],
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: IconButton(
                        icon: Icon(
                          FontAwesomeIcons.arrowAltCircleLeft,
                          color: Colors.teal.shade600,
                          size: 30.0,
                        ),
                        onPressed: () {
                          pageController.animateToPage(
                            pageChanged = pageChanged - 1,
                            duration: Duration(milliseconds: 250),
                            curve: Curves.bounceOut,
                          );
                          if (pageChanged <= 0) {
                            pageChanged = 0;
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      child: IconButton(
                        icon: Icon(
                          FontAwesomeIcons.arrowAltCircleRight,
                          color: Colors.teal.shade600,
                          size: 30.0,
                        ),
                        onPressed: () {
                          pageController.animateToPage(
                            pageChanged = pageChanged + 1,
                            duration: Duration(milliseconds: 250),
                            curve: Curves.bounceIn,
                          );
                          if (pageChanged == widget.lista['questions'].length) {
                            pageChanged = widget.lista['questions'].length - 1;
                            var data = widget.datos;
                            var list = lista;
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CovidSubmitPage(data, list),
                            ));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
