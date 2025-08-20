void main() {
  var nomeEquipamento = "Impressora 3D";

  String local = "Lab de Protótipos";

  dynamic patrimonio = 12345;

  print("--- Valores Iniciais ---");
  print("Nome: $nomeEquipamento");
  print("Local: $local");
  print("Patrimônio: $patrimonio");

  patrimonio = "12345-A";

  print("\n--- Valores Atualizados ---");
  print("Nome: $nomeEquipamento");
  print("Local: $local");
  print("Patrimônio: $patrimonio");

  print("\n--- Verificação de Tipos ---");
  print("`nomeEquipamento` é do tipo String? ${nomeEquipamento is String}");
  print("`local` é do tipo String? ${local is String}");
  print("`patrimonio` é do tipo String? ${patrimonio is String}");
  print("`patrimonio` é do tipo int? ${patrimonio is int}");
}