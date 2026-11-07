
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/mood_entry.dart';

class GardenScreen extends StatefulWidget {
  const GardenScreen({super.key, required this.entries});

  final List<MoodEntry> entries;

  @override
  State<GardenScreen> createState() => _GardenScreenState();
}

class _GardenScreenState extends State<GardenScreen> {
  static const Color ink = Color(0xFF493744);
  static const Color green = Color(0xFF55765F);
  static const Color paleGreen = Color(0xFFE8EFE3);
  static const String _storageKey = 'moodbloom_garden_care_v1';

  // Each plant stores the indexes of its completed tasks.
  final Map<String, Set<int>> _completedTasks = {};
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_storageKey);

      if (raw != null) {
        final decoded = jsonDecode(raw) as Map<String, dynamic>;

        for (final item in decoded.entries) {
          final values = (item.value as List)
              .map((value) => (value as num).toInt())
              .toSet();
          _completedTasks[item.key] = values;
        }
      }
    } catch (_) {
      // If saved data cannot be read, the garden still opens safely.
    }

    if (mounted) {
      setState(() => _loading = false);
    }
  }

  Future<void> _saveProgress() async {
    final prefs = await SharedPreferences.getInstance();

    final data = _completedTasks.map(
      (key, value) => MapEntry(key, value.toList()),
    );

    await prefs.setString(_storageKey, jsonEncode(data));
  }

  String _plantId(MoodEntry entry) =>
      entry.date.microsecondsSinceEpoch.toString();

  List<String> _tasksFor(Mood mood) {
    switch (mood) {
      case Mood.amazing:
      case Mood.good:
        return [
          'Take a moment to enjoy something you love ☀️',
          'Share a kind word with someone 💗',
          'Write down one thing you are grateful for 🌼',
        ];

      case Mood.okay:
        return [
          'Take a few slow, deep breaths 🌿',
          'Stretch or walk around for five minutes 🚶',
          'Do one small thing you have been putting off 🌷',
        ];

      case Mood.low:
        return [
          'Drink a glass of water 💧',
          'Get a little fresh air or sunlight ☀️',
          'Give yourself a kind, encouraging thought 💗',
        ];

      case Mood.stressed:
        return [
          'Pause and take five slow breaths 🌬️',
          'Step away from your screen for a moment 🌱',
          'Write down what is on your mind, if you want to 💌',
        ];
    }
  }

  String _plantEmoji(MoodEntry entry, int completed) {
    final difficultMood =
        entry.mood == Mood.low || entry.mood == Mood.stressed;

    if (completed >= 3) return '🌸';
    if (completed == 2) return '🌿';
    if (completed == 1) return '🌱';

    return difficultMood ? '🥀' : '🌰';
  }

  String _plantStage(int completed) {
    if (completed >= 3) return 'In full bloom';
    if (completed == 2) return 'Growing happily';
    if (completed == 1) return 'A little sprout';
    return 'Waiting for a little care';
  }

  Color _plantColor(Mood mood) {
    switch (mood) {
      case Mood.amazing:
        return const Color(0xFFFFF0C9);
      case Mood.good:
        return const Color(0xFFE2EFD9);
      case Mood.okay:
        return const Color(0xFFE4EDF3);
      case Mood.low:
        return const Color(0xFFECE5F5);
      case Mood.stressed:
        return const Color(0xFFF8E5DF);
    }
  }

  Future<void> _toggleTask(
    String plantId,
    int taskIndex,
    bool checked,
  ) async {
    setState(() {
      final tasks = _completedTasks.putIfAbsent(plantId, () => <int>{});

      if (checked) {
        tasks.add(taskIndex);
      } else {
        tasks.remove(taskIndex);
      }
    });

    await _saveProgress();
  }

  Widget _sunshine() {
    final positive = widget.entries
        .where((entry) =>
            entry.mood == Mood.amazing || entry.mood == Mood.good)
        .length;

    final total = widget.entries.length;
    final ratio = total == 0 ? 0.0 : positive / total;

    final face = total == 0
        ? '☺️'
        : ratio >= 0.7
            ? '😄'
            : ratio >= 0.4
                ? '🙂'
                : '🌤️';

    final brightness = 0.45 + (ratio * 0.55);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFF1C9), Color(0xFFFFF8E8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          Opacity(
            opacity: brightness,
            child: const Text('☀️', style: TextStyle(fontSize: 57)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(face, style: const TextStyle(fontSize: 23)),
                const SizedBox(height: 4),
                const Text(
                  'Your little sunshine',
                  style: TextStyle(
                    color: Color(0xFF755B36),
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  total == 0
                      ? 'Your garden is waiting for its first little seed.'
                      : 'Every feeling has a place in your garden.',
                  style: const TextStyle(
                    color: Color(0xFF8D7755),
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _plantCard(MoodEntry entry, int index) {
    final id = _plantId(entry);
    final completed = _completedTasks[id] ?? <int>{};
    final tasks = _tasksFor(entry.mood);
    final color = _plantColor(entry.mood);
    final allDone = completed.length == tasks.length;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(23),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 76,
                height: 76,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(21),
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 350),
                  child: Text(
                    _plantEmoji(entry, completed.length),
                    key: ValueKey(completed.length),
                    style: const TextStyle(fontSize: 43),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Little plant #${index + 1}',
                      style: const TextStyle(
                        color: ink,
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${entry.mood.emoji} ${entry.mood.label} day',
                      style: const TextStyle(
                        color: Color(0xFF796979),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      _plantStage(completed.length),
                      style: const TextStyle(
                        color: green,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Little care steps',
                style: TextStyle(
                  color: ink,
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                ),
              ),
              Text(
                '${completed.length}/${tasks.length}',
                style: const TextStyle(
                  color: green,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: completed.length / tasks.length,
              minHeight: 7,
              backgroundColor: Colors.white,
              color: const Color(0xFF91B58B),
            ),
          ),
          const SizedBox(height: 10),
          ...List.generate(tasks.length, (taskIndex) {
            final isDone = completed.contains(taskIndex);

            return CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: green,
              value: isDone,
              title: Text(
                tasks[taskIndex],
                style: TextStyle(
                  fontSize: 12,
                  color: ink,
                  decoration:
                      isDone ? TextDecoration.lineThrough : null,
                ),
              ),
              onChanged: (value) => _toggleTask(
                id,
                taskIndex,
                value ?? false,
              ),
            );
          }),
          if (allDone)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(11),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.65),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Text(
                'You did it! Your little plant is blooming. 🌸',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: green,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final entries = [...widget.entries]
      ..sort((a, b) => a.date.compareTo(b.date));

    return ListView(
      padding: const EdgeInsets.fromLTRB(22, 24, 22, 32),
      children: [
        const Text(
          'My little garden 🌷',
          style: TextStyle(
            fontSize: 29,
            fontWeight: FontWeight.w900,
            color: ink,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'A little space where every feeling can grow.',
          style: TextStyle(color: Colors.black54),
        ),
        const SizedBox(height: 20),
        _sunshine(),
        const SizedBox(height: 23),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Your growing garden',
              style: TextStyle(
                color: ink,
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              '${entries.length} plants',
              style: const TextStyle(
                color: green,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(height: 13),
        if (_loading)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(35),
              child: CircularProgressIndicator(color: green),
            ),
          )
        else if (entries.isEmpty)
          Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: paleGreen,
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Column(
              children: [
                Text('🪴', style: TextStyle(fontSize: 55)),
                SizedBox(height: 12),
                Text(
                  'Your garden is waiting!',
                  style: TextStyle(
                    color: ink,
                    fontWeight: FontWeight.w900,
                    fontSize: 17,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Complete your first mood check-in to plant a little seed.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black54,
                    height: 1.5,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          )
        else
          ...List.generate(
            entries.length,
            (index) => _plantCard(entries[index], index),
          ),
        const SizedBox(height: 8),
        const Center(
          child: Text(
            'Remember: you deserve care on every kind of day. 💗',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF987B8B),
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
