int R[][]=new int[8][8];
String Posic[]= new String[8];
String EspaciosLibres[] = new String[16];

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
  
  //x, y
  R[4][6]=1; //Inicia la primera reina y la agrega a una lista.
  
  
  int ctrl = 0; //Variable control es la variable que indica en qué indice colocar las reinas en el String de posiciones.
  for (int i=0; i < 8; i++) { //Columnas
    for (int j=0; j< 8; j++) { //Filas
      if (R[j][i]==1) {
       Posic[ctrl] = j + "," + i; 
       ctrl++;
     }
    }
  }
  /*for(int i = 0; i < 8; i++){
  System.out.print(Posiciones[i]);
  }*/
  int reinasColocadas = 0; //O rC para los compas.
  
  System.out.print(estaLibre(Posic, R, reinasColocadas));
}

//-------- MAUSQUERRAMIENTAS QUE NOS AYUDARÁN MÁS TARDE. --------
int separarCoordX(String P[], int rC){
  String Aux = P[rC].toString();
  String Dividido[] = Aux.split(",");
  return Integer.parseInt(Dividido[0]);
}

int separarCoordY(String P[], int rC){
  String Aux = P[rC].toString();
  String Dividido[] = Aux.split(",");
  return Integer.parseInt(Dividido[1]);
}

//-------- HERRAMIENTAS DE BÚSQUEDA. --------
boolean libreX(int R[][], int PosxR, int PosyR){
//Esta función dirá si existe alguna reina en x que provoque un jaque mate.
//Funciona iterando en la posición de la reina a cada x, sin moverse de la y.
boolean libre = true;
int xR = PosxR;
int yR = PosyR;
  for(int x=0; x<8; x++){ 
    if(R[x][yR]==1 && x != xR){ 
      //Si cae aqui, significa que la reina no está libre y por lo tanto no se puede colocar ahí.
      libre = false;
      return libre;
    }
  }
  return libre;
}

boolean libreY(int R[][], int PosxR, int PosyR){
  //Esta función dirá si existe alguna reina en x que provoque un jaque mate.
  //Funciona iterando en la posición de la reina a cada x, sin moverse de la y.
boolean libre = true;
int xR = PosxR;
int yR = PosyR;
  for(int y=0; y<8; y++){
    if(R[xR][y]==1 && y != yR){
      //Si cae aqui, significa que la reina no está libre y por lo tanto no se puede colocar ahí.
      libre = false;
      return libre;
    }
  }
  return libre;
}

boolean libreDiag1(int R[][], int PosxR, int PosyR){
  //Esta función calcula la diagonal desde 0,0 hasta 7,7 (o su similar).
  //Entradas directas.
  int xR = PosxR;
  int yR = PosyR;
  
  //Variables locales;
  boolean libre = true;
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
    if(R[restaX1][restaY1] == 1 && restaX1 != xR && restaY1 != yR){
      libre = false;
      return false;
    }
    restaX1++;
    restaY1++;
    control++;
  }
  return libre;
}

boolean libreDiag2(int R[][], int PosxR, int PosyR){
  //Esta función calcula la diagonal desde 0,7 hasta 7,0 (o su similar).
  //Entradas directas.
  int xR = PosxR;
  int yR = PosyR;
  
  //Variables locales;
  boolean libre = true;
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
    if(R[restaX2][restaY2] == 1 && restaX2 != xR && restaY2 != yR){
      libre = false;
      return false;
    }
    restaX2++;
    restaY2--;
    control++;
  }
  return libre;
}
//-------- FIN HERRAMIENTAS DE BÚSQUEDA. --------


boolean estaLibre(String P[], int R[][], int cE){ //Regresa 1 si está libre, regresa 0 si no lo está.
  int xR = separarCoordX(P, cE);
  int yR = separarCoordY(P, cE);

  if(libreX(R, xR, yR) && libreY(R, xR, yR) && libreDiag1(R, xR, yR) && libreDiag2(R, xR, yR)){
  return true;
  } else {
   return false; 
  }
}

void colocarReinas(){ //En esta deberá estar todo el proceso para colocar las reinas.
  R[0][1]=1;
  R[1][1]=1;
  R[4][6]=1;
  R[7][7]=1;
}

//Funciones para los gráficos.

void drawRect(int x1, int y1, int x2, int y2) { //Pinta los cuadrados del tablero.
  fill(255, 255, 255);
  rect(x1, y1, 88, 88);
  fill(0, 0, 0);
  rect(x2, y2, 88, 88); //Cuadrados negros.
}

void draw() { //Dibuja las reinas.

  int x=0;
  int y=0;
  for (int i=0; i < 8; i++) { //Columnas
    for (int j=0; j< 8; j++) { //Filas
      if (R[j][i]==1) {
        fill(255, 0, 0);
        circle(x+44, y+44, 86);
      }
      x+=88;
    }
    x=0;
    y+=88;
  }
}
