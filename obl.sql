/*

En 7 no entendi la letra
Problema en 8 no se como poner fecha actual
tablas en 9
*/

-- Ejercicio 1
--anda bien

    --Tablas:
                
        DROP TABLE Compra;
        DROP TABLE Usuario;
        DROP TABLE Configuracion;
        DROP TABLE AsignaRol;
        DROP TABLE Rol;
        DROP TABLE Asistente;
         
        CREATE TABLE Asistente (
            idAsistente INT NOT NULL PRIMARY KEY,
            nombre VARCHAR2(255) NOT NULL,
            genero VARCHAR2(50) NOT NULL CHECK (genero IN ('Femenino', 'Masculino', 'No binario'))
        );
         
        CREATE TABLE Rol (
            idRol INT NOT NULL PRIMARY KEY,
            tipo VARCHAR2(50) NOT NULL CHECK (tipo IN ('Tutor', 'Amigo', 'Coach'))
        );
          
        CREATE TABLE AsignaRol (
            idAsistente INT NOT NULL,
            idRol INT NOT NULL, 
            PRIMARY KEY (idAsistente, idRol),
            FOREIGN KEY (idAsistente) REFERENCES ASISTENTE(idAsistente),
            FOREIGN KEY (idRol) REFERENCES ROL(idRol) 
        );
        
        CREATE TABLE Configuracion (
            idConfiguracion INT NOT NULL PRIMARY KEY,
            ropa VARCHAR2(50) NOT NULL CHECK (ropa IN ('Verano', 'Primavera', 'Anime', 'Oficina', 'Fiesta', 'Deporte', 'Camisetas')),
            interes VARCHAR2(50) NOT NULL CHECK (interes IN ('Juegos', 'Deportes', 'Historia', 'Moda')),
            rasgo VARCHAR2(50) NOT NULL CHECK (rasgo IN ('Seguro', 'Tímido', 'Energético', 'Práctico', 'Soñador', 'Artístico', 'Lógico')),
            voz VARCHAR2(50) NOT NULL CHECK (voz IN ('Femenina', 'Masculina')),
            costoGemas INT,
            costoMonenas INT,
            idAsistente INT NOT NULL,
            vigente CHAR(1) NOT NULL CHECK (vigente IN ('S', 'N')),
            FOREIGN KEY (idAsistente) REFERENCES ASISTENTE(idAsistente)
        );
        
        CREATE TABLE Usuario (
            email VARCHAR2(255) NOT NULL PRIMARY KEY,
            nombre VARCHAR2(255),
            rangoEdad VARCHAR2(10) CHECK (rangoEdad IN ('18-24', '25-34', '35-44', '45-54', '55-64', '65 o más')),
            fechaRegistro DATE NOT NULL,
            saldoGemas INT,
            saldoMonedas INT,
            idAsistente INT NOT NULL,
            FOREIGN KEY (idAsistente) REFERENCES ASISTENTE(idAsistente)  
        );
        
        
        CREATE TABLE Compra (
            idConfiguracion INT NOT NULL,
            email VARCHAR2(255) NOT NULL,
            fechaCompra DATE NOT NULL,
            totalGemas INT NOT NULL,
            totalMonedas INT NOT NULL,
            PRIMARY KEY (idConfiguracion, email, fechaCompra),
            FOREIGN KEY (idConfiguracion) REFERENCES CONFIGURACION(idConfiguracion),
            FOREIGN KEY (email) REFERENCES USUARIO(email)
        );
    
        INSERT INTO Asistente (idAsistente, nombre, genero) VALUES (1, 'Carlos', 'Masculino'); --.
        INSERT INTO Asistente (idAsistente, nombre, genero) VALUES (2, 'Ana', 'Femenino'); --ningun usuario val lo tiene regis
        INSERT INTO Asistente (idAsistente, nombre, genero) VALUES (3, 'Alex', 'No binario'); --.

        INSERT INTO Configuracion (idConfiguracion, ropa, interes, rasgo, voz, costoGemas, costoMonenas, idAsistente, vigente) VALUES (1, 'Deporte', 'Deportes', 'Energético', 'Masculina', 20, 10, 1, 'S'); --no valido
        INSERT INTO Configuracion (idConfiguracion, ropa, interes, rasgo, voz, costoGemas, costoMonenas, idAsistente, vigente) VALUES (2, 'Anime', 'Juegos', 'Soñador', 'Femenina', 15, 5, 2, 'S'); --no regis
        INSERT INTO Configuracion (idConfiguracion, ropa, interes, rasgo, voz, costoGemas, costoMonenas, idAsistente, vigente) VALUES (3, 'Primavera', 'Moda', 'Artístico', 'Femenina', 30, 15, 3, 'S'); --valido

        INSERT INTO Usuario (email, nombre, rangoEdad, fechaRegistro, saldoGemas, saldoMonedas, idAsistente) VALUES ('eje10@gmail.com', 'Juan', '25-34', DATE '2024-04-10', 100, 200, 1); --valido (no valido por configuracioon interes deporte
        INSERT INTO Usuario (email, nombre, rangoEdad, fechaRegistro, saldoGemas, saldoMonedas, idAsistente) VALUES ('eje2@gmail.com', 'Lucía', '18-24', DATE '2024-05-20', 50, 120, 2); --menor 20
        INSERT INTO Usuario (email, nombre, rangoEdad, fechaRegistro, saldoGemas, saldoMonedas, idAsistente) VALUES ('eje1@gmail.com', 'Diego', '35-44', DATE '2024-06-15', 300, 50, 3); --valido
        INSERT INTO Usuario (email, nombre, rangoEdad, fechaRegistro, saldoGemas, saldoMonedas, idAsistente) VALUES ('eje20@gmail.com', 'Sara', '35-44', DATE '2024-03-30', 75, 80, 1); --primer trimestre
        INSERT INTO Usuario (email, nombre, rangoEdad, fechaRegistro, saldoGemas, saldoMonedas, idAsistente) VALUES ('jazz@gmail.com', 'Pedro', '18-24', DATE '2024-04-05', 60, 70, 2); --menor 20

        INSERT INTO Compra (idConfiguracion, email, fechaCompra, totalGemas, totalMonedas) VALUES (1, 'eje2@gmail.com', DATE '2024-06-02', 100, 90); -- relacionada con deportes
        INSERT INTO Compra (idConfiguracion, email, fechaCompra, totalGemas, totalMonedas) VALUES (3, 'eje20@gmail.com', DATE '2024-06-02', 100, 90); -- no relacionada con deportes
        INSERT INTO Compra (idConfiguracion, email, fechaCompra, totalGemas, totalMonedas) VALUES (2, 'eje1@gmail.com', DATE '2024-06-15', 200, 80); -- no relacionada con deportes
        INSERT INTO Compra (idConfiguracion, email, fechaCompra, totalGemas, totalMonedas) VALUES (1, 'eje10@gmail.com', DATE '2024-06-15', 200, 80); -- relacionada con deportes
        INSERT INTO Compra (idConfiguracion, email, fechaCompra, totalGemas, totalMonedas) VALUES (3, 'jazz@gmail.com', DATE '2024-05-10', 20, 100); -- no relacionada con deportes

        INSERT INTO Rol (idRol, tipo) VALUES (1, 'Coach'); 
        INSERT INTO Rol (idRol, tipo) VALUES (2, 'Amigo'); 
        INSERT INTO Rol (idRol, tipo) VALUES (3, 'Tutor'); 

        INSERT INTO AsignaRol (idAsistente, idRol) VALUES (1, 1); -- Carlos como Coach
        INSERT INTO AsignaRol (idAsistente, idRol) VALUES (2, 2); -- Ana como Amigo
        INSERT INTO AsignaRol (idAsistente, idRol) VALUES (3, 3); -- Alex como Tutor
 
    --Fin tablas 1
    
    --anda
    
    SELECT U.nombre, U.email, a.nombre, a.genero
    from Usuario U
    JOIN asistente A ON u.idasistente = a.idasistente
    Join configuracion C on a.idasistente = c.idasistente
    where (U.rangoEdad = '25-34' 
        OR U.rangoEdad = '35-44' 
        OR U.rangoEdad = '45-54' 
        OR U.rangoEdad = '55-64' 
        OR U.rangoEdad = '65 o más')
    AND U.fecharegistro Between TO_DATE('2024-04-01', 'YYYY-MM-DD') AND TO_DATE('2024-06-30', 'YYYY-MM-DD')
    AND c.interes != 'Deportes';

    --Esperado es Diego
    
-- Fin Ejercicio 1

-- Ejercicio 2

    --tablas ejer 2
            
        DROP TABLE Compra;
        DROP TABLE Usuario;
        DROP TABLE Configuracion;
        DROP TABLE AsignaRol;
        DROP TABLE Rol;
        DROP TABLE Asistente;
         
        CREATE TABLE Asistente (
            idAsistente INT NOT NULL PRIMARY KEY,
            nombre VARCHAR2(255) NOT NULL,
            genero VARCHAR2(50) NOT NULL CHECK (genero IN ('Femenino', 'Masculino', 'No binario'))
        );
         
        CREATE TABLE Rol (
            idRol INT NOT NULL PRIMARY KEY,
            tipo VARCHAR2(50) NOT NULL CHECK (tipo IN ('Tutor', 'Amigo', 'Coach'))
        );
          
        CREATE TABLE AsignaRol (
            idAsistente INT NOT NULL,
            idRol INT NOT NULL, 
            PRIMARY KEY (idAsistente, idRol),
            FOREIGN KEY (idAsistente) REFERENCES ASISTENTE(idAsistente),
            FOREIGN KEY (idRol) REFERENCES ROL(idRol) 
        );
        
        CREATE TABLE Configuracion (
            idConfiguracion INT NOT NULL PRIMARY KEY,
            ropa VARCHAR2(50) NOT NULL CHECK (ropa IN ('Verano', 'Primavera', 'Anime', 'Oficina', 'Fiesta', 'Deporte', 'Camisetas')),
            interes VARCHAR2(50) NOT NULL CHECK (interes IN ('Juegos', 'Deportes', 'Historia', 'Moda')),
            rasgo VARCHAR2(50) NOT NULL CHECK (rasgo IN ('Seguro', 'Tímido', 'Energético', 'Práctico', 'Soñador', 'Artístico', 'Lógico')),
            voz VARCHAR2(50) NOT NULL CHECK (voz IN ('Femenina', 'Masculina')),
            costoGemas INT,
            costoMonenas INT,
            idAsistente INT NOT NULL,
            vigente CHAR(1) NOT NULL CHECK (vigente IN ('S', 'N')),
            FOREIGN KEY (idAsistente) REFERENCES ASISTENTE(idAsistente)
        );
        
        CREATE TABLE Usuario (
            email VARCHAR2(255) NOT NULL PRIMARY KEY,
            nombre VARCHAR2(255),
            rangoEdad VARCHAR2(10) CHECK (rangoEdad IN ('18-24', '25-34', '35-44', '45-54', '55-64', '65 o más')),
            fechaRegistro DATE NOT NULL,
            saldoGemas INT,
            saldoMonedas INT,
            idAsistente INT NOT NULL,
            FOREIGN KEY (idAsistente) REFERENCES ASISTENTE(idAsistente)  
        );
        
        
        CREATE TABLE Compra (
            idConfiguracion INT NOT NULL,
            email VARCHAR2(255) NOT NULL,
            fechaCompra DATE NOT NULL,
            totalGemas INT NOT NULL,
            totalMonedas INT NOT NULL,
            PRIMARY KEY (idConfiguracion, email, fechaCompra),
            FOREIGN KEY (idConfiguracion) REFERENCES CONFIGURACION(idConfiguracion),
            FOREIGN KEY (email) REFERENCES USUARIO(email)
        );
    
        INSERT INTO Asistente (idAsistente, nombre, genero) VALUES (1, 'Carlos', 'Masculino'); -- es valid
        INSERT INTO Asistente (idAsistente, nombre, genero) VALUES (2, 'Ana', 'Femenino'); -- no valid no es coach
        INSERT INTO Asistente (idAsistente, nombre, genero) VALUES (3, 'Alex', 'No binario'); -- no valid no es coach

        INSERT INTO Configuracion (idConfiguracion, ropa, interes, rasgo, voz, costoGemas, costoMonenas, idAsistente, vigente) VALUES (1, 'Verano', 'Deportes', 'Energético', 'Masculina', 20, 10, 1, 'S'); --.
        INSERT INTO Configuracion (idConfiguracion, ropa, interes, rasgo, voz, costoGemas, costoMonenas, idAsistente, vigente) VALUES (2, 'Anime', 'Juegos', 'Soñador', 'Femenina', 15, 5, 2, 'S'); --no valid por asis
        INSERT INTO Configuracion (idConfiguracion, ropa, interes, rasgo, voz, costoGemas, costoMonenas, idAsistente, vigente) VALUES (3, 'Primavera', 'Moda', 'Artístico', 'Femenina', 30, 15, 3, 'S'); -- no valid por asis

        INSERT INTO Usuario (email, nombre, rangoEdad, fechaRegistro, saldoGemas, saldoMonedas, idAsistente) VALUES ('eje10@gmail.com', 'Juan', '25-34', DATE '2024-04-10', 100, 200, 1); --x
        INSERT INTO Usuario (email, nombre, rangoEdad, fechaRegistro, saldoGemas, saldoMonedas, idAsistente) VALUES ('eje2@gmail.com', 'Lucía', '18-24', DATE '2024-05-20', 50, 120, 2); --x
        INSERT INTO Usuario (email, nombre, rangoEdad, fechaRegistro, saldoGemas, saldoMonedas, idAsistente) VALUES ('eje1@gmail.com', 'Diego', '35-44', DATE '2024-06-15', 300, 50, 3); --x
        INSERT INTO Usuario (email, nombre, rangoEdad, fechaRegistro, saldoGemas, saldoMonedas, idAsistente) VALUES ('eje20@gmail.com', 'Sara', '35-44', DATE '2024-03-30', 75, 80, 1); --x
        INSERT INTO Usuario (email, nombre, rangoEdad, fechaRegistro, saldoGemas, saldoMonedas, idAsistente) VALUES ('jazz@gmail.com', 'Pedro', '18-24', DATE '2024-04-05', 60, 70, 2); --x


        INSERT INTO Compra (idConfiguracion, email, fechaCompra, totalGemas, totalMonedas) VALUES (1, 'eje2@gmail.com', DATE '2024-06-02', 100, 90); -- x
        INSERT INTO Compra (idConfiguracion, email, fechaCompra, totalGemas, totalMonedas) VALUES (2, 'eje1@gmail.com', DATE '2024-06-15', 200, 80); -- x
        INSERT INTO Compra (idConfiguracion, email, fechaCompra, totalGemas, totalMonedas) VALUES (3, 'jazz@gmail.com', DATE '2024-05-10', 20, 100); -- x

        INSERT INTO Rol (idRol, tipo) VALUES (1, 'Coach'); 
        INSERT INTO Rol (idRol, tipo) VALUES (2, 'Amigo'); 
        INSERT INTO Rol (idRol, tipo) VALUES (3, 'Tutor'); 

        INSERT INTO AsignaRol (idAsistente, idRol) VALUES (1, 1); -- Carlos como Coach
        INSERT INTO AsignaRol (idAsistente, idRol) VALUES (2, 2); -- Ana como Amigo
        INSERT INTO AsignaRol (idAsistente, idRol) VALUES (3, 3); -- Alex como Tutor
        
    --Fin tablas ejer 2
    --no anda bien

    Select c.idconfiguracion
    From configuracion c
    Join asistente a ON c.idasistente = a.idasistente
    Join asignarol ar ON ar.idasistente = a.idasistente
    Join rol r ON r.idrol = ar.idrol
    JOin compra c2 ON c2.idconfiguracion = c.idconfiguracion
    where r.tipo = 'Coach'
    And c2.fechacompra = (
    select min(fechaCompra) 
    from compra c2
    Join asistente a ON c.idasistente = a.idasistente
    Join asignarol ar ON ar.idasistente = a.idasistente
    Join rol r ON r.idrol = ar.idrol
    JOin configuracion c ON c2.idconfiguracion = c.idconfiguracion
    where r.tipo = 'Coach'
    and c.ropa = 'Verano');
    
    --debe devolver id 1
    
    
-- Fin Ejercicio 2

-- Ejercicio 3

    --Tablas 3
    
        DROP TABLE Compra;
        DROP TABLE Usuario;
        DROP TABLE Configuracion;
        DROP TABLE AsignaRol;
        DROP TABLE Rol;
        DROP TABLE Asistente;
         
        CREATE TABLE Asistente (
            idAsistente INT NOT NULL PRIMARY KEY,
            nombre VARCHAR2(255) NOT NULL,
            genero VARCHAR2(50) NOT NULL CHECK (genero IN ('Femenino', 'Masculino', 'No binario'))
        );
         
        CREATE TABLE Rol (
            idRol INT NOT NULL PRIMARY KEY,
            tipo VARCHAR2(50) NOT NULL CHECK (tipo IN ('Tutor', 'Amigo', 'Coach'))
        );
          
        CREATE TABLE AsignaRol (
            idAsistente INT NOT NULL,
            idRol INT NOT NULL, 
            PRIMARY KEY (idAsistente, idRol),
            FOREIGN KEY (idAsistente) REFERENCES ASISTENTE(idAsistente),
            FOREIGN KEY (idRol) REFERENCES ROL(idRol) 
        );
        
        CREATE TABLE Configuracion (
            idConfiguracion INT NOT NULL PRIMARY KEY,
            ropa VARCHAR2(50) NOT NULL CHECK (ropa IN ('Verano', 'Primavera', 'Anime', 'Oficina', 'Fiesta', 'Deporte', 'Camisetas')),
            interes VARCHAR2(50) NOT NULL CHECK (interes IN ('Juegos', 'Deportes', 'Historia', 'Moda')),
            rasgo VARCHAR2(50) NOT NULL CHECK (rasgo IN ('Seguro', 'Tímido', 'Energético', 'Práctico', 'Soñador', 'Artístico', 'Lógico')),
            voz VARCHAR2(50) NOT NULL CHECK (voz IN ('Femenina', 'Masculina')),
            costoGemas INT,
            costoMonenas INT,
            idAsistente INT NOT NULL,
            vigente CHAR(1) NOT NULL CHECK (vigente IN ('S', 'N')),
            FOREIGN KEY (idAsistente) REFERENCES ASISTENTE(idAsistente)
        );
        
        CREATE TABLE Usuario (
            email VARCHAR2(255) NOT NULL PRIMARY KEY,
            nombre VARCHAR2(255),
            rangoEdad VARCHAR2(10) CHECK (rangoEdad IN ('18-24', '25-34', '35-44', '45-54', '55-64', '65 o más')),
            fechaRegistro DATE NOT NULL,
            saldoGemas INT,
            saldoMonedas INT,
            idAsistente INT NOT NULL,
            FOREIGN KEY (idAsistente) REFERENCES ASISTENTE(idAsistente)  
        );
        
        CREATE TABLE Compra (
            idConfiguracion INT NOT NULL,
            email VARCHAR2(255) NOT NULL,
            fechaCompra DATE NOT NULL,
            totalGemas INT NOT NULL,
            totalMonedas INT NOT NULL,
            PRIMARY KEY (idConfiguracion, email, fechaCompra),
            FOREIGN KEY (idConfiguracion) REFERENCES CONFIGURACION(idConfiguracion),
            FOREIGN KEY (email) REFERENCES USUARIO(email)
        );
    
        INSERT INTO Asistente (idAsistente, nombre, genero) VALUES (1, 'Carlos', 'Masculino'); -- es valid
        INSERT INTO Asistente (idAsistente, nombre, genero) VALUES (2, 'Ana', 'Femenino'); -- no valid no es coach
        INSERT INTO Asistente (idAsistente, nombre, genero) VALUES (3, 'Alex', 'No binario'); -- no valid no es coach

        INSERT INTO Configuracion (idConfiguracion, ropa, interes, rasgo, voz, costoGemas, costoMonenas, idAsistente, vigente) VALUES (1, 'Verano', 'Deportes', 'Energético', 'Masculina', 20, 10, 1, 'S'); --valido (no valid por no ser amigo)
        INSERT INTO Configuracion (idConfiguracion, ropa, interes, rasgo, voz, costoGemas, costoMonenas, idAsistente, vigente) VALUES (2, 'Anime', 'Juegos', 'Soñador', 'Femenina', 15, 5, 2, 'S'); --valido
        INSERT INTO Configuracion (idConfiguracion, ropa, interes, rasgo, voz, costoGemas, costoMonenas, idAsistente, vigente) VALUES (3, 'Primavera', 'Moda', 'Artístico', 'Femenina', 30, 15, 3, 'S'); --no valid por compartir los dos
        INSERT INTO Configuracion (idConfiguracion, ropa, interes, rasgo, voz, costoGemas, costoMonenas, idAsistente, vigente) VALUES (4, 'Verano', 'Deportes', 'Energético', 'Masculina', 20, 10, 3, 'S'); --no valid por compartir los dos
        INSERT INTO Configuracion (idConfiguracion, ropa, interes, rasgo, voz, costoGemas, costoMonenas, idAsistente, vigente) VALUES (5, 'Anime', 'Juegos', 'Soñador', 'Femenina', 15, 5, 3, 'S'); --no valid por compartir los dos
        
        INSERT INTO Usuario (email, nombre, rangoEdad, fechaRegistro, saldoGemas, saldoMonedas, idAsistente) VALUES ('eje10@gmail.com', 'Juan', '25-34', DATE '2024-04-10', 100, 200, 1); --x
        INSERT INTO Usuario (email, nombre, rangoEdad, fechaRegistro, saldoGemas, saldoMonedas, idAsistente) VALUES ('eje2@gmail.com', 'Lucía', '18-24', DATE '2024-05-20', 50, 120, 2); --x
        INSERT INTO Usuario (email, nombre, rangoEdad, fechaRegistro, saldoGemas, saldoMonedas, idAsistente) VALUES ('eje1@gmail.com', 'Diego', '35-44', DATE '2024-06-15', 300, 50, 3); --x
        INSERT INTO Usuario (email, nombre, rangoEdad, fechaRegistro, saldoGemas, saldoMonedas, idAsistente) VALUES ('eje20@gmail.com', 'Sara', '35-44', DATE '2024-03-30', 75, 80, 1); --x
        INSERT INTO Usuario (email, nombre, rangoEdad, fechaRegistro, saldoGemas, saldoMonedas, idAsistente) VALUES ('jazz@gmail.com', 'Pedro', '18-24', DATE '2024-04-05', 60, 70, 2); --x


        INSERT INTO Compra (idConfiguracion, email, fechaCompra, totalGemas, totalMonedas) VALUES (1, 'eje2@gmail.com', DATE '2024-06-02', 100, 90); -- x
        INSERT INTO Compra (idConfiguracion, email, fechaCompra, totalGemas, totalMonedas) VALUES (2, 'eje1@gmail.com', DATE '2024-06-15', 200, 80); -- x
        INSERT INTO Compra (idConfiguracion, email, fechaCompra, totalGemas, totalMonedas) VALUES (3, 'jazz@gmail.com', DATE '2024-05-10', 20, 100); -- x

        INSERT INTO Rol (idRol, tipo) VALUES (1, 'Coach'); 
        INSERT INTO Rol (idRol, tipo) VALUES (2, 'Amigo'); 
        INSERT INTO Rol (idRol, tipo) VALUES (3, 'Tutor'); 

        INSERT INTO AsignaRol (idAsistente, idRol) VALUES (1, 1); -- Carlos como Coach
        INSERT INTO AsignaRol (idAsistente, idRol) VALUES (2, 2); -- Ana como Amigo
        INSERT INTO AsignaRol (idAsistente, idRol) VALUES (3, 3); -- Alex como Tutor
    
    --Fin tablas 3

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

    --Esperado: | 2 | Ana | Femenino |

-- Fin Ejercicio 3

-- Ejercicio 4
    --Tabla 4
    
        DROP TABLE Compra;
        DROP TABLE Usuario;
        DROP TABLE Configuracion;
        DROP TABLE AsignaRol;
        DROP TABLE Rol;
        DROP TABLE Asistente;
         
        CREATE TABLE Asistente (
            idAsistente INT NOT NULL PRIMARY KEY,
            nombre VARCHAR2(255) NOT NULL,
            genero VARCHAR2(50) NOT NULL CHECK (genero IN ('Femenino', 'Masculino', 'No binario'))
        );
         
        CREATE TABLE Rol (
            idRol INT NOT NULL PRIMARY KEY,
            tipo VARCHAR2(50) NOT NULL CHECK (tipo IN ('Tutor', 'Amigo', 'Coach'))
        );
          
        CREATE TABLE AsignaRol (
            idAsistente INT NOT NULL,
            idRol INT NOT NULL, 
            PRIMARY KEY (idAsistente, idRol),
            FOREIGN KEY (idAsistente) REFERENCES ASISTENTE(idAsistente),
            FOREIGN KEY (idRol) REFERENCES ROL(idRol) 
        );
        
        CREATE TABLE Configuracion (
            idConfiguracion INT NOT NULL PRIMARY KEY,
            ropa VARCHAR2(50) NOT NULL CHECK (ropa IN ('Verano', 'Primavera', 'Anime', 'Oficina', 'Fiesta', 'Deporte', 'Camisetas')),
            interes VARCHAR2(50) NOT NULL CHECK (interes IN ('Juegos', 'Deportes', 'Historia', 'Moda')),
            rasgo VARCHAR2(50) NOT NULL CHECK (rasgo IN ('Seguro', 'Tímido', 'Energético', 'Práctico', 'Soñador', 'Artístico', 'Lógico')),
            voz VARCHAR2(50) NOT NULL CHECK (voz IN ('Femenina', 'Masculina')),
            costoGemas INT,
            costoMonenas INT,
            idAsistente INT NOT NULL,
            vigente CHAR(1) NOT NULL CHECK (vigente IN ('S', 'N')),
            FOREIGN KEY (idAsistente) REFERENCES ASISTENTE(idAsistente)
        );
        
        CREATE TABLE Usuario (
            email VARCHAR2(255) NOT NULL PRIMARY KEY,
            nombre VARCHAR2(255),
            rangoEdad VARCHAR2(10) CHECK (rangoEdad IN ('18-24', '25-34', '35-44', '45-54', '55-64', '65 o más')),
            fechaRegistro DATE NOT NULL,
            saldoGemas INT,
            saldoMonedas INT,
            idAsistente INT NOT NULL,
            FOREIGN KEY (idAsistente) REFERENCES ASISTENTE(idAsistente)  
        );
        
        
        CREATE TABLE Compra (
            idConfiguracion INT NOT NULL,
            email VARCHAR2(255) NOT NULL,
            fechaCompra DATE NOT NULL,
            totalGemas INT NOT NULL,
            totalMonedas INT NOT NULL,
            PRIMARY KEY (idConfiguracion, email, fechaCompra),
            FOREIGN KEY (idConfiguracion) REFERENCES CONFIGURACION(idConfiguracion),
            FOREIGN KEY (email) REFERENCES USUARIO(email)
        );
    
        INSERT INTO Asistente (idAsistente, nombre, genero) VALUES (1, 'Carlos', 'Masculino'); -- es valid
        INSERT INTO Asistente (idAsistente, nombre, genero) VALUES (2, 'Ana', 'Femenino'); -- no valid no es coach
        INSERT INTO Asistente (idAsistente, nombre, genero) VALUES (3, 'Alex', 'No binario'); -- no valid no es coach

        INSERT INTO Configuracion (idConfiguracion, ropa, interes, rasgo, voz, costoGemas, costoMonenas, idAsistente, vigente) VALUES (1, 'Verano', 'Deportes', 'Energético', 'Masculina', 20, 10, 1, 'S'); --valido (no valid por no ser amigo)
        INSERT INTO Configuracion (idConfiguracion, ropa, interes, rasgo, voz, costoGemas, costoMonenas, idAsistente, vigente) VALUES (2, 'Anime', 'Juegos', 'Soñador', 'Femenina', 15, 5, 2, 'S'); --valido
        INSERT INTO Configuracion (idConfiguracion, ropa, interes, rasgo, voz, costoGemas, costoMonenas, idAsistente, vigente) VALUES (3, 'Primavera', 'Moda', 'Artístico', 'Femenina', 30, 15, 3, 'S'); --no valid por compartir los dos
        INSERT INTO Configuracion (idConfiguracion, ropa, interes, rasgo, voz, costoGemas, costoMonenas, idAsistente, vigente) VALUES (4, 'Verano', 'Deportes', 'Energético', 'Masculina', 20, 10, 3, 'S'); --no valid por compartir los dos
        INSERT INTO Configuracion (idConfiguracion, ropa, interes, rasgo, voz, costoGemas, costoMonenas, idAsistente, vigente) VALUES (5, 'Anime', 'Juegos', 'Soñador', 'Femenina', 15, 5, 3, 'S'); --no valid por compartir los dos
        
        INSERT INTO Usuario (email, nombre, rangoEdad, fechaRegistro, saldoGemas, saldoMonedas, idAsistente) VALUES ('eje10@gmail.com', 'Juan', '25-34', DATE '2024-04-10', 100, 200, 1); --x
        INSERT INTO Usuario (email, nombre, rangoEdad, fechaRegistro, saldoGemas, saldoMonedas, idAsistente) VALUES ('eje2@gmail.com', 'Lucía', '18-24', DATE '2024-05-20', 50, 120, 2); --x
        INSERT INTO Usuario (email, nombre, rangoEdad, fechaRegistro, saldoGemas, saldoMonedas, idAsistente) VALUES ('eje1@gmail.com', 'Diego', '35-44', DATE '2024-10-15', 300, 50, 3); --x

        INSERT INTO Compra (idConfiguracion, email, fechaCompra, totalGemas, totalMonedas) VALUES (1, 'eje2@gmail.com', DATE '2024-06-02', 100, 90); -- x
        INSERT INTO Compra (idConfiguracion, email, fechaCompra, totalGemas, totalMonedas) VALUES (2, 'eje1@gmail.com', DATE '2024-06-15', 200, 80); -- x

        INSERT INTO Rol (idRol, tipo) VALUES (1, 'Coach'); 
        INSERT INTO Rol (idRol, tipo) VALUES (2, 'Amigo'); 
        INSERT INTO Rol (idRol, tipo) VALUES (3, 'Tutor'); 

        INSERT INTO AsignaRol (idAsistente, idRol) VALUES (1, 1); -- Carlos como Coach
        INSERT INTO AsignaRol (idAsistente, idRol) VALUES (2, 2); -- Ana como Amigo
        INSERT INTO AsignaRol (idAsistente, idRol) VALUES (3, 3); -- Alex como Tutor
        INSERT INTO AsignaRol (idAsistente, idRol) VALUES (3, 1); -- Alex como Tutor
        INSERT INTO AsignaRol (idAsistente, idRol) VALUES (3, 2); -- Alex como Tutor
    
    --Fin tabla 4
    Select a.*, u.nombre
    From asistente a
    Join usuario u ON u.idasistente = a.idasistente
    where Exists(
        select 1 
        From asignarol ar
        Join rol r on r.idrol = ar.idrol
        Where ar.idasistente = a.idasistente
        and r.tipo = 'Coach'
    )
    And Exists(
        select 1
        From asignarol ar
        Join rol r on r.idrol = ar.idrol
        Where ar.idasistente = a.idasistente
        and r.tipo = 'Amigo'
    )
    And Exists(
        select 1
        From asignarol ar
        Join rol r on r.idrol = ar.idrol
        Where ar.idasistente = a.idasistente
        and r.tipo = 'Tutor'
    )
    and u.fechaRegistro >= SYSDATE -30;
    
    --debe devolver:
    --  |   3   | Alex | No Binario | Diego |

-- Fin Ejercicio 4

-- Ejercicio 5
    
        --Tabla 5
    
        DROP TABLE Compra;
        DROP TABLE Usuario;
        DROP TABLE Configuracion;
        DROP TABLE AsignaRol;
        DROP TABLE Rol;
        DROP TABLE Asistente;
         
        CREATE TABLE Asistente (
            idAsistente INT NOT NULL PRIMARY KEY,
            nombre VARCHAR2(255) NOT NULL,
            genero VARCHAR2(50) NOT NULL CHECK (genero IN ('Femenino', 'Masculino', 'No binario'))
        );
         
        CREATE TABLE Rol (
            idRol INT NOT NULL PRIMARY KEY,
            tipo VARCHAR2(50) NOT NULL CHECK (tipo IN ('Tutor', 'Amigo', 'Coach'))
        );
          
        CREATE TABLE AsignaRol (
            idAsistente INT NOT NULL,
            idRol INT NOT NULL, 
            PRIMARY KEY (idAsistente, idRol),
            FOREIGN KEY (idAsistente) REFERENCES ASISTENTE(idAsistente),
            FOREIGN KEY (idRol) REFERENCES ROL(idRol) 
        );
        
        CREATE TABLE Configuracion (
            idConfiguracion INT NOT NULL PRIMARY KEY,
            ropa VARCHAR2(50) NOT NULL CHECK (ropa IN ('Verano', 'Primavera', 'Anime', 'Oficina', 'Fiesta', 'Deporte', 'Camisetas')),
            interes VARCHAR2(50) NOT NULL CHECK (interes IN ('Juegos', 'Deportes', 'Historia', 'Moda')),
            rasgo VARCHAR2(50) NOT NULL CHECK (rasgo IN ('Seguro', 'Tímido', 'Energético', 'Práctico', 'Soñador', 'Artístico', 'Lógico')),
            voz VARCHAR2(50) NOT NULL CHECK (voz IN ('Femenina', 'Masculina')),
            costoGemas INT,
            costoMonenas INT,
            idAsistente INT NOT NULL,
            vigente CHAR(1) NOT NULL CHECK (vigente IN ('S', 'N')),
            FOREIGN KEY (idAsistente) REFERENCES ASISTENTE(idAsistente)
        );
        
        CREATE TABLE Usuario (
            email VARCHAR2(255) NOT NULL PRIMARY KEY,
            nombre VARCHAR2(255),
            rangoEdad VARCHAR2(10) CHECK (rangoEdad IN ('18-24', '25-34', '35-44', '45-54', '55-64', '65 o más')),
            fechaRegistro DATE NOT NULL,
            saldoGemas INT,
            saldoMonedas INT,
            idAsistente INT NOT NULL,
            FOREIGN KEY (idAsistente) REFERENCES ASISTENTE(idAsistente)  
        );
        
        
        CREATE TABLE Compra (
            idConfiguracion INT NOT NULL,
            email VARCHAR2(255) NOT NULL,
            fechaCompra DATE NOT NULL,
            totalGemas INT NOT NULL,
            totalMonedas INT NOT NULL,
            PRIMARY KEY (idConfiguracion, email, fechaCompra),
            FOREIGN KEY (idConfiguracion) REFERENCES CONFIGURACION(idConfiguracion),
            FOREIGN KEY (email) REFERENCES USUARIO(email)
        );
    
        INSERT INTO Asistente (idAsistente, nombre, genero) VALUES (1, 'Carlos', 'Masculino'); -- es valid
        INSERT INTO Asistente (idAsistente, nombre, genero) VALUES (2, 'Ana', 'Femenino'); -- no valid no es coach
        INSERT INTO Asistente (idAsistente, nombre, genero) VALUES (3, 'Alex', 'No binario'); -- no valid no es coach

        INSERT INTO Configuracion (idConfiguracion, ropa, interes, rasgo, voz, costoGemas, costoMonenas, idAsistente, vigente) VALUES (1, 'Verano', 'Deportes', 'Energético', 'Masculina', 20, 10, 1, 'S'); --valido (no valid por no ser amigo)
        INSERT INTO Configuracion (idConfiguracion, ropa, interes, rasgo, voz, costoGemas, costoMonenas, idAsistente, vigente) VALUES (2, 'Anime', 'Juegos', 'Soñador', 'Femenina', 15, 5, 2, 'S'); --valido
        INSERT INTO Configuracion (idConfiguracion, ropa, interes, rasgo, voz, costoGemas, costoMonenas, idAsistente, vigente) VALUES (3, 'Primavera', 'Moda', 'Artístico', 'Femenina', 30, 15, 3, 'S'); --no valid por compartir los dos
        
        INSERT INTO Usuario (email, nombre, rangoEdad, fechaRegistro, saldoGemas, saldoMonedas, idAsistente) VALUES ('eje10@gmail.com', 'Juan', '25-34', DATE '2024-04-10', 100, 200, 1); --x
        INSERT INTO Usuario (email, nombre, rangoEdad, fechaRegistro, saldoGemas, saldoMonedas, idAsistente) VALUES ('eje1@gmail.com', 'Diego', '55-64', DATE '2024-10-15', 300, 50, 3); --x

        INSERT INTO Compra (idConfiguracion, email, fechaCompra, totalGemas, totalMonedas) VALUES (3, 'eje1@gmail.com', DATE '2024-06-15', 200, 80); -- x

        INSERT INTO Rol (idRol, tipo) VALUES (1, 'Coach'); 
        INSERT INTO Rol (idRol, tipo) VALUES (2, 'Amigo'); 
        INSERT INTO Rol (idRol, tipo) VALUES (3, 'Tutor'); 

        INSERT INTO AsignaRol (idAsistente, idRol) VALUES (1, 1); -- Carlos como Coach
        INSERT INTO AsignaRol (idAsistente, idRol) VALUES (2, 2); -- Ana como Amigo
        INSERT INTO AsignaRol (idAsistente, idRol) VALUES (3, 3); -- Alex como Tutor
        INSERT INTO AsignaRol (idAsistente, idRol) VALUES (3, 1); -- Alex como Tutor
        INSERT INTO AsignaRol (idAsistente, idRol) VALUES (3, 2); -- Alex como Tutor
    
    --Fin tabla 5
    
    Select u.nombre
    From usuario u
    Join configuracion c ON c.idasistente = u.idasistente
    Join compra c2 ON c2.idconfiguracion = c.idconfiguracion
    Where (U.rangoEdad = '55-64'
       OR U.rangoEdad = '65 o más')
    And c2.totalmonedas = (select max(totalmonedas)
    from compra c2 
    Join configuracion c ON c2.idconfiguracion = c.idconfiguracion
    Join usuario u ON c.idasistente = u.idasistente
    );
    --DEBE DEVOLVER DIEGO   
    
-- Fin Ejercicio 5

-- Ejercicio 6

        --Tabla 6
    
        DROP TABLE Compra;
        DROP TABLE Usuario;
        DROP TABLE Configuracion;
        DROP TABLE AsignaRol;
        DROP TABLE Rol;
        DROP TABLE Asistente;
         
        CREATE TABLE Asistente (
            idAsistente INT NOT NULL PRIMARY KEY,
            nombre VARCHAR2(255) NOT NULL,
            genero VARCHAR2(50) NOT NULL CHECK (genero IN ('Femenino', 'Masculino', 'No binario'))
        );
         
        CREATE TABLE Rol (
            idRol INT NOT NULL PRIMARY KEY,
            tipo VARCHAR2(50) NOT NULL CHECK (tipo IN ('Tutor', 'Amigo', 'Coach'))
        );
          
        CREATE TABLE AsignaRol (
            idAsistente INT NOT NULL,
            idRol INT NOT NULL, 
            PRIMARY KEY (idAsistente, idRol),
            FOREIGN KEY (idAsistente) REFERENCES ASISTENTE(idAsistente),
            FOREIGN KEY (idRol) REFERENCES ROL(idRol) 
        );
        
        CREATE TABLE Configuracion (
            idConfiguracion INT NOT NULL PRIMARY KEY,
            ropa VARCHAR2(50) NOT NULL CHECK (ropa IN ('Verano', 'Primavera', 'Anime', 'Oficina', 'Fiesta', 'Deporte', 'Camisetas')),
            interes VARCHAR2(50) NOT NULL CHECK (interes IN ('Juegos', 'Deportes', 'Historia', 'Moda')),
            rasgo VARCHAR2(50) NOT NULL CHECK (rasgo IN ('Seguro', 'Tímido', 'Energético', 'Práctico', 'Soñador', 'Artístico', 'Lógico')),
            voz VARCHAR2(50) NOT NULL CHECK (voz IN ('Femenina', 'Masculina')),
            costoGemas INT,
            costoMonenas INT,
            idAsistente INT NOT NULL,
            vigente CHAR(1) NOT NULL CHECK (vigente IN ('S', 'N')),
            FOREIGN KEY (idAsistente) REFERENCES ASISTENTE(idAsistente)
        );
        
        CREATE TABLE Usuario (
            email VARCHAR2(255) NOT NULL PRIMARY KEY,
            nombre VARCHAR2(255),
            rangoEdad VARCHAR2(10) CHECK (rangoEdad IN ('18-24', '25-34', '35-44', '45-54', '55-64', '65 o más')),
            fechaRegistro DATE NOT NULL,
            saldoGemas INT,
            saldoMonedas INT,
            idAsistente INT NOT NULL,
            FOREIGN KEY (idAsistente) REFERENCES ASISTENTE(idAsistente)  
        );
        
        
        CREATE TABLE Compra (
            idConfiguracion INT NOT NULL,
            email VARCHAR2(255) NOT NULL,
            fechaCompra DATE NOT NULL,
            totalGemas INT NOT NULL,
            totalMonedas INT NOT NULL,
            PRIMARY KEY (idConfiguracion, email, fechaCompra),
            FOREIGN KEY (idConfiguracion) REFERENCES CONFIGURACION(idConfiguracion),
            FOREIGN KEY (email) REFERENCES USUARIO(email)
        );
    
        INSERT INTO Asistente (idAsistente, nombre, genero) VALUES (1, 'Carlos', 'Masculino'); -- es valid
        INSERT INTO Asistente (idAsistente, nombre, genero) VALUES (2, 'Ana', 'Femenino'); -- no valid no es coach
        INSERT INTO Asistente (idAsistente, nombre, genero) VALUES (3, 'Alex', 'No binario'); -- no valid no es coach

        INSERT INTO Configuracion (idConfiguracion, ropa, interes, rasgo, voz, costoGemas, costoMonenas, idAsistente, vigente) VALUES (1, 'Verano', 'Deportes', 'Energético', 'Masculina', 20, 10, 1, 'S'); --valido (no valid por no ser amigo)
        INSERT INTO Configuracion (idConfiguracion, ropa, interes, rasgo, voz, costoGemas, costoMonenas, idAsistente, vigente) VALUES (2, 'Anime', 'Juegos', 'Soñador', 'Femenina', 15, 5, 2, 'S'); --valido
        INSERT INTO Configuracion (idConfiguracion, ropa, interes, rasgo, voz, costoGemas, costoMonenas, idAsistente, vigente) VALUES (3, 'Primavera', 'Moda', 'Artístico', 'Femenina', 30, 15, 3, 'S'); --no valid por compartir los dos
        INSERT INTO Configuracion (idConfiguracion, ropa, interes, rasgo, voz, costoGemas, costoMonenas, idAsistente, vigente) VALUES (4, 'Verano', 'Deportes', 'Energético', 'Masculina', 20, 10, 3, 'S'); --no valid por compartir los dos
        INSERT INTO Configuracion (idConfiguracion, ropa, interes, rasgo, voz, costoGemas, costoMonenas, idAsistente, vigente) VALUES (5, 'Anime', 'Juegos', 'Soñador', 'Femenina', 15, 5, 3, 'S'); --no valid por compartir los dos
        
        INSERT INTO Usuario (email, nombre, rangoEdad, fechaRegistro, saldoGemas, saldoMonedas, idAsistente) VALUES ('eje10@gmail.com', 'Juan', '25-34', DATE '2024-04-10', 100, 200, 1); --x
        INSERT INTO Usuario (email, nombre, rangoEdad, fechaRegistro, saldoGemas, saldoMonedas, idAsistente) VALUES ('eje2@gmail.com', 'Lucía', '35-44', DATE '2024-05-20', 50, 120, 2); --x
        INSERT INTO Usuario (email, nombre, rangoEdad, fechaRegistro, saldoGemas, saldoMonedas, idAsistente) VALUES ('eje1@gmail.com', 'Diego', '55-64', DATE '2024-10-15', 300, 50, 3); --x

        INSERT INTO Compra (idConfiguracion, email, fechaCompra, totalGemas, totalMonedas) VALUES (1, 'eje2@gmail.com', DATE '2024-06-02', 100, 90); -- x
        INSERT INTO Compra (idConfiguracion, email, fechaCompra, totalGemas, totalMonedas) VALUES (2, 'eje1@gmail.com', DATE '2024-06-15', 200, 80); -- x

        INSERT INTO Rol (idRol, tipo) VALUES (1, 'Coach'); 
        INSERT INTO Rol (idRol, tipo) VALUES (2, 'Amigo'); 
        INSERT INTO Rol (idRol, tipo) VALUES (3, 'Tutor'); 

        INSERT INTO AsignaRol (idAsistente, idRol) VALUES (1, 1); -- Carlos como Coach
        INSERT INTO AsignaRol (idAsistente, idRol) VALUES (2, 2); -- Ana como Amigo
        INSERT INTO AsignaRol (idAsistente, idRol) VALUES (3, 3); -- Alex como Tutor
        INSERT INTO AsignaRol (idAsistente, idRol) VALUES (3, 1); -- Alex como Tutor
        INSERT INTO AsignaRol (idAsistente, idRol) VALUES (3, 2); -- Alex como Tutor
    
    --Fin tabla 6

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

    --tiene que devolver:
    --| eje2@gmail.com | Lucia | 35-44 | 20/05/2024 00:00:00 | 50 | 120 | 2 |

-- Fin Ejercicio 6

-- Ejercicio 7

     --Tabla 7
    
        DROP TABLE Compra;
        DROP TABLE Usuario;
        DROP TABLE Configuracion;
        DROP TABLE AsignaRol;
        DROP TABLE Rol;
        DROP TABLE Asistente;
         
        CREATE TABLE Asistente (
            idAsistente INT NOT NULL PRIMARY KEY,
            nombre VARCHAR2(255) NOT NULL,
            genero VARCHAR2(50) NOT NULL CHECK (genero IN ('Femenino', 'Masculino', 'No binario'))
        );
         
        CREATE TABLE Rol (
            idRol INT NOT NULL PRIMARY KEY,
            tipo VARCHAR2(50) NOT NULL CHECK (tipo IN ('Tutor', 'Amigo', 'Coach'))
        );
          
        CREATE TABLE AsignaRol (
            idAsistente INT NOT NULL,
            idRol INT NOT NULL, 
            PRIMARY KEY (idAsistente, idRol),
            FOREIGN KEY (idAsistente) REFERENCES ASISTENTE(idAsistente),
            FOREIGN KEY (idRol) REFERENCES ROL(idRol) 
        );
        
        CREATE TABLE Configuracion (
            idConfiguracion INT NOT NULL PRIMARY KEY,
            ropa VARCHAR2(50) NOT NULL CHECK (ropa IN ('Verano', 'Primavera', 'Anime', 'Oficina', 'Fiesta', 'Deporte', 'Camisetas')),
            interes VARCHAR2(50) NOT NULL CHECK (interes IN ('Juegos', 'Deportes', 'Historia', 'Moda')),
            rasgo VARCHAR2(50) NOT NULL CHECK (rasgo IN ('Seguro', 'Tímido', 'Energético', 'Práctico', 'Soñador', 'Artístico', 'Lógico')),
            voz VARCHAR2(50) NOT NULL CHECK (voz IN ('Femenina', 'Masculina')),
            costoGemas INT,
            costoMonenas INT,
            idAsistente INT NOT NULL,
            vigente CHAR(1) NOT NULL CHECK (vigente IN ('S', 'N')),
            FOREIGN KEY (idAsistente) REFERENCES ASISTENTE(idAsistente)
        );
        
        CREATE TABLE Usuario (
            email VARCHAR2(255) NOT NULL PRIMARY KEY,
            nombre VARCHAR2(255),
            rangoEdad VARCHAR2(10) CHECK (rangoEdad IN ('18-24', '25-34', '35-44', '45-54', '55-64', '65 o más')),
            fechaRegistro DATE NOT NULL,
            saldoGemas INT,
            saldoMonedas INT,
            idAsistente INT NOT NULL,
            FOREIGN KEY (idAsistente) REFERENCES ASISTENTE(idAsistente)  
        );
        
        
        CREATE TABLE Compra (
            idConfiguracion INT NOT NULL,
            email VARCHAR2(255) NOT NULL,
            fechaCompra DATE NOT NULL,
            totalGemas INT NOT NULL,
            totalMonedas INT NOT NULL,
            PRIMARY KEY (idConfiguracion, email, fechaCompra),
            FOREIGN KEY (idConfiguracion) REFERENCES CONFIGURACION(idConfiguracion),
            FOREIGN KEY (email) REFERENCES USUARIO(email)
        );
    
        INSERT INTO Asistente (idAsistente, nombre, genero) VALUES (1, 'Carlos', 'Masculino'); -- es valid
        INSERT INTO Asistente (idAsistente, nombre, genero) VALUES (2, 'Ana', 'Femenino'); -- no valid no es coach
        INSERT INTO Asistente (idAsistente, nombre, genero) VALUES (3, 'Alex', 'No binario'); -- no valid no es coach

        INSERT INTO Configuracion (idConfiguracion, ropa, interes, rasgo, voz, costoGemas, costoMonenas, idAsistente, vigente) VALUES (1, 'Verano', 'Deportes', 'Energético', 'Masculina', 20, 10, 1, 'S'); --valido (no valid por no ser amigo)
        INSERT INTO Configuracion (idConfiguracion, ropa, interes, rasgo, voz, costoGemas, costoMonenas, idAsistente, vigente) VALUES (2, 'Anime', 'Juegos', 'Soñador', 'Femenina', 15, 5, 2, 'S'); --valido
        INSERT INTO Configuracion (idConfiguracion, ropa, interes, rasgo, voz, costoGemas, costoMonenas, idAsistente, vigente) VALUES (3, 'Primavera', 'Moda', 'Artístico', 'Femenina', 30, 15, 3, 'S'); --no valid por compartir los dos
        INSERT INTO Configuracion (idConfiguracion, ropa, interes, rasgo, voz, costoGemas, costoMonenas, idAsistente, vigente) VALUES (4, 'Verano', 'Deportes', 'Energético', 'Masculina', 20, 10, 3, 'S'); --no valid por compartir los dos
        INSERT INTO Configuracion (idConfiguracion, ropa, interes, rasgo, voz, costoGemas, costoMonenas, idAsistente, vigente) VALUES (5, 'Anime', 'Juegos', 'Soñador', 'Femenina', 15, 5, 3, 'S'); --no valid por compartir los dos
        
        INSERT INTO Usuario (email, nombre, rangoEdad, fechaRegistro, saldoGemas, saldoMonedas, idAsistente) VALUES ('eje10@gmail.com', 'Juan', '25-34', DATE '2024-04-10', 100, 200, 1); --x
        INSERT INTO Usuario (email, nombre, rangoEdad, fechaRegistro, saldoGemas, saldoMonedas, idAsistente) VALUES ('eje2@gmail.com', 'Lucía', '35-44', DATE '2024-05-20', 50, 120, 2); --x
        INSERT INTO Usuario (email, nombre, rangoEdad, fechaRegistro, saldoGemas, saldoMonedas, idAsistente) VALUES ('eje1@gmail.com', 'Diego', '55-64', DATE '2024-10-15', 300, 50, 3); --x

        INSERT INTO Compra (idConfiguracion, email, fechaCompra, totalGemas, totalMonedas) VALUES (1, 'eje2@gmail.com', DATE '2024-06-02', 100, 90); -- x
        INSERT INTO Compra (idConfiguracion, email, fechaCompra, totalGemas, totalMonedas) VALUES (2, 'eje1@gmail.com', DATE '2024-06-15', 200, 80); -- x

        INSERT INTO Rol (idRol, tipo) VALUES (1, 'Coach'); 
        INSERT INTO Rol (idRol, tipo) VALUES (2, 'Amigo'); 
        INSERT INTO Rol (idRol, tipo) VALUES (3, 'Tutor'); 

        INSERT INTO AsignaRol (idAsistente, idRol) VALUES (1, 1); -- Carlos como Coach
        INSERT INTO AsignaRol (idAsistente, idRol) VALUES (2, 2); -- Ana como Amigo
        INSERT INTO AsignaRol (idAsistente, idRol) VALUES (3, 3); -- Alex como Tutor
        INSERT INTO AsignaRol (idAsistente, idRol) VALUES (3, 1); -- Alex como Tutor
        INSERT INTO AsignaRol (idAsistente, idRol) VALUES (3, 2); -- Alex como Tutor
    
    --Fin tabla 7

    

-- Fin Ejercicio 7

-- Ejercicio 8

     --Tabla 8
    
        DROP TABLE Compra;
        DROP TABLE Usuario;
        DROP TABLE Configuracion;
        DROP TABLE AsignaRol;
        DROP TABLE Rol;
        DROP TABLE Asistente;
         
        CREATE TABLE Asistente (
            idAsistente INT NOT NULL PRIMARY KEY,
            nombre VARCHAR2(255) NOT NULL,
            genero VARCHAR2(50) NOT NULL CHECK (genero IN ('Femenino', 'Masculino', 'No binario'))
        );
         
        CREATE TABLE Rol (
            idRol INT NOT NULL PRIMARY KEY,
            tipo VARCHAR2(50) NOT NULL CHECK (tipo IN ('Tutor', 'Amigo', 'Coach'))
        );
          
        CREATE TABLE AsignaRol (
            idAsistente INT NOT NULL,
            idRol INT NOT NULL, 
            PRIMARY KEY (idAsistente, idRol),
            FOREIGN KEY (idAsistente) REFERENCES ASISTENTE(idAsistente),
            FOREIGN KEY (idRol) REFERENCES ROL(idRol) 
        );
        
        CREATE TABLE Configuracion (
            idConfiguracion INT NOT NULL PRIMARY KEY,
            ropa VARCHAR2(50) NOT NULL CHECK (ropa IN ('Verano', 'Primavera', 'Anime', 'Oficina', 'Fiesta', 'Deporte', 'Camisetas')),
            interes VARCHAR2(50) NOT NULL CHECK (interes IN ('Juegos', 'Deportes', 'Historia', 'Moda')),
            rasgo VARCHAR2(50) NOT NULL CHECK (rasgo IN ('Seguro', 'Tímido', 'Energético', 'Práctico', 'Soñador', 'Artístico', 'Lógico')),
            voz VARCHAR2(50) NOT NULL CHECK (voz IN ('Femenina', 'Masculina')),
            costoGemas INT,
            costoMonenas INT,
            idAsistente INT NOT NULL,
            vigente CHAR(1) NOT NULL CHECK (vigente IN ('S', 'N')),
            FOREIGN KEY (idAsistente) REFERENCES ASISTENTE(idAsistente)
        );
        
        CREATE TABLE Usuario (
            email VARCHAR2(255) NOT NULL PRIMARY KEY,
            nombre VARCHAR2(255),
            rangoEdad VARCHAR2(10) CHECK (rangoEdad IN ('18-24', '25-34', '35-44', '45-54', '55-64', '65 o más')),
            fechaRegistro DATE NOT NULL,
            saldoGemas INT,
            saldoMonedas INT,
            idAsistente INT NOT NULL,
            FOREIGN KEY (idAsistente) REFERENCES ASISTENTE(idAsistente)  
        );
        
        
        CREATE TABLE Compra (
            idConfiguracion INT NOT NULL,
            email VARCHAR2(255) NOT NULL,
            fechaCompra DATE NOT NULL,
            totalGemas INT NOT NULL,
            totalMonedas INT NOT NULL,
            PRIMARY KEY (idConfiguracion, email, fechaCompra),
            FOREIGN KEY (idConfiguracion) REFERENCES CONFIGURACION(idConfiguracion),
            FOREIGN KEY (email) REFERENCES USUARIO(email)
        );
    
        INSERT INTO Asistente (idAsistente, nombre, genero) VALUES (1, 'Carlos', 'Masculino'); -- es valid
        INSERT INTO Asistente (idAsistente, nombre, genero) VALUES (2, 'Ana', 'Femenino'); -- no valid no es coach
        INSERT INTO Asistente (idAsistente, nombre, genero) VALUES (3, 'Alex', 'No binario'); -- no valid no es coach

        INSERT INTO Configuracion (idConfiguracion, ropa, interes, rasgo, voz, costoGemas, costoMonenas, idAsistente, vigente) VALUES (1, 'Verano', 'Deportes', 'Energético', 'Masculina', 20, 10, 1, 'S'); --valido (no valid por no ser amigo)
        INSERT INTO Configuracion (idConfiguracion, ropa, interes, rasgo, voz, costoGemas, costoMonenas, idAsistente, vigente) VALUES (2, 'Anime', 'Juegos', 'Soñador', 'Femenina', 15, 5, 2, 'S'); --valido
        INSERT INTO Configuracion (idConfiguracion, ropa, interes, rasgo, voz, costoGemas, costoMonenas, idAsistente, vigente) VALUES (3, 'Primavera', 'Moda', 'Artístico', 'Femenina', 30, 15, 3, 'S'); --no valid por compartir los dos
        INSERT INTO Configuracion (idConfiguracion, ropa, interes, rasgo, voz, costoGemas, costoMonenas, idAsistente, vigente) VALUES (4, 'Verano', 'Deportes', 'Energético', 'Masculina', 20, 10, 3, 'S'); --no valid por compartir los dos
        INSERT INTO Configuracion (idConfiguracion, ropa, interes, rasgo, voz, costoGemas, costoMonenas, idAsistente, vigente) VALUES (5, 'Anime', 'Juegos', 'Soñador', 'Femenina', 15, 5, 3, 'S'); --no valid por compartir los dos
        
        INSERT INTO Usuario (email, nombre, rangoEdad, fechaRegistro, saldoGemas, saldoMonedas, idAsistente) VALUES ('eje10@gmail.com', 'Juan', '25-34', DATE '2024-04-10', 100, 200, 1); --x
        INSERT INTO Usuario (email, nombre, rangoEdad, fechaRegistro, saldoGemas, saldoMonedas, idAsistente) VALUES ('eje2@gmail.com', 'Lucía', '35-44', DATE '2024-05-20', 50, 120, 2); --x
        INSERT INTO Usuario (email, nombre, rangoEdad, fechaRegistro, saldoGemas, saldoMonedas, idAsistente) VALUES ('eje1@gmail.com', 'Diego', '55-64', DATE '2024-10-15', 300, 50, 3); --x

        INSERT INTO Compra (idConfiguracion, email, fechaCompra, totalGemas, totalMonedas) VALUES (1, 'eje2@gmail.com', DATE '2024-06-02', 100, 90); -- x
        INSERT INTO Compra (idConfiguracion, email, fechaCompra, totalGemas, totalMonedas) VALUES (2, 'eje1@gmail.com', DATE '2024-06-15', 200, 80); -- x

        INSERT INTO Rol (idRol, tipo) VALUES (1, 'Coach'); 
        INSERT INTO Rol (idRol, tipo) VALUES (2, 'Amigo'); 
        INSERT INTO Rol (idRol, tipo) VALUES (3, 'Tutor'); 

        INSERT INTO AsignaRol (idAsistente, idRol) VALUES (1, 1); -- Carlos como Coach
        INSERT INTO AsignaRol (idAsistente, idRol) VALUES (2, 2); -- Ana como Amigo
        INSERT INTO AsignaRol (idAsistente, idRol) VALUES (3, 3); -- Alex como Tutor
        INSERT INTO AsignaRol (idAsistente, idRol) VALUES (3, 1); -- Alex como Tutor
        INSERT INTO AsignaRol (idAsistente, idRol) VALUES (3, 2); -- Alex como Tutor
    
    --fin tablas 8

    Select c.*, c2.totalgemas, c2.fechacompra
    From configuracion c
    Join compra c2 ON c.idconfiguracion = c2.idconfiguracion
    where c2.fechacompra >= '01/12/2023 00:00:00'
    and c2.fechaCompra <= sysdate;
    
--poner que sea la confi que tenga mas compras
    
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