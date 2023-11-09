int R[][]=new int[8][8]; //Matriz del tablero
String Posiciones[]= new String[8]; //Arreglo de posiciones de las reinas.

void setup() {
  size(704, 704); //Crea tablero.
  background(255, 255, 255); //Fondo blanco.
  int x1 = 0, y1 = 0; //x son las posiciones sólo de la primera fila. y son de todas las columnas pares.
  int x2 = 88, y2 = 0; //x altera la primera fila. y son todas las columnas impares.
  
  for (int i=0; i < 8; i++) { //Empieza for para pintar el tablero.
    for (int j=0; j< 4; j++) {
      if (i%2 == 0) { //Función para colocar los cuadros intercalados.
        drawRect(x1, y1, x2, y2);
      } else {
        drawRect(x2, y2, x1, y1);
      }
      x1 += 176;
      x2 += 176;
    }
    x1 = 0;
    x2 = 88;
    y1 += 88;
    y2 += 88;
  } //Termina for.
  
  //Parte para colocar la primera reina y agregar sus coordenadas en una lista.
  //int x = 0;
  //int y = 0;
  
    //R[y][x]=1; //R[y][x]

  //Posiciones[0] = x + "," + y; 
  
  proceso(Posiciones, R); //<>//
  //System.out.print(Posiciones[7]);

}

void proceso(String Posiciones[], int R[][]){
  //Variables locales
  //int PosReinaString = 0; //Posición de las Reinas en el String. //<>//
  String AuxCoord;
  
  int x = 0;
  int y = 0;
  while(!estaCompleto(Posiciones)){
    if(R[y][x] == 0){
      R[y][x] = 1;
      pushPila(Posiciones, x+","+y);
      ponerAtaques(R, x, y); //Se le pasan las coordenadas de la reina.
      y++;
      x = 0;
    }
    if(R[y][x] == 2 || R[y][x] == 3 || R[y][x] == 4 || R[y][x] == 5 || R[y][x] == 6 || R[y][x] == 7 || R[y][x] == 8 || R[y][x] == 9){
      if(x == 7){
        AuxCoord = peekPila(Posiciones);
        if(separarCoordX(AuxCoord) == 7){
          x=separarCoordX(AuxCoord);
          y=separarCoordY(AuxCoord);
          quitarAtaques(R, x, y);
          R[y][x] = 0;
          popPila(Posiciones);
          AuxCoord = peekPila(Posiciones);
          x=separarCoordX(AuxCoord) + 1;
          y=separarCoordY(AuxCoord);
          quitarAtaques(R, x-1, y);
          R[y][x-1] = 0;
          popPila(Posiciones);
        } else {
          x=separarCoordX(AuxCoord) + 1;
          y=separarCoordY(AuxCoord);
          quitarAtaques(R, x-1, y);
          R[y][x-1] = 0;
          popPila(Posiciones);
        }
        
      } else {
        x++;
      }
      
    }
    /*for(int i = 0; i < 8; i++){
     for(int j = 0; j < 8; j++){
       print(R[i][j]);
     }
     println("");
    }
    println("");
    
      if(y==6){
        print("Llegué a 6"); //<>//
      }*/
  }
  
 //<>//
} //<>//

//-------- MAUSQUERRAMIENTAS QUE NOS AYUDARÁN MÁS TARDE. --------
int separarCoordX(String Pos){
  String Dividido[] = Pos.split(",");
  return Integer.parseInt(Dividido[0]);
}

int separarCoordY(String Pos){
  String Dividido[] = Pos.split(",");
  return Integer.parseInt(Dividido[1]);
}

boolean estaCompleto(String P[]){
  boolean completo = true;
  
  if(P[7] == null){
    completo = false;
    return completo;
  }
  return completo;
}
//-------- FIN DE MAUSQUERRAMIENTAS. --------

void ponerAtaques(int R[][], int x, int y){ //X y Y son de la reina.
  int xR = x;
  int yR = y;
  colocarX(R, xR, yR);
  colocarY(R, xR, yR);
  colocarDiag1(R, xR, yR);
  colocarDiag2(R, xR, yR);
  //Poner debe tomar las posiciones de la reina y dependiendo de la coordenada y, colocarás 2, 3, 4, etc.
}

void quitarAtaques(int R[][], int x, int y){ //X y Y son de la reina.
  int xR = x;
  int yR = y;
  quitarX(R, xR, yR);
  quitarY(R, xR, yR);
  quitarDiag1(R, xR, yR);
  quitarDiag2(R, xR, yR);
  //Quitar debe tomar las posiciones de la reina y dependiendo de la coordenada y, quitarás 2, 3, 4, etc.
}

void pushPila(String[] Posiciones, String Coords){
  String[] PosAux = Posiciones;
  int a = 0;
  
  if(PosAux[0] == null){
    PosAux[0] = Coords;
  } else {
   while(PosAux[a] != null && a <  7){
     a++;
   }
   if(PosAux[a] == null){
     PosAux[a] = Coords;
   }
  }
}

void popPila(String[] Posiciones){
  String[] PosAux = Posiciones;
  int a = 0;
  
  while(PosAux[a] != null && a < 7){
    a++;
  }
  if(PosAux[a] != null && a == 7){
    PosAux[a] = null;
  } else {
    PosAux[a - 1] = null;
  }
}

String peekPila(String[] Posiciones){
  String[] PosAux = Posiciones;
  int a = 0;
  
  while(PosAux[a] != null && a < 7){
    a++;
  }
  if(PosAux[a] != null && a == 7){
    return PosAux[a];
  } else {
    return PosAux[a - 1];
  }
}

//-------- ESPACIO DE COLOCAR. --------
void colocarX(int R[][], int PosxR, int PosyR){
  //Funciona iterando en la posición de la reina a cada x, sin moverse de la y.
  //Entradas directas.
  int xR = PosxR;
  int yR = PosyR;

  //Parte que calcula x.
  for(int x=0; x<8; x++){ 
    if(R[yR][x]==0 && x != xR){ 
      if(yR == 0){
        R[yR][x] = 2;
      }
      if(yR == 1){
        R[yR][x] = 3;
      }
      if(yR == 2){
        R[yR][x] = 4;
      }
      if(yR == 3){
        R[yR][x] = 5;
      }
      if(yR == 4){
        R[yR][x] = 6;
      }
      if(yR == 5){
        R[yR][x] = 7;
      }
      if(yR == 6){
        R[yR][x] = 8;
      }
      if(yR == 7){
        R[yR][x] = 9;
      }
    }
  }
}

void colocarY(int R[][], int PosxR, int PosyR){
  //Funciona iterando en la posición de la reina a cada x, sin moverse de la y.
  //Entradas directas.
  int xR = PosxR;
  int yR = PosyR;
  
  //Parte que calcula y.
  for(int y=0; y<8; y++){
    if(R[y][xR]==0 && y != yR){
      if(yR == 0){
        R[y][xR] = 2;
      }
      if(yR == 1){
        R[y][xR] = 3;
      }
      if(yR == 2){
        R[y][xR] = 4;
      }
      if(yR == 3){
        R[y][xR] = 5;
      }
      if(yR == 4){
        R[y][xR] = 6;
      }
      if(yR == 5){
        R[y][xR] = 7;
      }
      if(yR == 6){
        R[y][xR] = 8;
      }
      if(yR == 7){
        R[y][xR] = 9;
      }
    }
  }
}

void colocarDiag1(int R[][], int PosxR, int PosyR){
  //Esta función calcula la diagonal desde 0,0 hasta 7,7 (o su similar).
  //Entradas directas.
  int xR = PosxR;
  int yR = PosyR;
  
  //Variables locales;
  int restaX1 = 0; 
  int restaY1 = 0;
  int control = 0; //Variable para iterar la diagonal.
  int cuadrado = 0; //Variable para saber el tamaño la diagonal;
  int RCX = 0; //Restas de Control X.
  int RCY = 0; //Restas de Control Y.
  
  //Parte que calcula desde dónde empezar.
  if(xR<yR){ //Si x es menor que y.
    if(xR == 0){
      restaX1 = 0;
    } else {
     restaX1 = xR-xR; 
    }
   restaY1 = yR - xR;
   
  } else if(xR>yR) { //Si x es mayor que y.
    if(yR == 0){
      restaY1 = 0;
    } else {
     restaY1 = yR-yR; 
    }
   restaX1 = xR - yR;
  
  } else if(xR == yR) { //Si ambas son iguales.
    if(xR == 0 && yR == 0){
      restaX1 = 0;
      restaY1 = 0;
    } else {
      restaX1 = xR - xR;
      restaY1 = yR - yR;
    }
  }
  
  //Parte que calcula dónde terminar.
  RCX = 7 - xR;
  RCY = 7 - yR;
  
  if(RCX < RCY){
    cuadrado = (RCX + xR) - restaX1;
  } else if(RCX > RCY){
    cuadrado = (RCY + xR) - restaX1;
  } else if(RCX == RCY){
    cuadrado = (RCX + xR) - restaX1;
  }
  
  
  //Parte que recorre la matriz.
  while(control < cuadrado + 1){
    if(R[restaY1][restaX1] == 0 && restaX1 != xR && restaY1 != yR){
      if(yR == 0){
        R[restaY1][restaX1] = 2;
      }
      if(yR == 1){
        R[restaY1][restaX1] = 3;
      }
      if(yR == 2){
        R[restaY1][restaX1] = 4;
      }
      if(yR == 3){
        R[restaY1][restaX1] = 5;
      }
      if(yR == 4){
        R[restaY1][restaX1] = 6;
      }
      if(yR == 5){
        R[restaY1][restaX1] = 7;
      }
      if(yR == 6){
        R[restaY1][restaX1] = 8;
      }
      if(yR == 7){
        R[restaY1][restaX1] = 9;
      }
    }
    restaX1++;
    restaY1++;
    control++;
  }
}

void colocarDiag2(int R[][], int PosxR, int PosyR){
  //Esta función calcula la diagonal desde 0,7 hasta 7,0 (o su similar).
  //Entradas directas.
  int xR = PosxR;
  int yR = PosyR;
  
  //Variables locales;
  int auxX = 0;
  int auxY = 0;
  int restaX2 = 0; 
  int restaY2 = 0;
  int control = 0; //Variable para iterar la diagonal.
  int cuadrado = 0; //Variable para saber el tamaño la diagonal;
  int RCX = 0; //Restas de Control X.
  int RCY = 0; //Restas de Control Y.
  
  //Parte que calcula desde dónde empezar.
  auxX = xR;
  auxY = 7 - yR;
  
  if(auxX < auxY){ //Si x es menor a y.
    if(auxX == 0){
      restaX2 = xR;
      restaY2 = yR;
    } else {
      restaX2 = xR - xR;
      restaY2 = yR + xR;
    }
  } else if(auxX > auxY){ //Si x es mayor a y.
    if(yR == 7){
      restaX2 = xR;
      restaY2 = yR;
    } else {
      restaX2 = xR - auxY;
      restaY2 = yR + auxY;
    }
  } else if(auxX == auxY){ //Si ambas son iguales.
      if(xR == 0 && yR == 7){
        restaX2 = xR;
        restaY2 = yR;
      } else {
        restaX2 = xR - xR;
        restaY2 = yR + auxY;
      }
  }

  //Parte que calcula dónde terminar.
  RCX = 7 - xR;
  RCY = yR;
  
  if(RCX < RCY){
    cuadrado = (RCX + xR) - restaX2;
  } else if(RCX > RCY){
    cuadrado = (RCY + xR) - restaX2;
  } else if(RCX == RCY){
    cuadrado = (RCX + xR) - restaX2;
  }
  
  //Parte que recorre la matriz.
  while(control < cuadrado + 1){
    if(R[restaY2][restaX2] == 0 && restaX2 != xR && restaY2 != yR){
      if(yR == 0){
        R[restaY2][restaX2] = 2;
      }
      if(yR == 1){
        R[restaY2][restaX2] = 3;
      }
      if(yR == 2){
        R[restaY2][restaX2] = 4;
      }
      if(yR == 3){
        R[restaY2][restaX2] = 5;
      }
      if(yR == 4){
        R[restaY2][restaX2] = 6;
      }
      if(yR == 5){
        R[restaY2][restaX2] = 7;
      }
      if(yR == 6){
        R[restaY2][restaX2] = 8;
      }
      if(yR == 7){
        R[restaY2][restaX2] = 9;
      }
    }
    restaX2++;
    restaY2--;
    control++;
  }
}
//-------- FIN COLOCAR. --------

//-------- ESPACIO DE QUITAR. --------
void quitarX(int R[][], int PosxR, int PosyR){
  //Funciona iterando en la posición de la reina a cada x, sin moverse de la y.
  //Entradas directas.
  int xR = PosxR;
  int yR = PosyR;

  //Parte que calcula x.
  for(int x=0; x<8; x++){ 
    if(R[yR][x]!=0 && x != xR){ 
      if(yR == 0 && R[yR][x] == 2){
        R[yR][x] = 0;
      }
      if(yR == 1 && R[yR][x] == 3){
        R[yR][x] = 0;
      }
      if(yR == 2 && R[yR][x] == 4){
        R[yR][x] = 0;
      }
      if(yR == 3 && R[yR][x] == 5){
        R[yR][x] = 0;
      }
      if(yR == 4 && R[yR][x] == 6){
        R[yR][x] = 0;
      }
      if(yR == 5 && R[yR][x] == 7){
        R[yR][x] = 0;
      }
      if(yR == 6 && R[yR][x] == 8){
        R[yR][x] = 0;
      }
      if(yR == 7 && R[yR][x] == 9){
        R[yR][x] = 0;
      }
    }
  }
}

void quitarY(int R[][], int PosxR, int PosyR){
  //Funciona iterando en la posición de la reina a cada x, sin moverse de la y.
  //Entradas directas.
  int xR = PosxR;
  int yR = PosyR;
  
  //Parte que calcula y.
  for(int y=0; y<7; y++){
    if(R[y][xR]!=0 && y != yR){
      if(yR == 0 && R[y][xR] == 2){
        R[y][xR] = 0;
      }
      if(yR == 1 && R[y][xR] == 3){
        R[y][xR] = 0;
      }
      if(yR == 2 && R[y][xR] == 4){
        R[y][xR] = 0;
      }
      if(yR == 3 && R[y][xR] == 5){
        R[y][xR] = 0;
      }
      if(yR == 4 && R[y][xR] == 6){
        R[y][xR] = 0;
      }
      if(yR == 5 && R[y][xR] == 7){
        R[y][xR] = 0;
      }
      if(yR == 6 && R[y][xR] == 8){
        R[y][xR] = 0;
      }
      if(yR == 7 && R[y][xR] == 9){
        R[y][xR] = 0;
      }
    }
  }
}

void quitarDiag1(int R[][], int PosxR, int PosyR){
  //Esta función calcula la diagonal desde 0,0 hasta 7,7 (o su similar).
  //Entradas directas.
  int xR = PosxR;
  int yR = PosyR;
  
  //Variables locales;
  int restaX1 = 0; 
  int restaY1 = 0;
  int control = 0; //Variable para iterar la diagonal.
  int cuadrado = 0; //Variable para saber el tamaño la diagonal;
  int RCX = 0; //Restas de Control X.
  int RCY = 0; //Restas de Control Y.
  
  //Parte que calcula desde dónde empezar.
  if(xR<yR){ //Si x es menor que y.
    if(xR == 0){
      restaX1 = 0;
    } else {
     restaX1 = xR-xR; 
    }
   restaY1 = yR - xR;
   
  } else if(xR>yR) { //Si x es mayor que y.
    if(yR == 0){
      restaY1 = 0;
    } else {
     restaY1 = yR-yR; 
    }
   restaX1 = xR - yR;
  
  } else if(xR == yR) { //Si ambas son iguales.
    if(xR == 0 && yR == 0){
      restaX1 = 0;
      restaY1 = 0;
    } else {
      restaX1 = xR - xR;
      restaY1 = yR - yR;
    }
  }
  
  //Parte que calcula dónde terminar.
  RCX = 7 - xR;
  RCY = 7 - yR;
  
  if(RCX < RCY){
    cuadrado = (RCX + xR) - restaX1;
  } else if(RCX > RCY){
    cuadrado = (RCY + xR) - restaX1;
  } else if(RCX == RCY){
    cuadrado = (RCX + xR) - restaX1;
  }
  
  
  //Parte que recorre la matriz.
  while(control < cuadrado + 1){
    if(R[restaY1][restaX1] != 0 && restaX1 != xR && restaY1 != yR){
      if(yR == 0 && R[restaY1][restaX1] == 2){
        R[restaY1][restaX1] = 0;
      }
      if(yR == 1 && R[restaY1][restaX1] == 3){
        R[restaY1][restaX1] = 0;
      }
      if(yR == 2 && R[restaY1][restaX1] == 4){
        R[restaY1][restaX1] = 0;
      }
      if(yR == 3 && R[restaY1][restaX1] == 5){
        R[restaY1][restaX1] = 0;
      }
      if(yR == 4 && R[restaY1][restaX1] == 6){
        R[restaY1][restaX1] = 0;
      }
      if(yR == 5 && R[restaY1][restaX1] == 7){
        R[restaY1][restaX1] = 0;
      }
      if(yR == 6 && R[restaY1][restaX1] == 8){
        R[restaY1][restaX1] = 0;
      }
      if(yR == 7 && R[restaY1][restaX1] == 9){
        R[restaY1][restaX1] = 0;
      }
    }
    restaX1++;
    restaY1++;
    control++;
  }
}

void quitarDiag2(int R[][], int PosxR, int PosyR){
  //Esta función calcula la diagonal desde 0,7 hasta 7,0 (o su similar).
  //Entradas directas.
  int xR = PosxR;
  int yR = PosyR;
  
  //Variables locales;
  int auxX = 0;
  int auxY = 0;
  int restaX2 = 0; 
  int restaY2 = 0;
  int control = 0; //Variable para iterar la diagonal.
  int cuadrado = 0; //Variable para saber el tamaño la diagonal;
  int RCX = 0; //Restas de Control X.
  int RCY = 0; //Restas de Control Y.
  
  //Parte que calcula desde dónde empezar.
  auxX = xR;
  auxY = 7 - yR;
  
  if(auxX < auxY){ //Si x es menor a y.
    if(auxX == 0){
      restaX2 = xR;
      restaY2 = yR;
    } else {
      restaX2 = xR - xR;
      restaY2 = yR + xR;
    }
  } else if(auxX > auxY){ //Si x es mayor a y.
    if(yR == 7){
      restaX2 = xR;
      restaY2 = yR;
    } else {
      restaX2 = xR - auxY;
      restaY2 = yR + auxY;
    }
  } else if(auxX == auxY){ //Si ambas son iguales.
      if(xR == 0 && yR == 7){
        restaX2 = xR;
        restaY2 = yR;
      } else {
        restaX2 = xR - xR;
        restaY2 = yR + auxY;
      }
  }

  //Parte que calcula dónde terminar.
  RCX = 7 - xR;
  RCY = yR;
  
  if(RCX < RCY){
    cuadrado = (RCX + xR) - restaX2;
  } else if(RCX > RCY){
    cuadrado = (RCY + xR) - restaX2;
  } else if(RCX == RCY){
    cuadrado = (RCX + xR) - restaX2;
  }
  
  //Parte que recorre la matriz.
  while(control < cuadrado + 1){
    if(R[restaY2][restaX2] != 0 && restaX2 != xR && restaY2 != yR){
      if(yR == 0 && R[restaY2][restaX2] == 2){
        R[restaY2][restaX2] = 0;
      }
      if(yR == 1 && R[restaY2][restaX2] == 3){
        R[restaY2][restaX2] = 0;
      }
      if(yR == 2 && R[restaY2][restaX2] == 4){
        R[restaY2][restaX2] = 0;
      }
      if(yR == 3 && R[restaY2][restaX2] == 5){
        R[restaY2][restaX2] = 0;
      }
      if(yR == 4 && R[restaY2][restaX2] == 6){
        R[restaY2][restaX2] = 0;
      }
      if(yR == 5 && R[restaY2][restaX2] == 7){
        R[restaY2][restaX2] = 0;
      }
      if(yR == 6 && R[restaY2][restaX2] == 8){
        R[restaY2][restaX2] = 0;
      }
      if(yR == 7 && R[restaY2][restaX2] == 9){
        R[restaY2][restaX2] = 0;
      }
    }
    restaX2++;
    restaY2--;
    control++;
  }
}
//-------- FIN QUITAR. --------

//Funciones para los gráficos.

void drawRect(int x1, int y1, int x2, int y2) { //Pinta los cuadrados del tablero.
  fill(255, 255, 255);
  rect(x1, y1, 88, 88);
  fill(0, 0, 0);
  rect(x2, y2, 88, 88); //Cuadrados negros.
}

void draw() { //Dibuja las reinas y los cuadrados usados

  int x=0;
  int y=0;
  int xc=0;
  int yc=0;
  for (int i=0; i < 8; i++) { //Columnas
    for (int j=0; j< 8; j++) { //Filas
      if (R[i][j]==1) {
        fill(255, 0, 0);
        circle(x+44, y+44, 86);
      }
      if(R[i][j]==2 || R[i][j]==3 || R[i][j]==4 || R[i][j]==5 || R[i][j]==6 || R[i][j]==7 || R[i][j]==8 || R[i][j]==9){
        fill(0, 255, 0);
        rect(xc, yc, 88, 88);
      }
      x+=88;
      xc+=88;
    }
    x=0;
    xc=0;
    y+=88;
    yc+=88;
  }
}
