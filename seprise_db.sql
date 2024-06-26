drop database if exists seprise_db;
create database seprise_db;
use seprise_db;

create table pacientes (
dni int not null primary key,
nombre varchar(30),
apellido varchar(30),
num_Telefono bigint
);

create table historias_clinicas (
id int not null primary key,
dni_paciente int,
informacion_paciente varchar(500),
foreign key (dni_paciente) references pacientes(dni)

);

create table roles(
userRol int primary key,
rolName varchar(30)
);

create table usuarios(
id int not null auto_increment primary key,
rol int,
dni int,
username varchar(30),
password varchar(30), 
foreign key (rol) references roles(userRol)
);

insert into roles values
(101,'Administrativo'),
(102,'Medico'),
(103,'Tecnico');

create table medicos(
dni int not null primary key,
nombre varchar(30), 
apellido varchar (30),
especialidad varchar(30)
);

create table turnos(
id int not null auto_increment primary key, 
fecha_turno datetime,   
notas varchar(500),
tipo_turno int,
/*1 para medico, 2 para lab*/
dni_medico INT NULL, 
dni_paciente int,
cancelado bool,
foreign key (dni_paciente) references pacientes(dni),
/*tengo aca los mismos para el medico o el de laboratorio, pero si es laboratorio mandamos null*/
foreign key (dni_medico) REFERENCES medicos(dni)
);

create table agendas_dias(
id_agenda int not null auto_increment primary key,
fecha_agenda datetime,
estado int,
/*1 no acreditado, 2 en espera de atencion, 3 atencion en curso 4 turno finalizado*/
id_turno int,
dni_medico int NULL,
/*Para diferenciar a los de los medicos de los de los tecnicos*/
medico bool,
foreign key (id_turno) references turnos(id),
foreign key (dni_medico) references medicos(dni)
);

create table comprobantes_turnos(
id int not null auto_increment primary key,
fecha_emision datetime,
cancelado bool,
dni_paciente int,
foreign key (dni_paciente) references pacientes(dni)
);

create table comprobantes_retiros_labs(
id int not null auto_increment primary key,
fecha_emision datetime,
fecha_retiro datetime,
nombre_estudio varchar(100),
dni_paciente int,
foreign key (dni_paciente) references pacientes(dni)
);

create table laboratorios(
id int not null auto_increment primary key
);

create table insumos_clinicas(
id int not null auto_increment primary key,
id_laboratorio int,
insumos_stock bigint,
foreign key (id_laboratorio) references laboratorios(id)
);

create table insumos_laboratorios(
id int not null auto_increment primary key,
insumos_stock bigint
);

insert into pacientes values
(42189130, "Florencia", "Diaz", 3814980098),
(38127837, "Nicolas", "Gomez", 3814980333),
(17238947, "Matias", "Castillo", 3814980228),
(42189330, "Guillermo", "Hernandez", 3814192098),
(28938178, "Martina", "Del Valle", 3814988798),
(21893278, "Laura", "Fernandez", 3814678098),
(19283179, "Roberto", "Leon", 3814982548),
(43172897, "Micaela", "Ortega", 3814980678);

insert into historias_clinicas values
(1, 42189130, 'Información del paciente Florencia Diaz'),
(2, 38127837, 'Información del paciente Nicolas Gomez'),
(3, 17238947, 'Información del paciente Matias Castillo'),
(4, 42189330, 'Información del paciente Guillermo Hernandez'),
(5, 28938178, 'Información del paciente Martina Del Valle'),
(6, 21893278, 'Información del paciente Laura Fernandez'),
(7, 19283179, 'Información del paciente Roberto Leon'),
(8, 43172897, 'Información del paciente Micaela Ortega');

insert into usuarios values
(not null, 101, 40890128,"administrativo", "12345"),
(not null, 102, 20100200,"medico1", "12345"),
(not null, 102, 20200200,"medico2", "12345"),
(not null, 103, 23918283, "tecnico", "12345");

insert into medicos(dni, nombre, apellido, especialidad) values 
(20100200, "Juan", "Perez", "Dermatólogo"),
(23100200, "Lucia", "Martinez", "Endocrinólga"),
(20200200, "Guillermina", "Del Puente", "Cardiologa");


