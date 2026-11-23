String? validateRequired(
  String? value, {
  required String label,
  int minLength = 1,
  int maxLength = 100,
}) {
  final text = value?.trim() ?? '';
  if (text.isEmpty) {
    return '$label tidak boleh kosong!';
  }
  if (text.length < minLength) {
    return '$label minimal $minLength karakter!';
  }
  if (text.length > maxLength) {
    return '$label maksimal $maxLength karakter!';
  }
  return null;
}

String? validateOptionalUrl(String? value, {String label = 'Tautan'}) {
  final text = value?.trim() ?? '';
  if (text.isEmpty) {
    return null;
  }
  final uri = Uri.tryParse(text);
  final isValid =
      uri != null &&
      (uri.scheme == 'http' || uri.scheme == 'https') &&
      uri.host.isNotEmpty;
  if (!isValid) {
    return '$label harus diawali http:// atau https:// dan berisi domain yang valid!';
  }
  return null;
}
