CONNECT TO 'matias@172.16.129.130' USER 'XXXUSERNAMEXXX' USING 'XXXPASSWORDXXX';

DROP TABLE IF EXISTS Docentes;

CREATE TABLE Docentes (

    CI INT PRIMARY KEY CONSTRAINT CI_valida,
    nombre varchar(30) NOT NULL CONSTRAINT Nombre_valido,
    apellido varchar(30) NOT NULL CONSTRAINT Apellido_valido,
    fecha_Nac DATE NOT NULL CONSTRAINT Fecha_Nac_valida,
    grado INT CHECK ( grado > 0 AND grado < 8)
);
