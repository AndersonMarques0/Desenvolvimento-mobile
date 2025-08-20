import 'dart:io';

class House {
  
  int id;
  String name;
  double price;
  
  House(this.id, this.name, this.price);

  void imprimirDetalhes() {
    print('-------------------------');
    print('ID: $id');
    print('Nome: $name');
    print('Preço: R\$${price.toStringAsFixed(2)}');
  }
}

void main() {
  List<House> listaDeCasas = [];

  for (int i = 1; i <= 3; i++) {
    print('\n--- Cadastro da Casa $i ---');

    stdout.write('Digite o ID: ');
    int id = int.parse(stdin.readLineSync()!);

    stdout.write('Digite o nome: ');
    String nome = stdin.readLineSync()!;

    stdout.write('Digite o preço: ');
    double preco = double.parse(stdin.readLineSync()!);

    House novaCasa = House(id, nome, preco);
    listaDeCasas.add(novaCasa);
  }

  print('\n--- Alterando nomes com Cascade Notation ---');
  for (var casa in listaDeCasas) {
    casa..name = '${casa.name} (Cadastrada)';
  }

  print('\n--- Casas Cadastradas ---');
  for (var casa in listaDeCasas) {
    casa.imprimirDetalhes();
  }
}