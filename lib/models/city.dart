class City {
  final int id;
  final String name;
  final int countryId;
  final String countryCode;
  final int population;
  final String? countryName;
  final double? latitude;
  final double? longitude;
  final String? timezone;
  final String? currency;
  final String? currencySymbol;
  final String? phoneCode;
  final String? languages;
  final String? countryEmoji;

  City({
    required this.id,
    required this.name,
    required this.countryId,
    required this.countryCode,
    required this.population,
    this.countryName,
    this.latitude,
    this.longitude,
    this.timezone,
    this.currency,
    this.currencySymbol,
    this.phoneCode,
    this.languages,
    this.countryEmoji,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      name: json['name'] ?? '',
      countryId: int.tryParse(json['country_id']?.toString() ?? '0') ?? 0,
      countryCode: json['country_code'] ?? '',
      population: int.tryParse(json['population']?.toString() ?? '0') ?? 0,
      countryName: json['country_name'],
      latitude: json['latitude'] != null
          ? double.tryParse(json['latitude'].toString())
          : null,
      longitude: json['longitude'] != null
          ? double.tryParse(json['longitude'].toString())
          : null,
      timezone: json['timezone'],
      currency: json['currency'],
      currencySymbol: json['currency_symbol'],
      phoneCode: json['country_phonecode'],
      languages: json['country_languages'],
      countryEmoji: json['country_emoji'],
    );
  }
}
