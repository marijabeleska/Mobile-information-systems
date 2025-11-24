import 'package:flutter/material.dart';
import '../models/exam.dart';

class ExamCard extends StatelessWidget {
  final Exam exam;
  final String dateText;
  final String timeText;
  final VoidCallback onTap;

  const ExamCard({
    super.key,
    required this.exam,
    required this.dateText,
    required this.timeText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isPast = exam.isPast;


    final Color bgColor = isPast ? Colors.grey.shade100 : Colors.green.shade50;
    final Color borderColor = isPast ? Colors.grey.shade400 : Colors.green.shade300;
    final Color titleColor = isPast ? Colors.black87 : Colors.green.shade800;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Card(
        color: bgColor,
        elevation: 5,
        shadowColor: Colors.black26,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: borderColor, width: 1.2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                exam.subject,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: titleColor,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
              const SizedBox(height: 8),


              Row(
                children: [
                  const Icon(Icons.calendar_today_outlined, size: 16),
                  const SizedBox(width: 6),
                  Text(dateText, style: const TextStyle(fontSize: 13)),
                ],
              ),


              Row(
                children: [
                  const Icon(Icons.access_time, size: 16),
                  const SizedBox(width: 6),
                  Text(timeText, style: const TextStyle(fontSize: 13)),
                ],
              ),


              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.location_on_outlined, size: 16),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      exam.rooms.join(', '),
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),

              const Spacer(),


              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  isPast ? ' Поминат испит' : ' Претстоен испит',
                  style: TextStyle(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                    color: isPast ? Colors.grey.shade600 : Colors.green.shade700,
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
