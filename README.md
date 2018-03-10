  # dibujar_skyline

###### Herramienta de desarrollo
>WinGHCi

###### Conocimientos principales aplicados
- Haskell

###### Descripción

Última entrega de la asignatura Programación Declarativa en el módulo de haskell.
Consiste en la funcionalidad para dibujar la silueta de unos edificios en el horizonte a partir de sus coordenadas. Se pueden ver detalles de lo que se pedía en el guion de la práctica, **Programación Funcional VI.pdf**.

La función `resuelve` genera siluetas a partir de coordenadas de edificios, y la función `dibujar` analiza estas siluetas para generar la altura en cada punto del skyline y lo dibuja usando asteriscos, espacios y saltos de línea.

```
*Main> resuelve [(2,5,7),(3,6,9),(5,7,2),(9,12,3),(14,16,10)]
[(2,7),(3,9),(6,2),(7,0),(9,3),(12,0),(14,10),(16,0)]

*Main> dibujar [(2,7),(3,9),(6,2),(7,0),(9,3),(12,0),(14,10),(16,0)]
"              ** \n   ***        ** \n   ***        ** \n  ****        ** \n  ****        ** \n  ****        ** \n  ****        ** \n  ****   ***  ** \n  *****  ***  ** \n  *****  ***  ** \n-----------------"
```

Se crearon, por conveniencia, dos funciones adicionales: `dibujar'` formatea correctamente la salida para que se vea el dibujo del skyline y `resuelve'` llama directamente a `resuelve' horizonte = dibujar' (resuelve horizonte)` siendo **horizonte** una serie de coordenadas de edificios.

```
*Main> resuelve' [(2,5,7),(3,6,9),(5,7,2),(9,12,3),(14,16,10)]
              ** 
   ***        ** 
   ***        ** 
  ****        ** 
  ****        ** 
  ****        ** 
  ****        ** 
  ****   ***  ** 
  *****  ***  ** 
  *****  ***  ** 
-----------------
```
