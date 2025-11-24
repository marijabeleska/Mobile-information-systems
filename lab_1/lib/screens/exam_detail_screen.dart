import 'package:flutter/material.dart';
import '../models/exam.dart';

class ExamDetailScreen extends StatelessWidget {
  final Exam exam;

  const ExamDetailScreen({
    super.key,
    required this.exam,
  });

  String _formatDate(DateTime dt) =>
      '${dt.day.toString().padLeft(2, '0')}.${dt.month.toString().padLeft(2, '0')}.${dt.year}';

  String _formatTime(DateTime dt) =>
      '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';

  String _timeUntilExam(DateTime dateTime) {
    final now = DateTime.now();
    final diff = dateTime.difference(now);

    if (diff.isNegative) {
      return 'Испитот е поминат';
    }

    final days = diff.inDays;
    final hours = diff.inHours - days * 24;

    return '$days дена, $hours часа';
  }

  @override
  Widget build(BuildContext context) {
    final String dateText = _formatDate(exam.dateTime);
    final String timeText = _formatTime(exam.dateTime);
    final String remainingText = _timeUntilExam(exam.dateTime);

    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: Text(exam.subject),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  exam.subject,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),


                Row(
                  children: [
                    const Icon(Icons.calendar_today_outlined),
                    const SizedBox(width: 8),
                    Text('Датум: $dateText'),
                  ],
                ),
                const SizedBox(height: 8),


                Row(
                  children: [
                    const Icon(Icons.access_time),
                    const SizedBox(width: 8),
                    Text('Време: $timeText'),
                  ],
                ),
                const SizedBox(height: 8),


                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.location_on_outlined),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Простории: ${exam.rooms.join(', ')}',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                const Divider(),
                const SizedBox(height: 16),


                Row(
                  children: [
                    const Icon(Icons.hourglass_bottom),
                    const SizedBox(width: 8),
                    Text(
                      'Преостанато време: $remainingText',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),

                const SizedBox(height: 24),


                const Text(
                  'Простории (детално):',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: exam.rooms
                      .map(
                        (room) => Chip(
                      avatar: const Icon(Icons.meeting_room, size: 18),
                      label: Text(room),
                    ),
                  )
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
