import 'package:flutter/material.dart';

class MyDetailsRow extends StatelessWidget {
  final String title;
  final String value;

  const MyDetailsRow({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Container(
              height: 60,
              width: 110,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              )),
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: Container(
            height: 60,
            width: 100,
            decoration: BoxDecoration(
              color: Color.fromRGBO(94, 71, 151, 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                value,
                style: TextStyle(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          )),
        ],
      ),
    );
  }
}
