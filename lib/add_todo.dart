import 'package:flutter/material.dart';

class BottomSheetDummyUI extends StatelessWidget {
  const BottomSheetDummyUI({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(40, 20, 40, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'New Schedule',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            )
          )
        ]
      )
    );
  }
}

