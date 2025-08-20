class Laptop {
  int id;
  String nome;
  String ram;
  String clockCpu;

  Laptop(this.id, this.nome, this.ram, this.clockCpu);

  Laptop.navegacao(this.id, this.nome)
      : this.ram = '4 GB',
        this.clockCpu = '1.8 GHz';

  Laptop.escritorio(this.id, this.nome)
      : this.ram = '8 GB',
        this.clockCpu = '2.4 GHz';

  Laptop.programacao(this.id, this.nome)
      : this.ram = '16 GB',
        this.clockCpu = '3.0 GHz';

  void imprimirDetalhes() {
    print('-------------------------');
    print('ID: $id');
    print('Nome: $nome');
    print('RAM: $ram');
    print('Clock da CPU: $clockCpu');
  }
}

void main() {
  
  Laptop laptopNavegacao = Laptop.navegacao(1, 'Chromebook');
  Laptop laptopEscritorio = Laptop.escritorio(2, 'HP Pavilion');
  Laptop laptopProgramacao = Laptop.programacao(3, 'Dell XPS 15');

  print('Configuração para Navegação:');
  laptopNavegacao.imprimirDetalhes();

  print('\nConfiguração para Escritório:');
  laptopEscritorio.imprimirDetalhes();

  print('\nConfiguração para Programação:');
  laptopProgramacao.imprimirDetalhes();
}