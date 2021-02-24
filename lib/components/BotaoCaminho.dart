import 'package:flutter/material.dart';

class BotaoCaminho extends StatelessWidget {

  final String titulo;
  final Color cor;
  final Widget caminho;
  const BotaoCaminho(this.titulo, this.cor, this.caminho);

  void _selectTela(BuildContext context)
  {
    Navigator.of(context).push
    (
      MaterialPageRoute
      (
        builder:(_)
        {
          return caminho;
        },
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0,3.0,0.0,3.0),
      child: InkWell
        (
          onTap: () => _selectTela(context),
          splashColor: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(5),
          child: Container
          (
            width: MediaQuery.of(context).size.width * 0.7,
            padding: EdgeInsets.all(15),
            child: Text
            (
              titulo,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            decoration: BoxDecoration
            (
              borderRadius: BorderRadius.circular(5),
              color: cor,
              ),
            ),
      ),
    );
  }
}