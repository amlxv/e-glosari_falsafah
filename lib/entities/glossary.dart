class Glossary {
  late String id;
  late String term;
  late String definition;

  Glossary(this.id, this.term, this.definition);

  Glossary.fromJson(Map<String, dynamic> data) {
    id = data['id'];
    term = data['istilah'];
    definition = data['definisi'];
  }
}