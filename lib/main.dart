import 'package:flutter/material.dart';

void main() {
  runApp(AppCrud());
}

class Compras {
  String nome;
  String categoria;
  String precoMaximo;

  Compras({
    required this.nome,
    required this.categoria,
    required this.precoMaximo,
  });
}

class AppCrud extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Compras',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[200],
          title: Text('Lista de Compras'),
        ),
        body: LoginPage(),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'images/Compras.png',
                  height: 300,
                  width: 300,
                ),
                Positioned(
                  top: 72,
                  child: Image.asset(
                    'images/Compras.png',
                    height: 0,
                    width: 0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Júlia Farias de Queiroz',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Usuário'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_usernameController.text == 'Vedilson' &&
                    _passwordController.text == 'trocar123') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StudentListPage()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Credenciais inválidas')),
                  );
                }
              },
              child: Text('Acessar'),
            ),
          ],
        ),
      ),
    );
  }
}

class StudentListPage extends StatefulWidget {
  @override
  _StudentListPageState createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  List<Compras> products = [
    Compras(
        nome: 'Arroz',
        categoria: 'Cereais, tubérculos e raízes',
        precoMaximo: '20'),
    Compras(nome: 'Alpino', categoria: 'Chocolates', precoMaximo: '9'),
    Compras(nome: 'Coca-Cola', categoria: 'Refrigerante', precoMaximo: '11'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Compras'),
      ),
      backgroundColor: Colors.green[100],
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(products[index].nome),
            subtitle: Text(products[index].categoria),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                products.removeAt(index);
                setState(() {});
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Item removido.')),
                );
              },
            ),
            onTap: () async {
              Compras? updatedProduct = await showDialog(
                context: context,
                builder: (context) {
                  TextEditingController _nomeController =
                      TextEditingController(text: products[index].nome);
                  TextEditingController _categoriaController =
                      TextEditingController(text: products[index].categoria);
                  TextEditingController _precoMaximoController =
                      TextEditingController(text: products[index].precoMaximo);

                  return AlertDialog(
                    title: Text('Editar Item'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                            controller: _nomeController,
                            decoration: InputDecoration(labelText: 'Nome')),
                        TextField(
                            controller: _categoriaController,
                            decoration:
                                InputDecoration(labelText: 'Categoria')),
                        TextField(
                            controller: _precoMaximoController,
                            decoration:
                                InputDecoration(labelText: 'Preço Máximo')),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () {
                          if (_nomeController.text.isNotEmpty &&
                              _categoriaController.text.isNotEmpty &&
                              _precoMaximoController.text.isNotEmpty) {
                            Navigator.pop(
                              context,
                              Compras(
                                nome: _nomeController.text.trim(),
                                categoria: _categoriaController.text.trim(),
                                precoMaximo: _precoMaximoController.text.trim(),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Preencha todos os campos corretamente')),
                            );
                          }
                        },
                        child: Text('Salvar'),
                      ),
                    ],
                  );
                },
              );

              if (updatedProduct != null) {
                setState(() {
                  products[index] = updatedProduct;
                });
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Compras? newProduct = await showDialog(
            context: context,
            builder: (context) {
              TextEditingController _nomeController = TextEditingController();
              TextEditingController _categoriaController =
                  TextEditingController();
              TextEditingController _precoMaximoController =
                  TextEditingController();

              return AlertDialog(
                title: Text('Novo Item'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                        controller: _nomeController,
                        decoration: InputDecoration(labelText: 'Nome')),
                    TextField(
                        controller: _categoriaController,
                        decoration: InputDecoration(labelText: 'Categoria')),
                    TextField(
                        controller: _precoMaximoController,
                        decoration: InputDecoration(labelText: 'Preço Máximo')),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (_nomeController.text.isNotEmpty &&
                          _categoriaController.text.isNotEmpty &&
                          _precoMaximoController.text.isNotEmpty) {
                        Navigator.pop(
                          context,
                          Compras(
                            nome: _nomeController.text.trim(),
                            categoria: _categoriaController.text.trim(),
                            precoMaximo: _precoMaximoController.text.trim(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Preencha todos os campos corretamente')),
                        );
                      }
                    },
                    child: Text('Adicionar'),
                  ),
                ],
              );
            },
          );

          if (newProduct != null) {
            products.add(newProduct);
            setState(() {});
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
