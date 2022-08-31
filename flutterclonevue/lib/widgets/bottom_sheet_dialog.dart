import 'package:flutter/material.dart';

BottomSheet ShowBottomSheet(text)
  {
      return BottomSheet(
        onClosing: () {
 
        },
        builder: (context) {
          return Container(
            height: 200,
            width: double.infinity,
            alignment: Alignment.center,
            child: Column(
              children: [
                Text(text),
                const SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Close"),
                ),
              ],
            ),
          );
        },
      );
  }