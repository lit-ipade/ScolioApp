import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class PacienteForm extends StatefulWidget {

  final void Function(String, String, String) onSubmit;

  PacienteForm(this.onSubmit);

  @override
  _PacienteFormState createState() => _PacienteFormState();
}

  enum SexoDefinido {m, f}

class _PacienteFormState extends State<PacienteForm> {

  final _nameController = TextEditingController();
  
  SexoDefinido _sexoController = SexoDefinido.m;

  DateTime _selectNascimento = DateTime.now();



  
void _exibirDialogo() 
  {
    showDialog
    (
       context:  context,
       builder:  (BuildContext context) 
       {
         return AlertDialog
         (
           title: Text('Erro com data de Nascimento',style: TextStyle(color: Theme.of(context).primaryColor),),
           content: Text('O paciente não se encaixa no critério de diagnóstico de EIA se não tiver entre 10 e 17 anos',textAlign: TextAlign.justify,),
           actions: <Widget>
           [
             FlatButton
             (
               child: Text("Ok!"),
               onPressed: () {Navigator.of(context).pop();},
             )
           ],
         );
        },
    );
  }

  _submitForm()
  {
    final nome = _nameController.text;
    final sexo = _sexoController.toString();

    if(nome.isEmpty || sexo == null || _selectNascimento == null || DateTime.now().difference(_selectNascimento).inDays < 3650 || DateTime.now().difference(_selectNascimento).inDays > 6205)
    {
      if(DateTime.now().difference(_selectNascimento).inDays < 3650 || DateTime.now().difference(_selectNascimento).inDays > 6205)
      {
        _exibirDialogo();
      }
      return;
    }
    String dataSelecionada = DateFormat('dd/MM/yyyy').format(_selectNascimento);
    widget.onSubmit(nome,sexo,dataSelecionada);
  }

  _showDatePicker()
  {
    showDatePicker
    (
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ).then((pickedDate)
    {
      if(pickedDate == null)
      {
        return;
      }
      
      setState(() {
        _selectNascimento = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card
    (
      elevation: 5,
      child: Padding
      (
        padding: const EdgeInsets.all(10),
        child: Column
        (
          children: <Widget>
          [
            TextField
              (
                controller: _nameController,
                onSubmitted: (_)=>_submitForm(),
                decoration: InputDecoration
                (
                  labelText: 'Nome',
                ),
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Text('Sexo:'),
            ),
            Row
            (
              children: <Widget>
              [
                Expanded
                (
                  child: ListTile
                  (
                    title: const Text('M'),
                    leading: Radio
                    (
                      value: SexoDefinido.m,
                      groupValue: _sexoController,
                      onChanged: (SexoDefinido value) 
                      {
                        setState
                        (() 
                          {
                            _sexoController = value;
                          }
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile
                  (
                    title: const Text('F'),
                    leading: Radio
                    (
                      value: SexoDefinido.f,
                      groupValue: _sexoController,
                      onChanged: (SexoDefinido value) 
                      {
                        setState
                        (() 
                          {
                            _sexoController = value;
                          }
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 70,
              child: Row
              (
                children: <Widget>
                [
                Expanded(
                  child: Text
                    (
                      _selectNascimento == null ? 'Nenhuma data selecionada !' :
                      'Data Selecionada: ${DateFormat('dd/MM/yyyy').format(_selectNascimento)}',
                    ),
                  ),
                  FlatButton
                  (
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    child: Text
                    (
                      'Selecionar Data de Nascimento',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: _showDatePicker,
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [           
                RaisedButton
                  (
                    child: Text('Novo Paciente',style: TextStyle(color: Colors.white),),
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).textTheme.button.color,
                    onPressed: ()
                    {
                      _submitForm();
                    },
                  ),
                ],
              ),
            ),
          ]
        ),
      ),
    );
  }
}