import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../presentation/pages/home/home_page.dart';

enum NavigationPageData {
  home(HomePage(), "Home", true, null);

  final Widget page;
  final String title;
  final bool isShowMenu;
  final NavigationPageData? parent;

  const NavigationPageData(
    this.page,
    this.title,
    this.isShowMenu,
    this.parent,
  );
}

enum PeriodicData {
  daily('daily', 'Day'),
  weekly('weekly', 'Week'),
  monthly('monthly', 'Month'),
  yearly('yearly', 'Year'),
  dateTime(null, null),
  dateTime2(null, null),
  dateTime3(null, null),
  allDate(null, null),
  allTime(null, null);

  final String? value;
  final String? title;

  const PeriodicData(
    this.value,
    this.title,
  );
}

extension PeriodicDataExtension on PeriodicData {
  String? formatted(DateTime dateTime) {
    Locale locale = Get.locale!;
    String lang =
        '${locale.languageCode == 'jv' ? 'id' : locale.languageCode}_${locale.countryCode}';
    initializeDateFormatting(lang);
    switch (this) {
      case PeriodicData.daily:
        return DateFormat.yMMMMd(lang).format(dateTime);
      case PeriodicData.weekly:
        DateTime firstDayOfTheWeek = DateTime(dateTime.year, dateTime.month, dateTime.day)
            .subtract(Duration(days: dateTime.weekday - 1));
        DateTime lastDayOfTheWeek =
            DateTime(firstDayOfTheWeek.year, firstDayOfTheWeek.month, firstDayOfTheWeek.day + 6);
        String firstDayFormat = DateFormat.yMMMMd(lang).format(firstDayOfTheWeek);
        String lastDayFormat = DateFormat.yMMMMd(lang).format(lastDayOfTheWeek);
        return '$firstDayFormat - $lastDayFormat';
      case PeriodicData.monthly:
        return DateFormat.yMMMM(lang).format(dateTime);
      case PeriodicData.yearly:
        return DateFormat.y(lang).format(dateTime);
      case PeriodicData.dateTime:
        return DateFormat.yMMMMd(lang).addPattern("H:m:s").format(dateTime);
      case PeriodicData.dateTime2:
        return DateFormat('dd MMMM yyyy HH:mm', lang).format(dateTime);
      case PeriodicData.dateTime3:
        return DateFormat('EEEE, dd MMMM yyyy HH:mm', lang).format(dateTime);
      case PeriodicData.allDate:
        return DateFormat.yMMMMd(lang).format(dateTime);
      case PeriodicData.allTime:
        return DateFormat("H:m:s", lang).format(dateTime);
      default:
        return null;
    }
  }
}
