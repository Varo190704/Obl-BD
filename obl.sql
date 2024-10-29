/*

Problema en 4 donde falta asegurar que sea en los ultimos 30 dias
Problema en 5 donde no reconoce el c2 tot monedas max
En 7 no entendi la letra
Problema en 8 no se como poner fecha actual

*/

-- Ejercicio 1
--anda bien
    SELECT U.nombre, U.email, a.nombre, a.genero
    from Usuario U
    JOIN asistente A ON u.idasistente = a.idasistente
    Join configuracion C on a.idasistente = c.idasistente
    where (U.rangoEdad = '25-34' 
        OR U.rangoEdad = '35-44' 
        OR U.rangoEdad = '45-54' 
        OR U.rangoEdad = '55-64' 
        OR U.rangoEdad = '65 o más')
    AND U.fecharegistro Between TO_DATE('2024-04-01', 'YYYY-MM-DD') AND TO_DATE('2024-05-31', 'YYYY-MM-DD')
    AND c.interes != 'Deportes';

-- Fin Ejercicio 1

-- Ejercicio 2
--anda bien
    Select c.idconfiguracion
    From configuracion c
    Join asistente a ON c.idasistente = a.idasistente
    Join asignarol ar ON ar.idasistente = a.idasistente
    Join rol r ON r.idrol = ar.idrol
    JOin compra c2 ON c2.idconfiguracion = c.idconfiguracion
    where r.tipo = 'Coach'
    And c2.fechacompra = (select max(fechaCompra) from compra);

-- Fin Ejercicio 2

-- Ejercicio 3
-- anda bien
    Select a.*
    From asistente a
    Join configuracion c ON a.idasistente = c.idasistente
    Join asignarol ar ON a.idasistente = ar.idasistente
    Join rol r ON r.idrol = ar.idrol
    where c.rasgo = 'Soñador'
    And r.tipo = 'Amigo'
    
    UNION
    
    Select a.*
    From asistente a
    Join configuracion c ON a.idasistente = c.idasistente
    Join asignarol ar ON a.idasistente = ar.idasistente
    Join rol r ON r.idrol = ar.idrol
    where c.rasgo = 'Energético'
    And r.tipo = 'Amigo'
    
    except
    
    Select a.*
    From asistente a
    Join configuracion c ON a.idasistente = c.idasistente
    Join asignarol ar ON a.idasistente = ar.idasistente
    Join rol r ON r.idrol = ar.idrol
    where c.rasgo = 'Energético'
    and c.rasgo = 'Soñador'
    And r.tipo = 'Amigo';

-- Fin Ejercicio 3

-- Ejercicio 4
    
    Select a.*, u.nombre
    From asistente a
    Join usuario u ON u.idasistente = a.idasistente
    where Exists(
        select 1 --esto es subconsulta, preguntar si esta bien implementar aca
        From asignarol ar
        Join rol r on r.idrol = ar.idrol
        Where ar.idasistente = a.idasistente
        and r.tipo = 'Coach'
    )
    And Exists(
        select 1 --esto es subconsulta, preguntar si esta bien implementar aca
        From asignarol ar
        Join rol r on r.idrol = ar.idrol
        Where ar.idasistente = a.idasistente
        and r.tipo = 'Amigo'
    )
    And Exists(
        select 1 --esto es subconsulta, preguntar si esta bien implementar aca
        From asignarol ar
        Join rol r on r.idrol = ar.idrol
        Where ar.idasistente = a.idasistente
        and r.tipo = 'Tutor'
    );
    
-- Falta agregar que fecha registro sea max 30 dias antes

-- Fin Ejercicio 4

-- Ejercicio 5
    
    Select u.nombre
    From usuario u
    Join asistente a ON a.idasistente = u.idasistente
    Join configuracion c ON c.idasistente = a.idasistente
    Join compra c2 ON c2.idconfiguracion = c.idconfiguracion
    Where (U.rangoEdad = '55-64' 
       OR U.rangoEdad = '65 o más')
    And c2.totalmonedas = (select max(totalmonedas) from compra);

--no entiendo porque no anda

-- Fin Ejercicio 5

-- Ejercicio 6
-- va bien
    Select u.*
    From usuario u
    Join asistente a ON a.idasistente = u.idasistente
    Join configuracion c ON c.idasistente = u.idasistente
    Join compra c2 ON c2.idconfiguracion = c.idconfiguracion
    WHERE (U.rangoEdad = '35-44' 
        OR U.rangoEdad = '45-54' 
        OR U.rangoEdad = '55-64' 
        OR U.rangoEdad = '65 o más')
    And a.genero = 'Femenino'
    And c2.totalgemas > c2.totalmonedas; 

-- Fin Ejercicio 6

-- Ejercicio 7

--no entendi letra

-- Fin Ejercicio 7

-- Ejercicio 8

    Select c.*, c2.totalgemas
    From configuracion c
    Join compra c2 ON c.idconfiguracion = c2.idconfiguracion
    where c2.fechacompra between TO_DATE('01-12-2023', 'YYYY-MM-DD') and /*no se como poner dia actual*/;

--arreglar

-- Fin Ejercicio 8

-- Ejercicio 9

    Select c2.totalgemas, c2.totalmonedas, /* Falta poner cant confi */ 
    From configuracion c
    Join compra c2 On c2.idconfiguracion = c.idconfiguracion
    Join usuario u on u.idAsistente = c.idasistente /* esto es para no tener que hacer join a asistente */
    --hice join de usuario para poder meter el descuento como col en esa tabla, mas rapido para trabajar y cambiar 
    Where --no se que poner en este where, porque no tengo que comparar nada
    
-- Fin Ejercicio 9

-- Ejercicio 10
-- Fin Ejercicio 10