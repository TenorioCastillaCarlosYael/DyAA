int R[][]=new int[8][8];
String Posiciones[]= new String[8];

void setup() {
  size(704, 704); //Crea tablero.
  background(255, 255, 255); //Fondo blanco.
  int x1 = 0, y1 = 0; //x son las posiciones sólo de la primera fila. y son de todas las columnas pares.
  int x2 = 88, y2 = 0; //x altera la primera fila. y son todas las columnas impares.
  
  for (int i=0; i < 8; i++) { //Empieza for para pintar el tablero.
    for (int j=0; j< 4; j++) {
      if (i%2 == 0) { //Función para colocar los cuadros aleatoriamente.
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
  R[0][0]=1; //Inicia la primera reina y la agrega a una lista.
  R[4][0]=1;
  int ctrl = 0;
  for (int i=0; i < 8; i++) { //Columnas
    for (int j=0; j< 8; j++) { //Filas
      if (R[j][i]==1) {
       Posiciones[ctrl] = j + "," + i; 
       ctrl++;
     }
    }
  }
  /*for(int i = 0; i < 8; i++){
  System.out.print(Posiciones[i]);
  }*/
  int cuantasEntradas = 0;
  comprobar(Posiciones, R, cuantasEntradas);
  
}

void drawRect(int x1, int y1, int x2, int y2) {
  fill(255, 255, 255);
  rect(x1, y1, 88, 88);
  fill(0, 0, 0);
  rect(x2, y2, 88, 88); //Cuadrados negros.
}

boolean comprobar(String P[], int R[][], int cE){
  //Función que separa los strings en coordenadas.
  String Aux = P[cE].toString();
  String Dividido[] = Aux.split(",");
  int xR = Integer.parseInt(Dividido[0]);
  int yR = Integer.parseInt(Dividido[1]);
  int libreX = 0;
  int libreY = 0;
  int libreDiag1 = 0;
  int libreDiag2 = 0;
  
  //System.out.print("--"+xR+","+yR+"--");
  
for(int x=0; x<8; x++){ //Esto dirá si hay algúna pieza en x que no sea la reina introducida.
  if(R[x][yR]==0 && x != xR){ //Significa que está libre.
  //System.out.print(x + " ");
    libreX = 1;
  } else { //Significa que no está libre.
  libreX=0;
  break;
  }
}
//System.out.print("--X--");
  
for(int y=0; y<8; y++){ //Esto dirá si hay algúna pieza en y que no sea la reina introducida.
  if(R[xR][y]==0 && y != yR){ //Significa que está libre.
  //System.out.print(y);
    libreY = 1;
  } else { //Significa que no está libre.
  libreY=0;
  break;
  }
}
//System.out.print("--Y--");

/*Espacio para calcular las diagonales, para ello se usan las coordenadas de las reinas y se determina 
  si el borde está cerca de x o de y, y en base en eso hace las restas correspondientes.
*/
int auxX; //auxX es una variable que sólo se usa en para este cálculo, xR es una variable global.
int auxY; //auxY es una variable que sólo se usa en para este cálculo, yR es una variable global.
int restaX1 = 0;
int restaY1 = 0;
int restaX2 = 0;
int restaY2 = 0;

if(xR<yR){ //Diagonal de xy0 a xy7. 
 restaX1 = xR - xR;
 restaY1 = yR - xR;
 //System.out.print("Resultado 1 de 0 a 7 - Resta X1: " + restaX1 + ", resta Y1" + restaY1 + "  ");
} else {
 restaX1 = xR - yR;
 restaY1 = yR - yR;
 //System.out.print("Resultado 2 de 0 a 7 - Resta X1: " + restaX1 + ", resta Y1: " + restaY1 + "  ");

}

if(xR<yR){ //Diagonal de xy7 a xy0.
 auxX = 7-xR;
 restaX2 = auxX - xR;
 //System.out.print("Resultado 3 de 7 a 0 - Resta X2: " + restaX2 + "  ");
} else {
 auxY = 7 - yR;
 restaY2 = auxY - yR;
 //System.out.print("Resultado 4 de 7 a 0 - Resta Y2: " + restaY2 + "  ");
}


for(int y=restaY1; y<8; y++){ //Columnas. Esto dirá si hay algúna pieza en diagonal 1 que no sea la reina introducida.
  for(int x=restaX1; x<8; x++){
    if(R[x][y]==0 && y != yR && x!= xR){ //Significa que está libre.
      libreDiag1 = 1;
    } else { //Significa que no está libre.
      libreDiag1=0;
      break;
    }
  }
}

for(int y=restaY2; y<8; y++){ //Columnas. Esto dirá si hay algúna pieza en diagonal 2 que no sea la reina introducida.
  for(int x=restaX2; x<8; x++){
    if(R[x][y]==0 && y != yR && x!= xR){ //Significa que está libre.
      libreDiag2 = 1;
    } else { //Significa que no está libre.
      libreDiag2 = 0;
      break;
    }
  }
}

  if(libreX == 1 && libreY == 1 && libreDiag1 == 1 && libreDiag2 == 1){
    System.out.print(libreX + "," + libreY + "," + libreDiag1 + "," + libreDiag2);
  return true;
  } else {
    System.out.print(libreX + "," + libreY + "," + libreDiag1 + "," + libreDiag2);
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
