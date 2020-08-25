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

  // PROCEDIMENTO PARA LIMPAR OS CAMPOS
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
            ],
          ),
        ));
  }

  // Widget text
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

  // PROCEDIMENTO PARA VALIDAR OS CAMPOS
  String _validate(String text, String field) {
    if (text.isEmpty) {
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
          "Economizar!",
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

  // PROCEDIMENTO PARA CALCULAR
  void _calculate(){
    setState(() {
      double valorconta = double.parse(_valortotal.text);
      int qtdpessoas = int.parse(_qtdpessoas.text);
      double taxagarcom = double.parse(_txatendimento.text);

      double resumoconta = (valorconta+(valorconta*taxagarcom/100))/qtdpessoas;

      String show = resumoconta.toStringAsPrecision(4);

      if(resumoconta < 0 || taxagarcom < 0)
      {
        _infoText = "O valor da conta ou a taxa dx atendente não pode ser negativo poxa!";
      }
      else if(resumoconta > 0 && taxagarcom > 0)
      {
        _infoText = "O valor é de $show reais para cada!";
      }
    });
  }

  // Widget text ~ template do lable do text
  _textInfo()
  {
    return Text(
      _infoText,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.black54, fontSize: 22.0),
    );
  }
}
