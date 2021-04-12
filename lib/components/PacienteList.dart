import 'package:flutter/material.dart';
import '../models/pacientes.dart';
import '../main.dart';
import 'PacienteItem.dart';

class PacienteList extends StatefulWidget {

  final List<Paciente> pacientes;
  final void Function(int) onDelete;

  PacienteList(this.pacientes, this.onDelete);

  @override
  _PacienteListState createState() => _PacienteListState();
}

class _PacienteListState extends State<PacienteList> {
  void _selectTela(BuildContext context, Paciente paciente)
  {
    Navigator.of(context).push
    (
      MaterialPageRoute
      (
        builder:(_)
        {
          return ListaConsulta(paciente);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      child: widget.pacientes.isEmpty ? Column
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
        itemCount: widget.pacientes.length,
        itemBuilder: (ctx, index)
        {
          final tr = widget.pacientes[index];
          return PacienteView(tr,_selectTela,widget.onDelete);
        },
      )
    );
  }
}