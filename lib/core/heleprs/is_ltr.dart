import 'package:comment_management/core/globals.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

bool isLTR() {
  BuildContext? context = navigatorKey.currentContext;
  if (context == null) return true;
  return context.locale.languageCode != 'ar';
}
