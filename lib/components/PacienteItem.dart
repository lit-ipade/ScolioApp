import 'package:flutter/material.dart';
import 'package:scolioapp/models/pacientes.dart';
import 'package:intl/intl.dart';

class PacienteView extends StatelessWidget {

  final Paciente infoPaciente;
  final void Function(BuildContext,Paciente) _selectTela;
  final void Function(String) onDelete;

  PacienteView(this.infoPaciente,this._selectTela,this.onDelete);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
            onTap: ()
            {
              _selectTela(context, infoPaciente);
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
                          infoPaciente.sexo
                        )
                      ),
                    ),
                  ),
                ),
                title: Text
                (
                  infoPaciente.nome,
                  style: Theme.of(context).textTheme.headline6,
                ),
                subtitle: Text
                (
                  infoPaciente.nascimento,
                ),
                trailing: IconButton
                (
                  icon: Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                  onPressed: () => onDelete(infoPaciente.id),
                ),
              ),
            ),
          );
  }
}