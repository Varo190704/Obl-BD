6) Seleccionar la cantidad de órdenes por día en el período comprendido entre el 1 y 20 de abril de
este año. 

SELECT fecha_orden, count(num_orden)


4) Seleccionar el número de las órdenes cuando el precio del producto ordenado sea el precio
mayor de todos los productos. 

SELECT d.num_order from detalle d, producto p 
where d.cod_prod = p.cod_prod
and p.precio = (select max(precio) form poducto);


1) Seleccionar la cantidad de clientes. 
