class Compte {
  int? jour;
  String? mois;
  int? mois_int;
  double? solde;
  double? montant_logement;
  double? montant_alimentation;
  double? montant_habillement;
  double? montant_deplacement;
  double? montant_education;
  double? montant_divers;
  DateTime? date_complete;
  String? date;

  Compte(
      {this.montant_logement,
      this.montant_alimentation,
      this.montant_habillement,
      this.montant_deplacement,
      this.montant_education,
      this.montant_divers,
      this.date_complete,
      this.date,
      this.jour,
      this.mois,
      this.mois_int,
      this.solde});

  Map<String, dynamic> createCompteToJson() => {
        'jour': jour,
        'mois': mois,
        'mois_int': mois_int,
        'solde': solde,
        'date_complete': date_complete,
        'date': date,
        'montant_logement': montant_logement,
        'montant_alimentation': montant_alimentation,
        'montant_habillement': montant_habillement,
        'montant_deplacement': montant_deplacement,
        'montant_education': montant_education,
        'montant_divers': montant_divers,
      };

  static Compte readCompteToJson(Map<String, dynamic> json) {
    return Compte(
      jour: json['jour'],
      mois: json['mois'],
      mois_int: json['mois_int'],
      solde: json['solde'],
      date_complete: json['date_complete'],
      date: json['date'],
      montant_logement: json['montant_logement'],
      montant_alimentation: json['montant_alimentation'],
      montant_habillement: json['montant_habillement'],
      montant_deplacement: json['montant_deplacement'],
      montant_education: json['montant_education'],
      montant_divers: json['montant_divers'],
    );
  }
}
