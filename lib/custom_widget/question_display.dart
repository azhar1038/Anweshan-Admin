import 'package:flutter/material.dart';

class QuestionDisplay extends StatelessWidget {
  final String question, opt1, opt2, opt3, opt4, url;
  final int answer;

  QuestionDisplay({
    @required this.question,
    @required this.opt1,
    @required this.opt2,
    @required this.opt3,
    @required this.opt4,
    @required this.answer,
    this.url,
  }) : assert(answer > 0 && answer < 5);

  Widget _getImage(String url){
    if(url == null || url.isEmpty){
      return Container();
    }else{
      return Image.network(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Q) $question',
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: _getImage(url),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: answer == 1 ? Colors.green : Colors.blue,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.transparent,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    opt1,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: answer == 2 ? Colors.green : Colors.blue,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.transparent,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    opt2,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: answer == 3 ? Colors.green : Colors.blue,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.transparent,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    opt3,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: answer == 4 ? Colors.green : Colors.blue,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.transparent,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    opt4,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
