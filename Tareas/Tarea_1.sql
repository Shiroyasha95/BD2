CREATE DATABASE [tarea_1]
GO

CREATE TABLE hotel(
codigo INTEGER PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
direccion VARCHAR(250) NOT NULL,
);
GO

CREATE TABLE clientes (
id_cliente INTEGER PRIMARY KEY IDENTITY (1,1),
identidad VARCHAR(15) NOT NULL UNIQUE CONSTRAINT CK_clientes_identidad CHECK (identidad LIKE '[0-1][0-8][0-2][0-4][-][1-2][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9][0-9]'),
nombre VARCHAR (100) NOT NULL,
telefono VARCHAR (100) NOT NULL,
);
GO

CREATE TABLE aerolinea(
id_aerolinea INTEGER PRIMARY KEY IDENTITY (1,1),
codigo_aerolinea INTEGER UNIQUE,
descuento FLOAT NOT NULL CONSTRAINT CK_aerolinea_descuento CHECK (descuento >= 10.00),
);
GO

CREATE TABLE boletos(
id_boletos INTEGER PRIMARY KEY IDENTITY (1,1),
codigo_boleto INTEGER UNIQUE,
no_vuelo VARCHAR(100) NOT NULL,
fecha DATE NOT NULL,
destino VARCHAR(250) NOT NULL CONSTRAINT CK_boletos_destino CHECK (destino in ('Mexico','Guatemala','Panama')),
aerolinea INTEGER NOT NULL FOREIGN KEY REFERENCES aerolinea(id_aerolinea),
);
GO

CREATE TABLE boletos_adquiridos (
id_boletos_adquiridos INTEGER PRIMARY KEY IDENTITY (1,1),
id_cliente INTEGER NOT NULL FOREIGN KEY REFERENCES clientes(id_cliente),
id_boleto INTEGER NOT NULL FOREIGN KEY REFERENCES boletos(id_boletos),
);
GO

CREATE TABLE reservaciones(
id_reserva INTEGER PRIMARY KEY IDENTITY (1,1),
id_cliente INTEGER NOT NULL FOREIGN KEY REFERENCES clientes(id_cliente),
id_hotel INTEGER NOT NULL FOREIGN KEY REFERENCES hotel(codigo),
fechain DATE NOT NULL,
fechaout DATE NOT NULL,
cantidad_personas INTEGER DEFAULT 0,
);
GO