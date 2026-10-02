// object for see which field is mandatory and optional
class MagicCard {
  String name;
  String manaCost;
  String type;
  String oracleText;
  int? power;
  int? toughness;

  MagicCard(
      {required this.name,
      required this.manaCost,
      required this.type,
      required this.oracleText,
      this.power,
      this.toughness});
}
