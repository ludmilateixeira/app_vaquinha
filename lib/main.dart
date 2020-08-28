import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Little Cow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

// Home page
class _HomePageState extends State<HomePage> {
  // Variáveis
  final _valortotal = TextEditingController();
  final _qtdpessoas = TextEditingController();
  final _txatendimento = TextEditingController();
  var _infoText = "Informe os dados!";
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Little Cow"),
        centerTitle: false,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.backspace),
              onPressed: _resetFields)
        ],
      ),
      body: _body(),
    );
  }

  // Procedimento para limpeza dos campos
  void _resetFields(){
    _valortotal.text = "";
    _qtdpessoas.text = "";
    _txatendimento.text = "";

    setState(()
    {
      _infoText = "Informe os dados";
      _formKey = GlobalKey<FormState>();
    });
  }

  _body(){
    return SingleChildScrollView(
        padding: EdgeInsets.all(15.0), // Margem lateral
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _editText("Qual é o valor da conta?", _valortotal),
              _editText("Quantas pessoas na vaquinha?", _qtdpessoas),
              _editText("Qual é a taxa % para x atendente?", _txatendimento),
              _buttonCalcular(),
              _textInfo(),
              //Image.network("https://www.bemcolar.com/media/catalog/product/cache/1/imagem1/400x/9df78eab33525d08d6e5fb8d27136e95/a/d/adesivo-de-geladeira-vaquinha.png"),
              Image.asset("images/vaca.png"),
            ],
          ),
        ));
  }

  // Widget text ~ template dos campos de escrita
  _editText(String field, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      validator: (s) => _validate(s, field),
      keyboardType: TextInputType.number,
      style: TextStyle(
        fontSize: 22,
        color: Colors.teal,
      ),
      decoration: InputDecoration(
        labelText: field,
        labelStyle: TextStyle(
          fontSize: 22,
          color: Colors.grey,
        ),
      ),
    );
  }

  // Procedimento para validação dos campos
  String _validate(String text, String field) {
    if (text.isEmpty) // Se texto é vazio
    {
      return "Digite o campo acima"; // Caso não preencha, retornaremos esta mensagem
    }
    return null;
  }

  // Widget button ~ template do botão calcular
  _buttonCalcular() {
    return Container(
      margin: EdgeInsets.only(top: 25.0, bottom: 30,), // Distância do botão em relação aos outros elementos
      height: 45,
      child: RaisedButton(
        color: Colors.teal,
        child:
        Text(
          "Dividir!",
          style: TextStyle(
            color: Colors.white,
            fontSize: 21,
          ),
        ),
        onPressed: () {
          if(_formKey.currentState.validate()){
            _calculate();
          }
        },
      ),
    );
  }

  // Procedimento para o botão Calcular
  void _calculate(){
    setState(() {
      double valorconta = double.parse(_valortotal.text);
      int qtdpessoas = int.parse(_qtdpessoas.text);
      double taxagarcom = double.parse(_txatendimento.text);

      //Para cada pessoa
      double resumopessoa = (valorconta+(valorconta*taxagarcom/100))/qtdpessoas;
      String show = resumopessoa.toStringAsPrecision(4);

      //Valor total da conta
      double resumoconta = (valorconta+(valorconta*taxagarcom/100));
      String showconta = resumoconta.toStringAsPrecision(4);

      //Valor total dx atendente
      double resumoatendente = ((valorconta*taxagarcom/100));
      String showatende = resumoatendente.toStringAsPrecision(4);

      if(resumopessoa < 0 || taxagarcom < 0)
      {
        _infoText = "O valor da conta ou a taxa dx atendente não pode ser negativo poxa!";
      }
      else if(resumoconta > 0 && taxagarcom > 0)
      {
        _infoText = "O valor total da conta é de $showconta reais.\n\n E o valor individual é de $show reais para cada. \n\n Já o valor do atendente será de $showatende reais! \n\n";
      }
    });
  }

  // Widget text ~ template do lable do text de informação
  _textInfo()
  {
    return Text(
      _infoText,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.lightGreen, fontSize: 20.0),
    );
  }
}
