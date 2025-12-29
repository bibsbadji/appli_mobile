class User {
  final String email;
  final String nom;
  final String motDePasse;

  User({
    required this.email,
    required this.nom,
    required this.motDePasse,
  });
}

// Tableau des utilisateurs enregistrés
class UsersData {
  static final List<User> users = [
    User(
      email: 'admin@ods.com',
      nom: 'Administrateur',
      motDePasse: 'admin123',
    ),
    User(
      email: 'becayesadio@gmail.com',
      nom: ' becaye SADIO',
      motDePasse: 'sadio2025',
    ),
    User(
      email: 'gueyeelimane@gmail.com',
      nom: 'elimane gueye',
      motDePasse: 'gueyeelimane',
    ),
  ];

  // Vérifier si l'email et le mot de passe correspondent
  static User? verifierConnexion(String email, String motDePasse) {
    try {
      return users.firstWhere(
        (user) => user.email == email && user.motDePasse == motDePasse,
      );
    } catch (e) {
      return null; // Aucun utilisateur trouvé
    }
  }

  // Vérifier si un email existe déjà
  static bool emailExiste(String email) {
    return users.any((user) => user.email == email);
  }

  // Ajouter un nouvel utilisateur
  static void ajouterUtilisateur(User user) {
    users.add(user);
  }
}