import 'dart:convert';

import 'package:flutter/material.dart';

import '../../assets/gender_icons.dart';

class Character {
  int id;
  String name;
  String status;
  String species;
  String type;
  String gender;
  String image;
  List<String> episode;
  String url;
  String created;

  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({
      'id': id,
      'name': name,
      'status': status,
      'species': species,
      'type': type,
      'gender': gender,
      'image': image,
      'episode': episode,
      'url': url,
      'created': created,
    });

    return result;
  }

  factory Character.fromMap(Map<String, dynamic> map) {
    return Character(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      status: map['status'] ?? '',
      species: map['species'] ?? '',
      type: map['type'] ?? '',
      gender: map['gender'] ?? '',
      image: map['image'] ?? '',
      episode: List<String>.from(map['episode']),
      url: map['url'] ?? '',
      created: map['created'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Character.fromJson(String source) =>
      Character.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Character(id: $id, name: $name)';
  }

  Widget getGenderIcon() {
    if (gender == 'Male') {
      return const Icon(
        GenderIcons.male,
        color: Colors.cyan,
      );
    }
    if (gender == 'Female') {
      return const Icon(
        GenderIcons.female,
        color: Colors.pink,
      );
    }
    if (gender == 'Genderless') {
      return const Icon(
        GenderIcons.genderless,
        color: Colors.deepPurple,
      );
    }
    return const Icon(
      GenderIcons.unknown,
      color: Colors.black,
    ); //unknown
  }

  Color getStatusColor() {
    if (status == 'Alive') {
      return Colors.green;
    }
    if (status == 'Dead') {
      return Colors.red;
    }
    return Colors.black; //unknown
  }
}
