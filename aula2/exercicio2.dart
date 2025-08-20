void cadastrarFuncionario({required String nome, String? cargo}) {
  
  String mensagem = "Bem-vindo(a), $nome!";

  
  if (cargo != null && cargo.isNotEmpty) {
    mensagem += " Seu cargo é $cargo.";
  }

  
  print(mensagem);
}

void main() {
  
  cadastrarFuncionario(nome: "Ana", cargo: "Analista");
  cadastrarFuncionario(nome: "Carlos");
  cadastrarFuncionario(nome: "Maria", cargo: null);
  cadastrarFuncionario(nome: "João", cargo: "");
}