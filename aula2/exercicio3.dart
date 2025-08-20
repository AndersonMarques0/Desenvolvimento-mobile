class Laptop {
  
  int id;
  String nome;
  String ram;
  String clockCpu;

  Laptop(this.id, this.nome, this.ram, this.clockCpu);

  void imprimirDetalhes() {
    print('-------------------------');
    print('ID: $id');
    print('Nome: $nome');
    print('RAM: $ram');
    print('Clock da CPU: $clockCpu');
  }
}

void main() {
  
  Laptop laptop1 = Laptop(1, 'Dell XPS 15', '16 GB', '2.3 GHz');
  Laptop laptop2 = Laptop(2, 'MacBook Air M1', '8 GB', '3.2 GHz');
  Laptop laptop3 = Laptop(3, 'Acer Nitro 5', '32 GB', '2.6 GHz');

  
  laptop1.imprimirDetalhes();
  laptop2.imprimirDetalhes();
  laptop3.imprimirDetalhes();
}