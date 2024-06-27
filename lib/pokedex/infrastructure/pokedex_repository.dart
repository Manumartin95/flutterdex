import 'dart:convert';

import 'package:flutterdex/pokedex/domain/pokedex.dart';
import 'package:http/http.dart' as http;

Future<Pokedex> fetchPokedex(int offset) async {
  final response = await http
      .get(Uri.parse('https://pokeapi.co/api/v2/pokemon/?offset=$offset'));

  if (response.statusCode == 200) {
    return Pokedex.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load pokedex');
  }
}
