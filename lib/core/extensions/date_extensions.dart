import 'package:intl/intl.dart';

extension DateTimeX on DateTime {
  String get displayDate => DateFormat('dd/MM/yyyy').format(this);
  String get displayDateTime => DateFormat('dd/MM/yyyy HH:mm').format(this);
  String get displayTime => DateFormat('HH:mm').format(this);

  String get relativeDisplay {
    final now = DateTime.now();
    final diff = now.difference(this);
    if (diff.inDays == 0) return 'Aujourd\'hui';
    if (diff.inDays == 1) return 'Hier';
    if (diff.inDays < 7) return 'Il y a ${diff.inDays} jours';
    return DateFormat('dd/MM/yyyy').format(this);
  }
}
