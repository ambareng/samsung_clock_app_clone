const String tableAlarms = 'alarms';

class AlarmFields {
  static final List<String> values = [
    id, isEnabled, alarmTime
  ];

  static const String id = '_id';
  static const String isEnabled = 'isEnabled';
  static const String alarmTime = 'alarmTime';
}

class Alarm {
  final int? id;
  final bool isEnabled;
  final DateTime alarmTime;

  const Alarm({
    this.id,
    required this.isEnabled,
    required this.alarmTime,
  });

  Map<String, Object?> toJson() => {
    AlarmFields.id: id,
    AlarmFields.isEnabled: isEnabled ? 1 : 0,
    AlarmFields.alarmTime: alarmTime.toIso8601String(),
  };

  static Alarm fromJson(Map<String, Object?> json) => Alarm(
    id: json[AlarmFields.id] as int?,
    isEnabled: json[AlarmFields.isEnabled] == 1 ? true : false,
    alarmTime: DateTime.parse(json[AlarmFields.alarmTime] as String),
  );

  Alarm copy({
    int? id,
    bool? isEnabled,
    DateTime? alarmTime,
  }) => Alarm(
    id: id ?? this.id,
    isEnabled: isEnabled ?? this.isEnabled,
    alarmTime: alarmTime ?? this.alarmTime,
  );
}