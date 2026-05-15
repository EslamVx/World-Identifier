class Country {
  final int id;
  final String name;
  final String code;
  final String iso3;
  final String capital;
  final int population;
  final String currency;
  final String emoji;
  final double? area;
  final String? languages;
  final String? phoneCode;
  final String? timezones;
  final String? region;
  final String? subregion;
  final String? nativeName;
  final String? nationality;

  Country({
    required this.id,
    required this.name,
    required this.code,
    required this.iso3,
    required this.capital,
    required this.population,
    required this.currency,
    required this.emoji,
    this.area,
    this.languages,
    this.phoneCode,
    this.timezones,
    this.region,
    this.subregion,
    this.nativeName,
    this.nationality,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      name: json['name'] ?? '',
      code: json['iso2'] ?? json['code'] ?? '',
      iso3: json['iso3'] ?? '',
      capital: json['capital'] ?? '',
      population: int.tryParse(json['population']?.toString() ?? '0') ?? 0,
      currency: json['currency'] ?? '',
      emoji: json['emoji'] ?? '🌍',
      area: json['area_sq_km'] != null
          ? double.tryParse(json['area_sq_km'].toString())
          : null,
      languages: json['languages'],
      phoneCode: json['phonecode'],
      timezones: json['timezones'],
      region: json['region'],
      subregion: json['subregion'],
      nativeName: json['native'],
      nationality: json['nationality'],
    );
  }
}
