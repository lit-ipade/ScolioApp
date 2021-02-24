import 'package:flutter/material.dart';
import 'package:scolioapp/models/avaliacao.dart';
import '../models/avaliacao.dart';
import '../models/pacientes.dart';

class ResultadoConsulta extends StatelessWidget {
  final Avaliacao consulta;

  ResultadoConsulta(this.consulta);

  _desnivelOmbro(Avaliacao consulta)
  {
    String resposta = '';
    consulta.desnivelOmbro ? resposta = 'Sim' : resposta = 'Não';
    return resposta;
  }

  _desnivelBacia(Avaliacao consulta)
  {
    String resposta = '';
    consulta.desnivelBacia ? resposta = 'Sim' : resposta = 'Não';
    return resposta;
  }

  _gibosidade(Avaliacao consulta)
  {
    String resposta = '';
    consulta.gibosidade ? resposta = 'Sim' : resposta = 'Não';
    return resposta;
  }

  _radiografia(Avaliacao consulta)
  {
    String resposta = '';
    consulta.radiografia ? resposta = 'Sim' : resposta = 'Não';
    return resposta;
  }

  _anguloCobb(Avaliacao consulta)
  {
    String resposta = '';
    if(consulta.anguloCobb == 0)
    {
      resposta = 'Ângulo Cobb não informado na consulta';
    }
    else if(consulta.anguloCobb == 1) 
    {
      resposta = '10° a 25°';
    }
    else if(consulta.anguloCobb == 2)
    {
      resposta = '25° a 40°';
    }
    else if(consulta.anguloCobb == 3)
    {
      resposta = 'Mais que 40°';
    } 
    return resposta;
  }

  _maturidadeEsqueletica(Avaliacao consulta)
  {
    String resposta = '';
    if(consulta.maturidadeEsqueletica == 0)
    {
      resposta = 'Risser não informado.';
    }
    else if(consulta.maturidadeEsqueletica == 1) 
    {
      resposta = 'Risser 0, I, II';
    }
    else if(consulta.maturidadeEsqueletica == 2)
    {
      resposta = 'Risser III, IV, V';
    }
    return resposta;
  }
  @override
  Widget build(BuildContext context) 
  {
    {
      return AlertDialog
      (
        title: Text('Dados da Consulta',style: TextStyle(color: Colors.red),),
        content: Text('Desnivelamento de ombro: ' + _desnivelOmbro(consulta) + '\n' + '\n' + 'Desnivelamento de bacia: ' + _desnivelBacia(consulta) + '\n' + '\n' + 'Gibosidade: ' + _gibosidade(consulta) + '\n' +'\n' + 'Radiografia: ' + _radiografia(consulta) + '\n' + '\n'+ 'Ângulo de Cobb: ' + _anguloCobb(consulta) + '\n' + '\n'+ 'Maturidade Esquelética: '+ _maturidadeEsqueletica(consulta) + '\n'+ '\n',textAlign: TextAlign.justify,),
        actions: <Widget>
        [
          FlatButton
          (
            child: Text("Fechar"),
            onPressed: () {Navigator.of(context).pop();},
          )
        ],
      );
    }
  }
}