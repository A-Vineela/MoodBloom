
import 'package:flutter/material.dart';
import '../models/mood_entry.dart';

class CheckInScreen extends StatefulWidget {
  const CheckInScreen({
    super.key,
    required this.onSave,
    required this.alreadyCheckedIn,
  });

  final ValueChanged<MoodEntry> onSave;
  final bool alreadyCheckedIn;

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  Mood? _selectedMood;
  final TextEditingController _noteController = TextEditingController();

  static const Color pink = Color(0xFF925C75);
  static const Color background = Color(0xFFFFF5F7);

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _save() {
    if (_selectedMood == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Choose a mood before saving.')),
      );
      return;
    }

    widget.onSave(
      MoodEntry(
        date: DateTime.now(),
        mood: _selectedMood!,
        note: _noteController.text.trim(),
      ),
    );

    Navigator.pop(context);
  }

  Widget _moodOption(Mood mood) {
    final selected = _selectedMood == mood;

    return InkWell(
      onTap: () => setState(() => _selectedMood = mood),
      borderRadius: BorderRadius.circular(18),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 5),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFF5DFE9) : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected ? const Color(0xFFD69BB5) : const Color(0xFFF0E7EB),
            width: selected ? 1.6 : 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              mood.emoji,
              style: const TextStyle(fontSize: 27),
            ),
            const SizedBox(height: 7),
            Text(
              mood.label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                fontWeight: selected ? FontWeight.bold : FontWeight.w500,
                color: selected ? pink : const Color(0xFF796573),
              ),
            ),
            if (selected) ...[
              const SizedBox(height: 4),
              const Icon(Icons.check_circle, size: 13, color: pink),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text(
          'Daily Check-in 🌷',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: background,
        foregroundColor: pink,
        elevation: 0,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 680),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(22, 15, 22, 30),
            children: [
              const Text(
                'Take a moment for yourself.',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF493744),
                ),
              ),
              const SizedBox(height: 7),
              const Text(
                'There are no right or wrong feelings here. ♡',
                style: TextStyle(color: Color(0xFF927F8A), fontSize: 13),
              ),

              const SizedBox(height: 30),

              const Text(
                'How are you feeling today?',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF493744),
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Choose the mood that feels closest to you.',
                style: TextStyle(fontSize: 12, color: Color(0xFF927F8A)),
              ),
              const SizedBox(height: 16),

              LayoutBuilder(
                builder: (context, constraints) {
                  final columns = constraints.maxWidth < 380 ? 3 : 5;

                  return GridView.count(
                    crossAxisCount: columns,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1.05,
                    children: Mood.values.map(_moodOption).toList(),
                  );
                },
              ),

              const SizedBox(height: 28),

              const Text(
                'A little reflection ✨',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF493744),
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Would you like to write down what is on your mind?',
                style: TextStyle(fontSize: 12, color: Color(0xFF927F8A)),
              ),
              const SizedBox(height: 13),

              TextField(
                controller: _noteController,
                maxLines: 4,
                maxLength: 180,
                decoration: InputDecoration(
                  hintText: 'Today I feel this way because...',
                  hintStyle: const TextStyle(
                    color: Color(0xFFB5A4AE),
                    fontSize: 13,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.all(17),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: const BorderSide(color: Color(0xFFF0E7EB)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: const BorderSide(color: Color(0xFFD69BB5)),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              SizedBox(
                height: 50,
                child: FilledButton(
                  onPressed: _save,
                  style: FilledButton.styleFrom(
                    backgroundColor: pink,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    widget.alreadyCheckedIn
                        ? "Add another check-in"
                        : "Save my check-in",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
