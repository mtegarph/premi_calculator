import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<bool> showFailureDialog(BuildContext context, String failure) async {
  return await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(failure),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  context.pop(); // Return true
                },
                child: const Text(
                  'Ok',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          );
        },
      ) ??
      false;
}
