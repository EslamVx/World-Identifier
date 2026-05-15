import 'package:flutter/material.dart';
import '../models/country.dart';
import '../models/city.dart';

class DetailScreen extends StatelessWidget {
  final dynamic item;
  final String type;

  const DetailScreen({
    super.key,
    required this.item,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(type == 'country' ? 'Country Details' : 'City Details'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: type == 'country'
                ? _buildCountryDetails()
                : _buildCityDetails(),
          ),
        ),
      ),
    );
  }

  Widget _buildCountryDetails() {
    final country = item as Country;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Column(
            children: [
              Text(
                country.emoji,
                style: const TextStyle(fontSize: 64),
              ),
              const SizedBox(height: 8),
              Text(
                country.name,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const Divider(height: 32),
        _buildInfoRow('Code', country.code),
        _buildInfoRow('ISO3', country.iso3),
        _buildInfoRow('Capital', country.capital),
        _buildInfoRow('Population', _formatNumber(country.population)),
        _buildInfoRow('Currency', country.currency),
        if (country.area != null)
          _buildInfoRow('Area (km²)', _formatNumber(country.area!.toInt())),
        if (country.languages != null && country.languages!.isNotEmpty)
          _buildInfoRow('Languages', country.languages!),
        if (country.phoneCode != null && country.phoneCode!.isNotEmpty)
          _buildInfoRow('Phone Code', '+${country.phoneCode}'),
        if (country.timezones != null && country.timezones!.isNotEmpty)
          _buildInfoRow('Timezones', country.timezones!),
        if (country.region != null && country.region!.isNotEmpty)
          _buildInfoRow('Region', country.region!),
        if (country.subregion != null && country.subregion!.isNotEmpty)
          _buildInfoRow('Subregion', country.subregion!),
      ],
    );
  }

  Widget _buildCityDetails() {
    final city = item as City;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Column(
            children: [
              Icon(
                Icons.location_city,
                size: 64,
                color: Colors.green.shade300,
              ),
              const SizedBox(height: 8),
              Text(
                city.name,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const Divider(height: 32),
        _buildInfoRow('Country Code', city.countryCode),
        _buildInfoRow('Population', _formatNumber(city.population)),
        if (city.countryName != null && city.countryName!.isNotEmpty)
          _buildInfoRow('Country', city.countryName!),
        if (city.latitude != null && city.longitude != null)
          _buildInfoRow('Coordinates',
              '${city.latitude!.toStringAsFixed(4)}, ${city.longitude!.toStringAsFixed(4)}'),
        if (city.timezone != null && city.timezone!.isNotEmpty)
          _buildInfoRow('Timezone', city.timezone!),
        if (city.currency != null && city.currency!.isNotEmpty)
          _buildInfoRow(
              'Currency', '${city.currency} ${city.currencySymbol ?? ''}'),
        if (city.phoneCode != null && city.phoneCode!.isNotEmpty)
          _buildInfoRow('Phone Code', '+${city.phoneCode}'),
        if (city.languages != null && city.languages!.isNotEmpty)
          _buildInfoRow('Languages', city.languages!),
        if (city.countryEmoji != null && city.countryEmoji!.isNotEmpty)
          _buildInfoRow('Flag', city.countryEmoji!),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }

  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }
}
