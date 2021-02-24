import 'package:flutter/material.dart';
import '../models/avaliacao.dart';
import 'package:intl/intl.dart';

class ConsultaList extends StatelessWidget 
{

  List<Avaliacao> consultas;
  final void Function(String) onDelete; 
  final void Function(Avaliacao) mostrarConsulta;
  
  
  ConsultaList(this.consultas, this.onDelete, this.mostrarConsulta);

  _criarLista()
  {
    if(consultas == null)
    {
      consultas = [];
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
      consultas.isEmpty ? Column
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
        itemCount: consultas.length,
        itemBuilder: (ctx, index)
        {
         final tr = consultas[index];
          return GestureDetector(
            onTap: ()
            {
              mostrarConsulta(tr);
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
                      Text
                        (
                         DateFormat('d MMM y').format(tr.data),
                        ),
                    ),
                  ),
                ),
                title: Text
                (
                  'nada',//tr.nome,
                  style: Theme.of(context).textTheme.headline6,
                ),
                subtitle: Text
                (
                  DateFormat('d MMM y').format(tr.data),
                ),
                trailing: IconButton
                (
                  icon: Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                  onPressed: null,// () => onDelete(tr.id),
                ),
              ),
            ),
          );
        },
      )
    );
  }
}