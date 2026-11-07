import 'package:flutter/material.dart';

enum Mood {
  amazing('Amazing', '😄', Color(0xFFFFD166), 'Full of energy'),
  good('Good', '🙂', Color(0xFF9BCF9B), 'Feeling positive'),
  okay('Okay', '😐', Color(0xFFA8C5D8), 'Taking it as it comes'),
  low('Low', '😔', Color(0xFFB9A7D5), 'A little cloudy'),
  stressed('Stressed', '😣', Color(0xFFE9A58F), 'Need a breather');

  const Mood(this.label, this.emoji, this.color, this.subtitle);
  final String label;
  final String emoji;
  final Color color;
  final String subtitle;
}

class MoodEntry {
  const MoodEntry({
    required this.date,
    required this.mood,
    required this.note,
  });

  final DateTime date;
  final Mood mood;
  final String note;
}
