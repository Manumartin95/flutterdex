import 'dart:convert';

Pokedex pokedexFromJson(String str) => Pokedex.fromJson(json.decode(str));

String pokedexToJson(Pokedex data) => json.encode(data.toJson());

class Pokedex {
  final int count;
  final List<Result> pokemonList;

  Pokedex({
    required this.count,
    required this.pokemonList,
  });

  factory Pokedex.fromJson(Map<String, dynamic> json) => Pokedex(
        count: json["count"],
        pokemonList:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "results": List<dynamic>.from(pokemonList.map((x) => x.toJson())),
      };
}

class Result {
  final String name;
  final String url;

  Result({
    required this.name,
    required this.url,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
