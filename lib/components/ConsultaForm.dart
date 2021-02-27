import 'package:flutter/material.dart';
import 'dart:ui';

class ConsultaForm extends StatefulWidget {
  final void Function(bool ,bool ,bool, bool, int, int) onSubmit;

  ConsultaForm(this.onSubmit);

  @override
  _ConsultaFormState createState() => _ConsultaFormState();
}

enum SimouNao {t, f}

class _ConsultaFormState extends State<ConsultaForm> {

  bool desnivelOmbro = false;
  bool desnivelBacia = false;
  bool gibosidade = false;
  bool radiografia = false;
  int angulo = 0;
  int maturidade = 0;

  _submitForm(int telaSelecionada)
  {
    if(telaSelecionada == 3)
    {
      widget.onSubmit(desnivelOmbro ,desnivelBacia ,gibosidade ,radiografia = false ,angulo ,maturidade );
    }
    else
    {
      widget.onSubmit(desnivelOmbro,desnivelBacia,gibosidade,radiografia,angulo,maturidade);
    }
  }
  var telaSelecionada = 0;
  @override
  Widget build(BuildContext context) 
  {
  
  final botoes =
  [
    FloatingActionButton
    (
      child: Icon(Icons.keyboard_arrow_right),
      onPressed: ()
      {
        setState(() 
        {
          if(telaSelecionada == 1)
          {
            if(desnivelBacia || desnivelOmbro || gibosidade)
            {
              telaSelecionada++;
            }
            else
            {
              return;
            }
          }
          else if(telaSelecionada == 2)
            {
              if(radiografia)
              {
                telaSelecionada = 4;
              }
              else
              {
                telaSelecionada++;
              }
            }
          else
          {
            telaSelecionada++;
          }
          if(telaSelecionada == 7)
          {
            if(maturidade == 1)
            {
              {
                setState(() 
                {
                  telaSelecionada = 8;
                });
              }
            }
            if(maturidade == 2)
            {
              {
                setState(() 
                {
                  telaSelecionada = 11;
                });
              }
            }
            else
            {
              return;
            }
          }
        });
      },
    ),
    FloatingActionButton
    (
      child: Icon(Icons.keyboard_arrow_left),
      onPressed: ()
      {
        if(telaSelecionada == 4)
        {
        setState(() 
          {
            telaSelecionada = 2;
          });
        }
        
        else if(telaSelecionada == 6)
        {
          setState(() 
          {
            telaSelecionada = 4;
          }); 
        }
        else if(telaSelecionada == 7)
        { 
          setState(() 
            {
              maturidade = 0;
              telaSelecionada--;
            });
        }
        else if(telaSelecionada == 9)
        {
          setState(() 
          {
            telaSelecionada = 6;
          });
        }
        else if(telaSelecionada == 10)
        {
          setState(() 
          {
            telaSelecionada = 6;
          });
        }
        else if(telaSelecionada == 11)
        {
          setState(() 
          {
            telaSelecionada = 7;
          });
        }
        else
        {
          setState(() 
        {
          telaSelecionada--;
        });
        }
      },
    ),
    FloatingActionButton
    (
      child: Icon(Icons.send),
      onPressed: ()
      {
        _submitForm(telaSelecionada);
      },
    ),
  ];

  final telas = 
  [
    // -------------------------------------------------------------- Tela 0 ------------------------------------------------------------    
    Scaffold
    (
      appBar: AppBar
      (
        title: Text('Cadastro de Consulta'),
      ),
      body: 
      SingleChildScrollView
      (
        child: Column
        (
          children: <Widget>
          [  
            Container
            (
              height: MediaQuery.of(context).size.height * 0.9,
              child: Image.asset('assets/Scolioapp.png'),
            ),
          ], 
        ),
      ),
      floatingActionButton: botoes[0],
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    ),
    // -------------------------------------------------------------- Tela 1 ------------------------------------------------------------
    Scaffold
    (
      appBar: AppBar
      (
        title: Text('Cadastro de Consulta'),
      ),
      body: 
      SingleChildScrollView
      (
        child: Column
        (
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>
          [  
            Padding
            (
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Text('Desnivelamento de ombro: '),
            ),
            Row
            (
              children: <Widget>
              [
                Expanded
                (
                  child: ListTile
                  (
                    title: const Text('Sim'),
                    leading: Radio
                    (
                      value: true,
                      groupValue: desnivelOmbro,
                      onChanged: (t) 
                      {
                        setState
                        (() 
                          {
                            desnivelOmbro = true;
                          }
                        );
                      },
                    ),
                  ),
                ),
                Expanded
                (
                  child: ListTile
                  (
                    title: const Text('Não'),
                    leading: Radio
                    (
                      value: false,
                      groupValue: desnivelOmbro,
                      onChanged: (f) 
                      {
                        setState
                        (() 
                          {
                            desnivelOmbro = false;
                          }
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            Padding
            (
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Text('Desnivelamento de bacia: '),
            ),
            Row
            (
             children: <Widget>
              [
                Expanded
                (
                  child: ListTile
                  (
                    title: const Text('Sim'),
                    leading: Radio
                    (
                      value: true,
                      groupValue: desnivelBacia,
                      onChanged: (t) 
                      {
                        setState
                        (() 
                          {
                            desnivelBacia = true;
                          }
                        );
                      },
                    ),
                  ),
                ),
                Expanded
                (
                  child: ListTile
                  (
                    title: const Text('Não'),
                    leading: Radio
                    (
                      value: false,
                      groupValue: desnivelBacia,
                      onChanged: (t) 
                      {
                        setState
                        (() 
                          {
                            desnivelBacia = false;
                          }
                        );
                      },
                    ),
                  ),
                ),
              ], 
            ),
            Padding
            (
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Text('Gibosidade: '),
            ),
            Row
            (
             children: <Widget>
              [
                Expanded
                (
                  child: ListTile
                  (
                    title: const Text('Sim'),
                    leading: Radio
                    (
                      value: true,
                      groupValue: gibosidade,
                      onChanged: (t) 
                      {
                        setState
                        (() 
                          {
                            gibosidade = true;
                          }
                        );
                      },
                    ),
                  ),
                ),
                Expanded
                (
                  child: ListTile
                  (
                    title: const Text('Não'),
                    leading: Radio
                    (
                      value: false,
                      groupValue: gibosidade,
                      onChanged: (t) 
                      {
                        setState
                        (() 
                          {
                            gibosidade = false;
                          }
                        );
                      },
                    ),
                  ),
                ),
              ], 
            ),
          ],
        ),
      ),
      floatingActionButton: Stack
      (
        children: <Widget>
        [
          Align
            (
              alignment: Alignment.bottomRight,
              child: botoes[0],
            ),
          Padding
          (
            padding: EdgeInsets.fromLTRB(31,0,0,0),
            child: Align
            (
              alignment: Alignment.bottomLeft,
              child: botoes[1],            
            ),
          ),
        ]
      ),
    ),
    // -------------------------------------------------------------- Tela 2 ------------------------------------------------------------    
    Scaffold
    (
      appBar: AppBar
      (
        title: Text('Cadastro de Consulta'),
      ),
      body: 
      SingleChildScrollView
      (
        child: Column
        (        
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>
          [  
            Padding
            (
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Text('Radiografia panorâmica de coluna: '),
            ),
            Row
            (
             children: <Widget>
              [
                Expanded
                (
                  child: ListTile
                  (
                    title: const Text('Sim'),
                    leading: Radio
                    (
                      value: true,
                      groupValue: radiografia,
                      onChanged: (t) 
                      {
                        setState
                        (() 
                          {
                            radiografia = true;
                          }
                        );
                      },
                    ),
                  ),
                ),
                Expanded
                (
                  child: ListTile
                  (
                    title: const Text('Não'),
                    leading: Radio
                    (
                      value: false,
                      groupValue: radiografia,
                      onChanged: (t) 
                      {
                        setState
                        (() 
                          {
                            radiografia = false;
                          }
                        );
                      },
                    ),
                  ),
                ),
              ], 
            ),
          ], 
        ),
      ),
      floatingActionButton: Stack
      (
        children: <Widget>
        [
          Align
            (
              alignment: Alignment.bottomRight,
              child: botoes[0],
            ),
          Padding
          (
            padding: EdgeInsets.fromLTRB(31,0,0,0),
            child: Align
            (
              alignment: Alignment.bottomLeft,
              child: botoes[1],            
            ),
          ),
        ]
      ),
    ),
    //--------------------------------------------------------------------------------- Tela 3 ------------------------------------------------------------------------
    Scaffold
    (
      appBar: AppBar
      (
        title: Text('Cadastro de Consulta'),
      ),
      body: 
      SingleChildScrollView
      (
        child: Column
        (        
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>
          [
            Container(
            alignment: Alignment.center,
            child: 
              Padding
                (
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: Text('Radiografia panorâmica de coluna: '),
                ),
            ),
            Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3),
                child: InkWell
                (
                  onTap: () => _submitForm(telaSelecionada),
                  splashColor: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(5),
                  child: Container
                  (
                    width: MediaQuery.of(context).size.width * 0.7,
                    padding: EdgeInsets.all(15),
                    child: Text
                    (
                      'Solicitar Radiografia',
                      textAlign: TextAlign.center,
                      style: TextStyle
                      (
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    decoration: BoxDecoration
                    (
                      borderRadius: BorderRadius.circular(5),
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: botoes[1],
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    ),
    //------------------------------------------------------------------------Tela 4 ------------------------------------------------------------
    Scaffold
    (
      appBar: AppBar
      (
        title: Text('Cadastro de Consulta'),
      ),
      body: 
      SingleChildScrollView
      (
        child: Column
        (        
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>
          [
            Container
            (
            alignment: Alignment.center,
            child: 
              Padding
                (
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: Text('Ângulo de Cobb: '),
                ),
            ),
            Container
            (
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
              child: InkWell
              (
                onTap: (){           
                            setState(() 
                            {
                              telaSelecionada = 5;
                            });
                          },
                splashColor: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(5),
                child: Container
                (
                  width: MediaQuery.of(context).size.width * 0.7,
                  padding: EdgeInsets.all(15),
                  child: Text
                  (
                    'Informações',
                    textAlign: TextAlign.center,
                    style: TextStyle
                    (
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  decoration: BoxDecoration
                  (
                    borderRadius: BorderRadius.circular(5),
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            Container
            (
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
              child: InkWell
              (
                onTap: (){           
                            setState(() 
                            {
                              telaSelecionada = 6;
                            });
                          },
                splashColor: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(5),
                child: Container
                (
                  width: MediaQuery.of(context).size.width * 0.7,
                  padding: EdgeInsets.all(15),
                  child: Text
                  (
                    'Ja sei medir o Ângulo',
                    textAlign: TextAlign.center,
                    style: TextStyle
                    (
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  decoration: BoxDecoration
                  (
                    borderRadius: BorderRadius.circular(5),
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: botoes[1],
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    ),
    //--------------------------------------------------------------------------------- Tela 5 -----------------------------------------------------------//
    Scaffold
    (
      appBar: AppBar
      (
        title: Text('Cadastro de Consulta'),
      ),
      body: 
      SingleChildScrollView
      (
        child: Column
        (
          children: <Widget>
          [  
            Container
            (
              height: MediaQuery.of(context).size.height * 0.9,
              child: Image.asset('assets/AnguloCobb.png'),
            ),
          ], 
        ),
      ),
      floatingActionButton: botoes[1],
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    ),
    //----------------------------------------------------------------------------- Tela 6 --------------------------------------------------------------------//
    Scaffold
    (
      appBar: AppBar
      (
        title: Text('Cadastro de Consulta'),
      ),
      body: 
      SingleChildScrollView
      (
        child: Column
        (        
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>
          [
            Container
            (
            alignment: Alignment.center,
            child: 
              Padding
                (
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: Text('Ângulo de Cobb: '),
                ),
            ),
            Container
            (
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
              child: InkWell
              (
                onTap: (){
                            setState(() 
                            {
                                angulo = 1;
                                telaSelecionada = 9;
                            });
                          },
                splashColor: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(5),
                child: Container
                (
                  width: MediaQuery.of(context).size.width * 0.7,
                  padding: EdgeInsets.all(15),
                  child: Text
                  (
                    '10° a 25°',
                    textAlign: TextAlign.center,
                    style: TextStyle
                    (
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  decoration: BoxDecoration
                  (
                    borderRadius: BorderRadius.circular(5),
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            Container
            (
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
              child: InkWell
              (
                onTap: () {
                          setState(() 
                          {
                              angulo = 2;
                              telaSelecionada = 7;
                            });
                          },
                splashColor: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(5),
                child: Container
                (
                  width: MediaQuery.of(context).size.width * 0.7,
                  padding: EdgeInsets.all(15),
                  child: Text
                  (
                    '25° a 40°',
                    textAlign: TextAlign.center,
                    style: TextStyle
                    (
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  decoration: BoxDecoration
                  (
                    borderRadius: BorderRadius.circular(5),
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            Container
            (
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
              child: InkWell
              (
                onTap: () {
                          setState(() 
                          {
                              angulo = 3;
                              telaSelecionada = 10;
                            });
                          },
                splashColor: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(5),
                child: Container
                (
                  width: MediaQuery.of(context).size.width * 0.7,
                  padding: EdgeInsets.all(15),
                  child: Text
                  (
                    'Mais que 40°',
                    textAlign: TextAlign.center,
                    style: TextStyle
                    (
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  decoration: BoxDecoration
                  (
                    borderRadius: BorderRadius.circular(5),
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: botoes[1],
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    ),  

  // --------------------------------------------------------------------------- Tela 7 --------------------------------------------------  
    Scaffold
    (
      appBar: AppBar
      (
        title: Text('Cadastro de Consulta'),
      ),
      body: 
      SingleChildScrollView
      (
        child: Column
        (        
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>
          [  
            Padding
            (
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Text('Maturidade Esquelética: '),
            ),
            Container
            (
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
              child: InkWell
              (
                onTap: (){           
                          maturidade = 1;
                            setState(() 
                            {
                              telaSelecionada = 8;
                            });
                          },
                splashColor: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(5),
                child: Container
                (
                  width: MediaQuery.of(context).size.width * 0.7,
                  padding: EdgeInsets.all(15),
                  child: Text
                  (
                    'Risser 0, I, II',
                    textAlign: TextAlign.center,
                    style: TextStyle
                    (
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  decoration: BoxDecoration
                  (
                    borderRadius: BorderRadius.circular(5),
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            Container
            (
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
              child: InkWell
              (
                onTap: (){           
                          maturidade = 2;
                          setState(() 
                          {
                            telaSelecionada = 11;
                          });
                          },
                splashColor: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(5),
                child: Container
                (
                  width: MediaQuery.of(context).size.width * 0.7,
                  padding: EdgeInsets.all(15),
                  child: Text
                  (
                    'Risser III, IV, V',
                    textAlign: TextAlign.center,
                    style: TextStyle
                    (
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  decoration: BoxDecoration
                  (
                    borderRadius: BorderRadius.circular(5),
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ], 
        ),
      ),
      floatingActionButton: Stack
      (
        children: <Widget>
        [
          Align
            (
              alignment: Alignment.bottomRight,
              child: botoes[0],
            ),
          Padding
          (
            padding: EdgeInsets.fromLTRB(31,0,0,0),
            child: Align
            (
              alignment: Alignment.bottomLeft,
              child: botoes[1],            
            ),
          ),
        ]
      ),
    ),
    //--------------------------------------------------------------------------Tela 8 ---------------------------------------------------------------------
    Scaffold
    (
      appBar: AppBar
      (
        title: Text('Cadastro de Consulta'),
      ),
      body: 
      SingleChildScrollView
      (
        child: Column
        (
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>
          [  
            Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
              child: Padding
              (
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Text('Indicar o uso de órtese (colete)'),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
              child: Padding
              (
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Text('Encaminhar ao especialista para escolha do tipo de órtese e acompanhamento do uso.'),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Stack
      (
        children: <Widget>
        [
          Align
            (
              alignment: Alignment.bottomRight,
              child: botoes[2],
            ),
          Padding
          (
            padding: EdgeInsets.fromLTRB(31,0,0,0),
            child: Align
            (
              alignment: Alignment.bottomLeft,
              child: botoes[1],            
            ),
          ),
        ]
      ),
    ),
    //-----------------------------------------------------------------------Tela 9 -----------------------------------------------------------
    Scaffold
    (
      appBar: AppBar
      (
        title: Text('Cadastro de Consulta'),
      ),
      body: 
      SingleChildScrollView
      (
        child: Column
        (
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>
          [  
            Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
              child: Padding
              (
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Text('Seguimento ambulatorial com Rx periódico'),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
              child: Padding
              (
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Text('Orientar para realização de atividades físicas e fisioterapia.'),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Stack
      (
        children: <Widget>
        [
          Align
            (
              alignment: Alignment.bottomRight,
              child: botoes[2],
            ),
          Padding
          (
            padding: EdgeInsets.fromLTRB(31,0,0,0),
            child: Align
            (
              alignment: Alignment.bottomLeft,
              child: botoes[1],            
            ),
          ),
        ]
      ),
    ),
    //------------------------------------------------------------------------Tela 10------------------------------------------------------------------------
    Scaffold
    (
      appBar: AppBar
      (
        title: Text('Cadastro de Consulta'),
      ),
      body: 
      SingleChildScrollView
      (
        child: Column
        (
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>
          [  
            Center(child: Text('Encaminhar para especialista para avaliar a possibilidade de tratamento cirúrgico')),
          ],
        ),
      ),
      floatingActionButton: Stack
      (
        children: <Widget>
        [
          Align
            (
              alignment: Alignment.bottomRight,
              child: botoes[2],
            ),
          Padding
          (
            padding: EdgeInsets.fromLTRB(31,0,0,0),
            child: Align
            (
              alignment: Alignment.bottomLeft,
              child: botoes[1],            
            ),
          ),
        ]
      ),
    ),
    //----------------------------------------------------------------------------- Tela 11 ------------------------------------------------------
    Scaffold
    (
      appBar: AppBar
      (
        title: Text('Cadastro de Consulta'),
      ),
      body: 
      SingleChildScrollView
      (
        child: Column
        (
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>
          [  
            Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
              child: Padding
              (
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Text('Seguimento ambulatorial com Rx periódico'),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
              child: Padding
              (
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Text('Orientar para realização de atividades físicas e fisioterapia.'),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Stack
      (
        children: <Widget>
        [
          Align
            (
              alignment: Alignment.bottomRight,
              child: botoes[2],
            ),
          Padding
          (
            padding: EdgeInsets.fromLTRB(31,0,0,0),
            child: Align
            (
              alignment: Alignment.bottomLeft,
              child: botoes[1],            
            ),
          ),
        ]
      ),
    ),
  ];
    return telas[telaSelecionada];
  }
} 