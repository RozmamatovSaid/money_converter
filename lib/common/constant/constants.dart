import 'package:flutter/material.dart';

sealed class Constants {
  static const String projectId = '96d5b3ba-54ae-442c-8c15-f751741c3c6a';
  static const String environmentId = '901be318-804b-4277-9ab7-b2122b8a3698';
  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);
  static const Curve curve = Curves.easeInOut;
  static const Duration transitionDuration = Duration(milliseconds: 300);
}
