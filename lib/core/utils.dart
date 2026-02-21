import 'package:calculator_agen/features/calculator/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';

List<String> classwork = ["Kelas 1", "Kelas 2", "Kelas 3", "Kelas 4"];

List<DropdownMenuItem<String>> buildAvailableFrequencyItems(
    FrequencyDiscount? freq) {
  if (freq == null) return [];

  final List<DropdownMenuItem<String>> items = [];

  items.add(const DropdownMenuItem(
    value: 'Monthly',
    child: Text('Bulanan (Monthly)'),
  ));

  if (freq.quarterly != null) {
    items.add(const DropdownMenuItem(
      value: 'Quarterly',
      child: Text('Triwulanan (Quarterly)'),
    ));
  }

  if (freq.semiAnnually != null) {
    items.add(const DropdownMenuItem(
      value: 'Semi Annually',
      child: Text('Semesteran (Semi Annually)'),
    ));
  }

  items.add(const DropdownMenuItem(
    value: 'Annually',
    child: Text('Tahunan (Annually)'),
  ));

  return items;
}
