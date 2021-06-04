import 'package:flutter/material.dart';

Widget slidDimissibleLeft() {
  return Container(
    color: Colors.red[900],
    child: Padding(
      padding: const EdgeInsets.all(8.0),
          child: Row(
        mainAxisAlignment: MainAxisAlignment.start,          
        children: [
          Icon(Icons.delete, color: Colors.white),Text('Excluir',style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),)
        ],
      ),
   
    ),
  );
}


Widget slidDimissibleRight() {
  return Container(
    color: Colors.green[900],
    child: Padding(
      padding: const EdgeInsets.all(8.0),
          child: Row(
        mainAxisAlignment: MainAxisAlignment.end,      
        children: [
          Icon(Icons.edit, color: Colors.white),Text('Editar',style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ))
        ],
      ),
    
    ),
  );
}