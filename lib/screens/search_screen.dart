import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/search_bar.dart';
import '../widgets/result_card.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/error_message.dart';
import 'detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ApiService _apiService = ApiService();

  List<dynamic> _results = [];
  bool _isLoading = false;
  String? _error;

  Future<void> _performSearch(String query) async {
    if (query.isEmpty) {
      setState(() {
        _results = [];
        _error = null;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final results = await _apiService.search(query);
      if (!mounted) return;
      setState(() {
        _results = results;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = 'Failed to load results. Please try again.';
        _isLoading = false;
      });
    }
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _results = [];
      _error = null;
    });
  }

  void _navigateToDetail(Map<String, dynamic> item) async {
    if (item['type'] == 'country') {
      final country = await _apiService.getCountry(item['code']);
      if (!mounted) return;
      if (country != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailScreen(item: country, type: 'country'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Country details not found')),
        );
      }
    } else if (item['type'] == 'city') {
      final cityId = int.tryParse(item['id'].toString()) ?? 0;
      if (cityId == 0) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid city ID')),
          );
        }
        return;
      }
      final city = await _apiService.getCity(cityId);
      if (!mounted) return;
      if (city != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailScreen(item: city, type: 'city'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('City details not found')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('World Explorer'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomSearchBar(
              controller: _searchController,
              onSubmitted: _performSearch,
              onClear: _clearSearch,
            ),
          ),
          Expanded(
            child: _buildBody(),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const LoadingIndicator();
    }
    if (_error != null) {
      return ErrorMessage(
        message: _error!,
        onRetry: () => _performSearch(_searchController.text),
      );
    }
    if (_results.isEmpty && _searchController.text.isNotEmpty) {
      return const Center(
        child: Text('No results found.'),
      );
    }
    return ListView.builder(
      itemCount: _results.length,
      itemBuilder: (ctx, index) {
        final item = _results[index];
        return ResultCard(
          item: item,
          onTap: () => _navigateToDetail(item),
        );
      },
    );
  }
}
