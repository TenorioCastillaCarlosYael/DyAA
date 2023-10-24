/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.urbenia.smp;

/**
 *
 * @author yael_
 */
public class persona {
    String nombre;
    String[] rankinTop;
    boolean estaLibre;

    public persona(String nombre, String[] rankinTop, boolean estaLibre) {
        this.nombre = nombre;
        this.rankinTop = rankinTop;
        this.estaLibre = estaLibre;
    }
    
    public String[] getRankinTop() {
        return rankinTop;
    }

    public String getNombre() {
        return nombre;
    }

    public boolean isEstaLibre() {
        return estaLibre;
    }

    @Override
    public String toString() {
        return "persona{" + "nombre=" + nombre + ", rankinTop=" + rankinTop + ", estaLibre=" + estaLibre + '}';
    }

}
