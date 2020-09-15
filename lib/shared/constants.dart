import 'package:flutter/material.dart';

InputDecoration textInputDecoration = InputDecoration(
  contentPadding: const EdgeInsets.only(
      left: 14.0, bottom: 8.0, top: 8.0),
  filled: true,
  fillColor: Colors.white,
  enabledBorder: UnderlineInputBorder(
    borderSide: new BorderSide(color: Colors.white),
    borderRadius: new BorderRadius.circular(25.7),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: new BorderSide(color: Colors.white),
    borderRadius: new BorderRadius.circular(25.7),
  ),

  errorStyle: TextStyle(color: Colors.yellow),
);