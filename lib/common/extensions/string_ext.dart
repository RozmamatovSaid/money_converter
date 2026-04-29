part of 'extensions.dart';

extension StringExt on String {
  bool get isNumber => num.tryParse(this).isNotNull;

  bool get isEmail => RegExp(r'^[\w\-\.]+@([\w-]+\.)+[\w-]{2,}$').hasMatch(trim());

  bool get isPhoneNumber => RegExp(r'^\+?[\d\s\-()]{7,15}$').hasMatch(trim());

  bool get isUrl => Uri.tryParse(this)?.hasAbsolutePath ?? false;

  bool get isBlank => trim().isEmpty;

  bool get isNotBlank => !isBlank;

  String get capitalize => this[0].toUpperCase() + substring(1);

  // ── Trimming / Truncation ──────────────────────────────────────────

  String truncate(int maxLength, {String ellipsis = '…'}) =>
      length <= maxLength ? this : '${substring(0, maxLength)}$ellipsis';

  String get removeWhitespace => replaceAll(RegExp(r'\s+'), '');

  String get onlyDigits => replaceAll(RegExp(r'[^\d]'), '');

  String get onlyLetters => replaceAll(RegExp(r'[^a-zA-Z]'), '');

  String get onlyLettersAndDigits => replaceAll(RegExp(r'[^a-zA-Z\d]'), '');

  // ── Formatting ─────────────────────────────────────────────────────

  /// Masks phone: "998901234567" → "+998 (90) 123-45-67"
  String get formattedPhone {
    final digits = onlyDigits;

    if (digits.length == 12) {
      return '+${digits.substring(0, 3)} ' // +998
          '${digits.substring(3, 5)} ' // 99
          '${digits.substring(5, 8)} ' // 909
          '${digits.substring(8, 10)} ' // 99
          '${digits.substring(10)}'; // 99
    }

    if (digits.length == 9) {
      return '+998 '
          '${digits.substring(0, 2)} ' // 99
          '${digits.substring(2, 5)} ' // 909
          '${digits.substring(5, 7)} ' // 99
          '${digits.substring(7)}'; // 99
    }

    return this; // Agar format tushmasa o'zini qaytaradi
  }

  /// Masks card: "8600123456789012" → "8600 1234 5678 9012"
  String get formattedCardNumber => onlyDigits.replaceAllMapped(RegExp(r'.{4}'), (m) => '${m.group(0)} ').trim();

  /// Masks card number showing only last 4: "8600 **** **** 9012"
  String get maskedCardNumber {
    final digits = onlyDigits;
    if (digits.length < 8) return this;
    return '${digits.substring(0, 4)} **** **** ${digits.substring(digits.length - 4)}';
  }

  // ── Conversions ────────────────────────────────────────────────────

  int get toInt => .parse(this);

  double get toDouble => .parse(this);

  DateTime? get toDateTimeOrNull => .tryParse(this);

  Uri get toUri => .parse(this);

  /// Parses hex color string: "#FF5733" or "FF5733"
  Color get toColor {
    final hex = replaceFirst('#', '').trim();
    if (hex.length == 6) return Color(.parse('FF$hex', radix: 16));
    if (hex.length == 8) return Color(.parse(hex, radix: 16));
    return const Color(0x00000000);
  }
}

// ── Nullable String helpers ────────────────────────────────────────────

extension NullableStringExt on String? {
  bool get isNullOrBlank => this == null || this!.isBlank;

  String orDefault({String defaultValue = ''}) => isNullOrBlank ? defaultValue : this!;
}
