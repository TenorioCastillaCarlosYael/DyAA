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
  
  //y, x
  R[5][1]=1; //Inicia la primera reina y la agrega a una lista.
  //R[4][0]=1;
  
  
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
  int cuantasEntradas = 0;
  
  System.out.print(estaLibre(Posic, R, cuantasEntradas));
}

void drawRect(int x1, int y1, int x2, int y2) { //Pinta los cuadrados del tablero.
  fill(255, 255, 255);
  rect(x1, y1, 88, 88);
  fill(0, 0, 0);
  rect(x2, y2, 88, 88); //Cuadrados negros.
}

boolean estaLibre(String P[], int R[][], int cE){ //Regresa 1 si está libre, regresa 0 si no lo está.
  //Función que separa los strings en coordenadas.
  String Aux = P[cE].toString();
  String Dividido[] = Aux.split(",");
  int xR = Integer.parseInt(Dividido[0]);
  int yR = Integer.parseInt(Dividido[1]);
  int libreX = 0;
  int libreY = 0;
  int libreDiag1 = 0;
  int libreDiag2 = 0;
  
  
for(int x=0; x<8; x++){ //Esto dirá si hay algúna pieza en x que no sea la reina introducida.
  if(R[x][yR]==1 && x != xR){ //Significa que no está libre.
    libreX = 0;
    break;
  } else { //Significa que está libre.
  libreX=1;
  }
}
  
for(int y=0; y<8; y++){ //Esto dirá si hay algúna pieza en y que no sea la reina introducida.
  if(R[xR][y]==1 && y != yR){ //Significa que no está libre.
  //System.out.print(y);
    libreY = 0;
    break;
  } else { //Significa que está libre.
  libreY=1;
  }
}

/*
  Espacio para calcular las diagonales, para ello se usan las coordenadas de las reinas y se determina 
  si el borde está cerca de x o de y, y en base en eso hace las restas correspondientes.
*/

int auxX; //auxX es una variable que sólo se usa en para este cálculo, xR es una variable global.
int auxY; //auxY es una variable que sólo se usa en para este cálculo, yR es una variable global.
//1 corresponde a el orden de la diagonal, en este caso 1 es de 0 a 7 y 2 es de 7 a 0.
int restaX1 = 0; 
int restaY1 = 0;
int restaX2 = 0;
int restaY2 = 0;

//Diagonal de xy0 a xy7. Considerar x<y, x>y y x=y.
if(xR<yR){ //x menor que y
  if(xR == 0){
    restaX1 = 0;
  } else {
   restaX1 = xR-xR; 
  }
 restaY1 = yR - xR;
 
} else if(xR>yR) { //x mayor que y
  if(yR == 0){
    restaY1 = 0;
  } else {
   restaY1 = yR-yR; 
  }
 restaX1 = xR - yR;

} else if(xR == yR) { //x y y iguales
  if(xR == 0 && yR == 0){
    restaX1 = 0;
    restaY1 = 0;
  } else {
    restaX1 = xR - xR;
    restaY1 = yR - yR;
  }
}

//Diagonal de xy7 a xy0.
  //Cuadrante x.
  if(xR >= 0 && xR <= 3){ //Cuadrante 1
    if(xR == 0){
      restaX2 = 0;
      restaY2 = yR;
    } else {
      restaX2 = xR - xR;
      restaY2 = xR + yR;
    }
                          //Fin Cuadrante 1
  } else if (xR >= 4 && xR <= 7){
    if(yR == 0){
      restaX2 = xR - xR;
      restaY2 = xR;
    } else if (xR < yR){
      auxY = 7 - xR;
      restaY2 = 7;
      restaX2 = xR - auxY;
    } else if (xR > yR){
      auxY = 7 - xR;
      restaY2 = 7;
      restaX2 = xR - auxY;
    }
  }
  
  System.out.print("Restas{" + restaX2 + ", " + restaY2 + "}");

  



  if(libreX == 1 && libreY == 1 && libreDiag1 == 1 && libreDiag2 == 1){
    //System.out.print(libreX + "," + libreY + "," + libreDiag1 + "," + libreDiag2);
  return true;
  } else {
    //System.out.print(libreX + "," + libreY + "," + libreDiag1 + "," + libreDiag2);
   return false; 
  }
}

void colocarReinas(){ //En esta deberá estar todo el proceso para colocar las reinas.
  R[0][1]=1;
  R[1][1]=1;
  R[4][6]=1;
  R[7][7]=1;
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
