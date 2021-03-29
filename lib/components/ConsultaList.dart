import 'package:flutter/material.dart';
import '../models/avaliacao.dart';
import 'package:intl/intl.dart';

class ConsultaList extends StatefulWidget 
{

  List<Avaliacao> consultas;
  final void Function(String) onDelete; 
  final void Function(Avaliacao) mostrarConsulta;
  
  
  ConsultaList(this.consultas, this.onDelete, this.mostrarConsulta);

  @override
  _ConsultaListState createState() => _ConsultaListState();
}

class _ConsultaListState extends State<ConsultaList> {


  _criarLista()
  {
    if(widget.consultas == null)
    {
      widget.consultas = [];
    }
    else
    {
      return;
    }
  }

  @override
  Widget build(BuildContext context) 
  {
    _criarLista();
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      child: 
      widget.consultas.isEmpty ? Column
      (
        children: <Widget>
        [
          SizedBox(height:20),
          Text
          (
            'Nenhuma Consulta Cadastrada.',
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
        itemCount: widget.consultas.length,
        itemBuilder: (ctx, index)
        {
         final tr = widget.consultas[index];
          return GestureDetector(
            onTap: ()
            {
              widget.mostrarConsulta(tr);
            },
            child: Card
            (
              elevation: 5,
              child: ListTile
              (
                leading: CircleAvatar
                (
                  radius: 25,
                  child: Padding
                  (
                    padding: const EdgeInsets.all(5.0),
                    child: FittedBox
                    (
                      child:
                      Icon(Icons.receipt),
                    ),
                  ),
                ),
                title: Text
                (
                  'Consulta do dia: ${tr.data}',
                  style: Theme.of(context).textTheme.headline6,
                ),
                trailing: IconButton
                (
                  icon: Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                  onPressed: () => widget.onDelete(tr.id),
                ),
              ),
            ),
          );
        },
      )
    );
  }
}