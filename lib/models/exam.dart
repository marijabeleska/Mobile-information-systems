class Exam {
  final String subject;
  final DateTime dateTime;
  final List<String> rooms;

  const Exam({
    required this.subject,
    required this.dateTime,
    required this.rooms,
  });

  bool get isPast => dateTime.isBefore(DateTime.now());
}

final List<Exam> sampleExams = [
  Exam(
    subject: 'Мобилни информациски системи',
    dateTime: DateTime(2026, 2, 5, 9, 0),
    rooms: ['АМФ-1', 'ЛАБ-3'],
  ),
  Exam(
    subject: 'Машинско учење',
    dateTime: DateTime(2025, 2, 7, 10, 30),
    rooms: ['ЛАБ-1'],
  ),
  Exam(
    subject: 'Вештачка интелигенција',
    dateTime: DateTime(2025, 2, 10, 9, 0),
    rooms: ['АМФ-2'],
  ),
  Exam(
    subject: 'Алгоритми и податочни структури',
    dateTime: DateTime(2025, 1, 25, 8, 0),
    rooms: ['АМФ-1'],
  ),
  Exam(
    subject: 'Бази на податоци',
    dateTime: DateTime(2026, 1, 28, 12, 0),
    rooms: ['ЛАБ-2', 'ЛАБ-4'],
  ),
  Exam(
    subject: 'Оперативни системи',
    dateTime: DateTime(2025, 2, 12, 14, 0),
    rooms: ['АМФ-3'],
  ),
  Exam(
    subject: 'Компјутерски мрежи',
    dateTime: DateTime(2026, 2, 15, 9, 0),
    rooms: ['ЛАБ-5'],
  ),
  Exam(
    subject: 'Напредно програмирање',
    dateTime: DateTime(2025, 1, 20, 11, 0),
    rooms: ['АМФ-2'],
  ),
  Exam(
    subject: 'Интернет технологии',
    dateTime: DateTime(2025, 2, 18, 10, 0),
    rooms: ['ЛАБ-1'],
  ),
  Exam(
    subject: 'Дизајн на софтвер',
    dateTime: DateTime(2025, 2, 20, 13, 0),
    rooms: ['АМФ-1'],
  ),
];