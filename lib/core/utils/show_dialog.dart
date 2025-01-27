import 'package:flutter/material.dart';

void showDeleteConfirmationDialog(
    BuildContext context, void Function() onYesPressed) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirm Deletion'),
        content: const Text('Are you sure you want to delete this category?'),
        actions: <Widget>[
          TextButton(
            child: const Text('No'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Yes'),
            onPressed: () {
              onYesPressed();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
