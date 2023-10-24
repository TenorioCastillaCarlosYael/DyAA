/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 */

package com.urbenia.smp;

/**
 *
 * @author yael_
 */
public class SMP {

    public static void main(String[] args) {
        String resultado;
        String[] n1R = {"k3", "k2", "k5", "k1","k4"};
        String[] n2R = {"k2", "k1", "k3", "k5","k4"};
        String[] n3R = {"k4", "k2", "k1", "k3","k5"};
        String[] n4R = {"k5", "k3", "k2", "k4","k1"};
        String[] n5R = {"k3", "k2", "k1", "k4","k5"};
        
        String[] k1R = {"n2", "n5", "n4", "n1","n3"};
        String[] k2R = {"n1", "n3", "n5", "n2","n4"};
        String[] k3R = {"n1", "n4", "n5", "n3","n2"};
        String[] k4R = {"n4", "n3", "n5", "n1","n2"};
        String[] k5R = {"n3", "n1", "n5", "n2","n4"};
        
        
        persona n1 = new persona("n1", n1R, true);
        persona n2 = new persona("n2", n2R, true);
        persona n3 = new persona("n3", n3R, true);
        persona n4 = new persona("n4", n4R, true);
        persona n5 = new persona("n5", n5R, true);
        
        persona k1 = new persona("k1", k1R, true);
        persona k2 = new persona("k2", k2R, true);
        persona k3 = new persona("k3", k3R, true);
        persona k4 = new persona("k4", k4R, true);
        persona k5 = new persona("k5", k5R, true);
        
        persona[] Hombres = {n1, n2, n3, n4, n5};
        persona[] Mujeres = {k1, k2, k3, k4, k5};
        
        resultado = generarParejas(Mujeres, Hombres);  
        System.out.println(resultado);
    }
    
    public static String generarParejas(persona[] Mujeres, persona[] Hombres){
        String relaciones = "";
        String[][] PorHacer = new String[10][3]; //nombre, num para empezar, libre.
        String[][] ListaParejas = new String[5][2];
        int agregar = 0;
        
        String nombreH = "";
        String nombreM = "";
        
        //Posición de su opción.
        int OpcionH = 0;
        int OpcionM = 0;
        
        //Posicion en los arreglos de mujeres y hombres.
        int NumeroHombre = 0;
        int NumeroMujer = 0;
        
        String[] PrefHombre = null;
        String[] PrefMujer = null;
        
        boolean MujerLibre = true;
        
        while(ListaParejas[4][1] == null){
            for(int Hombre = 0; Hombre < Hombres.length; Hombre++){
                if(ListaParejas[Hombre][0] != null){
                    if(Hombres[NumeroHombre].getNombre().equals(ListaParejas[Hombre][0])){
                    NumeroHombre++;
                    }
                } else {
                    break;
                }
            }

            nombreH = Hombres[NumeroHombre].getNombre();
            PrefHombre = Hombres[NumeroHombre].getRankinTop();
            
            OpcionH = buscarOpcionHombre(nombreH, PorHacer, ListaParejas, PrefHombre);
            
            for(int BuscarM = 0; BuscarM < Mujeres.length; BuscarM++){
                if(PrefHombre[OpcionH].equals(Mujeres[BuscarM].getNombre())){
                    nombreM = Mujeres[BuscarM].getNombre();
                    PrefMujer = Mujeres[BuscarM].getRankinTop();
                    NumeroMujer = BuscarM;
                    MujerLibre = Mujeres[BuscarM].isEstaLibre();
                }
            }
            
            OpcionM = buscarOpcionMujer(ListaParejas, PrefMujer, Hombres);
            
            //Primero los comparas a los dos en su primera opción.
            if(PrefHombre[OpcionH].equals(nombreM) && PrefMujer[OpcionM].equals(nombreH) && MujerLibre){
                relaciones += "{" + nombreH + "->" + nombreM + "}";
                Hombres[NumeroHombre].estaLibre = false;
                Mujeres[NumeroMujer].estaLibre = false;
                ListaParejas[agregar][0] = nombreH;
                ListaParejas[agregar][1] = nombreM;
                agregar++;
            } else {
                agregarPorHacer(PorHacer, nombreH, nombreM, OpcionH, OpcionM);
            }
            
            if(NumeroHombre == 4){
                NumeroHombre = 0;
            } else {
               NumeroHombre++; 
            }

        }
        
        

        return relaciones;
    } 
    
    public static int buscarOpcionHombre(String nombreH, String[][] PorHacer, String[][] ListaParejas, String[] PrefHombre){
        int aqui = 0;
        
        for(int buscar = 0; buscar < PorHacer.length; buscar++){
            if(PorHacer[buscar][0] == null){
                return aqui;
            } else {
                if(PorHacer[buscar][0].equals(nombreH)){
                    aqui = Integer.parseInt(PorHacer[buscar][1]);
                    break;
                }
            }
        }
        

        return aqui;
    }
    
    public static int buscarOpcionMujer(String[][] ListaParejas, String[] PrefMujer, persona[] Hombres){
        int opcion = 0;
        String NombreHombre = "";
        boolean estadoHombre = false;
        
        //Vas a recorrer en la lista de los preferidos y agarras el primero, 
        //luego buscarás al hombre y obtendrás si está soltero. Si lo está, retornas su numero.
        for(int externo = 0; externo < PrefMujer.length; externo++){
            NombreHombre = PrefMujer[externo];
            
            for(int buscar = 0; buscar < Hombres.length; buscar++){
                if(NombreHombre.equals(Hombres[buscar].getNombre())){
                    estadoHombre = Hombres[buscar].isEstaLibre();
                    break;
                }
            }
            
            if(estadoHombre){
                opcion = externo;
                break;
            }
            
        }

        return opcion;
    }
    
    public static void agregarPorHacer(String[][] PorHacer, String nombreH, String nombreM, int OpcionH, int OpcionM){
        int recorrer = 0;
        while(recorrer < PorHacer.length-2){
            if(PorHacer[0][0] == null){
                PorHacer[0][0] = nombreH;
                PorHacer[0][1] = "" + (OpcionH + 1);
                break;
            } else { //Si no está vacía, entonces buscarse, si no está, agregar al final.
                if(PorHacer[recorrer][0] == null || PorHacer[recorrer][0].equals(nombreH)){
                    PorHacer[recorrer][0] = nombreH;
                    PorHacer[recorrer][1] = "" + (OpcionH + 1);
                    break;
                }
            }
        recorrer++;
        }
    }
    
    public static boolean esHombreLibre(persona[] Hombres, String[] PrefMujer){
            for(int BuscarH = 0; BuscarH < Hombres.length; BuscarH++){
                if(PrefMujer[0].equals(Hombres[BuscarH].getNombre())){
                    return Hombres[BuscarH].estaLibre;
                }
            }
        
        return true;
    }
}
