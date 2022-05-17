class Compte {
  int? jour;
  int? mois;
  int? solde;
  // String? besoin_primaire;
  bool? logement;
  int? montant_logement;
  bool? alimentation;
  int? montant_alimentation;
  // String? besoin_secondaire;
  bool? habillement;
  int? montant_habillement;
  bool? deplacement;
  int? montant_deplacement;
  // String? autre_besoin;
  bool? education;
  int? montant_education;
  bool? divers;
  int? montant_divers;
  DateTime? date;

  Compte(
      {
      // this.besoin_primaire,
      this.logement,
      this.montant_logement,
      this.alimentation,
      this.montant_alimentation,
      // this.besoin_secondaire,
      this.habillement,
      this.montant_habillement,
      this.deplacement,
      this.montant_deplacement,
      // this.autre_besoin,
      this.education,
      this.montant_education,
      this.divers,
      this.montant_divers,
      this.date,
      this.jour,
      this.mois,
      this.solde});

  Map<String, dynamic> compteToJson() => {
        'jour': jour,
        'mois': mois,
        'solde': solde,
        'date': date,
        // 'besoin_primaire': besoin_primaire,
        'logement': logement,
        'montant_logement': montant_logement,
        'alimentation': alimentation,
        'montant_alimentation': montant_alimentation,
        // 'besoin_secondaire': besoin_secondaire,
        'habillement': habillement,
        'montant_habillement': montant_habillement,
        'deplacement': deplacement,
        // 'autre_besoin': autre_besoin,
        'education': education,
        'montant_education': montant_education,
        'divers': divers,
        'montant_divers': montant_divers,
      };
}
