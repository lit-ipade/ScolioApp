import 'package:flutter/material.dart';
import '../models/pacientes.dart';
import 'package:intl/intl.dart';
import '../main.dart';

class PacienteList extends StatelessWidget {

  final List<Paciente> pacientes;
  final void Function(String) onDelete;

  PacienteList(this.pacientes, this.onDelete);

  void _selectTela(BuildContext context, Paciente paciente)
  {
    Navigator.of(context).push
    (
      MaterialPageRoute
      (
        builder:(_)
        {
          return ListaConsulta(paciente.avaliacoesHistorico);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      child: pacientes.isEmpty ? Column
      (
        children: <Widget>
        [
          SizedBox(height:20),
          Text
          (
            'Nenhum Paciente cadastrado.',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(height:20),
          Container(
            height: 200,
            child: Image.asset(
              'assets/images/waiting.png',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ) : ListView.builder
      (
        itemCount: pacientes.length,
        itemBuilder: (ctx, index)
        {
         final tr = pacientes[index];
          return GestureDetector(
            onTap: ()
            {
              _selectTela(context, pacientes[index]);
            },
            child: Card
            (
              elevation: 5,
              child: ListTile
              (
                leading: CircleAvatar
                (
                  radius: 30,
                  child: Padding
                  (
                    padding: const EdgeInsets.all(5.0),
                    child: FittedBox
                    (
                      child:
                      (
                        Text
                        (
                          tr.sexo
                        )
                      ),
                    ),
                  ),
                ),
                title: Text
                (
                  tr.nome,
                  style: Theme.of(context).textTheme.headline6,
                ),
                subtitle: Text
                (
                  DateFormat('d MMM y').format(tr.nascimento),
                ),
                trailing: IconButton
                (
                  icon: Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                  onPressed: () => onDelete(tr.id),
                ),
              ),
            ),
          );
        },
      )
    );
  }
}