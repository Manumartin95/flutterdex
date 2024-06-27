import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterdex/pokedex/domain/pokedex.dart';
import 'package:flutterdex/pokedex/infrastructure/pokedex_repository.dart';
import 'package:flutterdex/pokedex/infrastructure/pokemon_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _offset = 0;
  final pokemonList = <Result>[];
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_loadMore);
    getPokedex();
  }

  Future<void> getPokedex() async {
    var pokedexAsync = await fetchPokedex(_offset);
    setState(() {
      pokemonList.addAll(pokedexAsync.pokemonList);
    });
  }

  void _loadMore() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _offset = _offset + 21;
      getPokedex();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Flutterdex')),
      ),
      body: Column(
        children: [
          if (pokemonList.isNotEmpty)
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: pokemonList.length,
                itemBuilder: (context, index) {
                  return PokemonCard(pokemonName: pokemonList[index].name);
                },
              ),
            )
        ],
      ),
    );
  }
}

class PokemonCard extends StatefulWidget {
  final String pokemonName;
  const PokemonCard({super.key, required this.pokemonName});

  @override
  State<PokemonCard> createState() => _PokemonCardState();
}

class _PokemonCardState extends State<PokemonCard> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchPokemon(widget.pokemonName),
        builder: (context, pokemon) {
          if (pokemon.hasData) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(pokemon.data!.sprites.frontDefault),
                    Image.network(pokemon.data!.sprites.backDefault)
                  ],
                ),
                Text(pokemon.data!.name)
              ],
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
