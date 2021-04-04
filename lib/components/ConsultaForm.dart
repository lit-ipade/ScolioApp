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
  final tamanhoTela = MediaQuery.of(context).size.width;
  final botoes =
  [
    FloatingActionButton
    (
      child: Icon(Icons.keyboard_arrow_right),
      onPressed: ()
      {
        setState(() 
        {
          if(telaSelecionada == 0)
          {
            if(desnivelBacia || desnivelOmbro || gibosidade)
            {
              telaSelecionada = 1;
            }
            else
            {
              return;
            }
          }
          else if(telaSelecionada == 1)
            {
              if(radiografia)
              {
                telaSelecionada = 3;
              }
              else
              {
                telaSelecionada = 2;
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
        if(telaSelecionada == 3)
        {
        setState(() 
          {
            telaSelecionada = 1;
          });
        }
        
        else if(telaSelecionada == 5)
        {
          setState(() 
          {
            telaSelecionada = 4;
          }); 
        }
        else if(telaSelecionada == 6)
        { 
          setState(() 
            {
              maturidade = 0;
              telaSelecionada = 5;
            });
        }
        else if(telaSelecionada == 7)
        {
          setState(() 
          {
            maturidade = 0;
            telaSelecionada = 5;
          });
        }
        else if(telaSelecionada == 8)
        {
          setState(() 
          {
            telaSelecionada = 4;
          });
        }
        else if(telaSelecionada == 9)
        {
          setState(() 
          {
            telaSelecionada = 4;
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>
          [  
            Padding
            (
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Text('Desnivelamento de ombro: ', textAlign: TextAlign.center, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
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
              child: Text('Desnivelamento de bacia: ', textAlign: TextAlign.center, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
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
              child: Text('Gibosidade: ', textAlign: TextAlign.center, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
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
            Container
            (
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
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
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Text('Radiografia panorâmica de coluna: ',textAlign: TextAlign.center, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Row
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
            ),
            Container
            (
              height: tamanhoTela,
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Image.asset('assets/Coluna.png'),
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
    //--------------------------------------------------------------------------------- Tela 2 ------------------------------------------------------------------------
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
                  child: Text('Radiografia panorâmica de coluna: ',textAlign: TextAlign.center, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                ),
            ),
            Center(
              child: Container(
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
            ),
          ],
        ),
      ),
      floatingActionButton: botoes[1],
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    ),
    //------------------------------------------------------------------------Tela 3 ------------------------------------------------------------
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
                  child: Text('Ângulo de Cobb: ', textAlign: TextAlign.center, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
                ),
            ),
            Container
            (
              padding: EdgeInsets.fromLTRB(0,tamanhoTela * 0.4 ,0,0),
              child: Image.asset('assets/AnguloCobb.png'),
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
    //----------------------------------------------------------------------------- Tela 4 --------------------------------------------------------------------//
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
                  child: Text('Ângulo de Cobb: ', textAlign: TextAlign.center, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
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
                    '26° a 40°',
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

  // --------------------------------------------------------------------------- Tela 5 --------------------------------------------------  
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
              child: Text('Maturidade Esquelética: ', textAlign: TextAlign.center, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
            ),
            Container
            (
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
              child: InkWell
              (
                onTap: (){           
                          maturidade = 1;
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
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
              child: InkWell
              (
                onTap: (){           
                          maturidade = 2;
                          setState(() 
                          {
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
            Container
            (
              padding: EdgeInsets.fromLTRB(8, 20, 8, 0),
              child: Image.asset('assets/Risser.png'),
            ),
          ], 
        ),
      ),
      floatingActionButton: Stack
      (
        children: <Widget>
        [
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
    //--------------------------------------------------------------------------Tela 6 ---------------------------------------------------------------------
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
                padding: const EdgeInsets.all(8),
                child: Center(child: Text('Indicar o uso de órtese (colete)', textAlign: TextAlign.center, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),)),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
              child: Padding
              (
                padding: EdgeInsets.all(8),
                child: Center(child: Text('Encaminhar ao especialista para escolha do tipo de órtese e acompanhamento do uso.', textAlign: TextAlign.center, style: TextStyle(fontSize: 20),)),
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
    //-----------------------------------------------------------------------Tela 7 -----------------------------------------------------------
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
                padding: const EdgeInsets.all(8),
                child: Center(child:Text('Seguimento ambulatorial com Rx periódico semestral', textAlign: TextAlign.center, style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),)),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
              child: Padding
              (
                padding: const EdgeInsets.all(8),
                child: Center(child: Text('Orientar para realização de atividades físicas e fisioterapia.', textAlign: TextAlign.center, style: TextStyle(fontSize: 18),)),
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
    //------------------------------------------------------------------------Tela 8------------------------------------------------------------------------
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>
          [  
            Padding(
              padding:  EdgeInsets.fromLTRB(8,MediaQuery.of(context).size.height * 0.35,8,0),
              child: Text('Encaminhar para especialista para avaliar a possibilidade de tratamento cirúrgico', textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600), ),
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
    //----------------------------------------------------------------------------- Tela 9 ------------------------------------------------------
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
                child: Center(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Seguimento ambulatorial com Rx periódico semestral', textAlign: TextAlign.center, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                )),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
              child: Padding
              (
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Center(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Orientar para realização de atividades físicas e fisioterapia.', textAlign: TextAlign.center, style: TextStyle(fontSize: 18),),
                )),
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