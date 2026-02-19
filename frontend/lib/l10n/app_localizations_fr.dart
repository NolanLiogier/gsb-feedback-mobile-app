// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Application GSB';

  @override
  String get welcome => 'Bienvenue';

  @override
  String get localeTest => 'Test de langue';

  @override
  String get switchToEnglish => 'Anglais';

  @override
  String get switchToFrench => 'Français';

  @override
  String currentLocale(String locale) {
    return 'Actuel : $locale';
  }

  @override
  String get loginTitle => 'Connexion';

  @override
  String get loginSubtitle => 'Compte donné par l\'administrateur GSB';

  @override
  String get loginEmailLabel => 'EMAIL';

  @override
  String get loginEmailHint => 'nom.prenom@gsb.fr';

  @override
  String get loginPasswordLabel => 'MOT DE PASSE';

  @override
  String get loginPasswordHint => 'Mot de passe';

  @override
  String get loginButton => 'Se connecter';

  @override
  String get loginForgotPassword => 'Mot de passe oublié ?';

  @override
  String get loginFooterCompany => 'GALAXY SWISS BOURDIN';

  @override
  String get loginFooterVersion => 'Version 2.4.0 - SIO BTS';

  @override
  String get loginErrorRequired => 'Email et mot de passe requis';

  @override
  String get loginSuccessDefault => 'Connexion réussie';

  @override
  String get loginErrorDefault => 'Échec de la requête';

  @override
  String get appBarLogout => 'Déconnexion';

  @override
  String get visitsTitle => 'Liste des Visites';

  @override
  String get visitsSearchHint => 'Rechercher une visite...';

  @override
  String get visitsUserNotFound => 'Utilisateur introuvable';

  @override
  String get visitsLoadError => 'Échec du chargement des visites';

  @override
  String get visitsEmpty => 'Aucune visite';

  @override
  String get visitsNoResults => 'Aucun résultat';

  @override
  String get navVisits => 'Visites';

  @override
  String get navPlanning => 'Planning';

  @override
  String get visitDetailsTitle => 'Détails de la Visite';

  @override
  String get visitDetailsInvalidData => 'Données invalides';

  @override
  String get visitDetailsLoadError => 'Chargement impossible';

  @override
  String get visitDetailsError => 'Erreur';

  @override
  String get visitDetailsCurrentStatus => 'STATUT ACTUEL';

  @override
  String get visitDetailsGeneralInfo => 'INFORMATIONS GÉNÉRALES';

  @override
  String get visitDetailsVisitDate => 'Date de la visite';

  @override
  String get visitDetailsTimeSlot => 'Créneau horaire';

  @override
  String get visitDetailsPracticeLocation => 'Localisation du cabinet';

  @override
  String get visitDetailsAssignedVisitor => 'VISITEUR ASSIGNÉ';

  @override
  String get visitDetailsClient => 'CLIENT';

  @override
  String get visitDetailsComment => 'COMMENTAIRE';

  @override
  String get visitDetailsCreationDate => 'Date de création';
}
