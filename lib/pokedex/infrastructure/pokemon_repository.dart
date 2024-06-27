import 'dart:convert';

import 'package:flutterdex/pokedex/domain/pokemon.dart';
import 'package:http/http.dart' as http;

Future<Pokemon> fetchPokemon(String pokemonName) async {
  final response = await http
      .get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$pokemonName'));

  if (response.statusCode == 200) {
    return Pokemon.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load pokemon');
  }
}
