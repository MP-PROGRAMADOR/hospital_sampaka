
-- Tabla: personal
CREATE TABLE personal (
    id SERIAL PRIMARY KEY,
    codigo_personal VARCHAR(50) UNIQUE,
    nombre VARCHAR(100),
    apellidos VARCHAR(100),
    fecha_nacimiento DATE,
    residencia VARCHAR(150),
    nivel_educacional VARCHAR(100),
    cargo VARCHAR(100),
    telefono VARCHAR(20),
    correo VARCHAR(100),
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla: usuarios
CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    nombre_usuario VARCHAR(50) UNIQUE,
    password VARCHAR(255),
    rol VARCHAR(50),
    id_personal INT,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_personal) REFERENCES personal(id)
);

-- Tabla: pacientes
CREATE TABLE pacientes (
    id SERIAL PRIMARY KEY,
    codigo_paciente VARCHAR(50) UNIQUE,
    nombre VARCHAR(100),
    apellidos VARCHAR(100),
    fecha_nacimiento DATE,
    telefono VARCHAR(20),
    residencia VARCHAR(150),
    profesion VARCHAR(100),
    ocupacion VARCHAR(100),
    nacionalidad VARCHAR(50),
    tutor VARCHAR(100),
    telefono_tutor VARCHAR(20),
    id_usuario INT,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id)
);

-- Tabla: consulta
CREATE TABLE consulta (
    id SERIAL PRIMARY KEY,
    motivo_consulta TEXT,
    temperatura DECIMAL(4,1),
    frecuencia_cardiaca INT,
    frecuencia_respiratoria INT,
    tension_arterial VARCHAR(20),
    pulso INT,
    saturacion_oxigeno DECIMAL(4,1),
    peso DECIMAL(5,2),
    masa_indice_corporal DECIMAL(5,2),
    id_usuario INT,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_paciente INT,
    codigo_paciente VARCHAR(50),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id),
    FOREIGN KEY (id_paciente) REFERENCES pacientes(id)
);

-- Tabla: detalle_consulta
CREATE TABLE detalle_consulta (
    id SERIAL PRIMARY KEY,
    id_consulta INT,
    id_usuario INT,
    operacion BOOLEAN,
    orina BOOLEAN,
    defeca BOOLEAN,
    intervalo_defecacion_dias INT,
    duerme_bien BOOLEAN,
    horas_sueño INT,
    antecedentes_patologicos TEXT,
    alergico TEXT,
    antecedentes_patologicos_familiares TEXT,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_consulta) REFERENCES consulta(id),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id)
);

-- Tabla: receta
CREATE TABLE receta (
    id SERIAL PRIMARY KEY,
    descripcion TEXT,
    id_usuario INT,
    observaciones TEXT,
    id_consulta INT,
    id_paciente INT,
    codigo_paciente VARCHAR(50),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id),
    FOREIGN KEY (id_consulta) REFERENCES consulta(id),
    FOREIGN KEY (id_paciente) REFERENCES pacientes(id)
);

-- Tabla: pruebas_hospital
CREATE TABLE pruebas_hospital (
    id SERIAL PRIMARY KEY,
    nombre_prueba VARCHAR(100),
    precio DECIMAL(10,2),
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla: analiticas
CREATE TABLE analiticas (
    id SERIAL PRIMARY KEY,
    resultado TEXT,
    estado VARCHAR(50),
    id_prueba INT,
    id_consulta INT,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_usuario INT,
    id_paciente INT,
    codigo_paciente VARCHAR(50),
    pagado BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_prueba) REFERENCES pruebas_hospital(id),
    FOREIGN KEY (id_consulta) REFERENCES consulta(id),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id),
    FOREIGN KEY (id_paciente) REFERENCES pacientes(id)
);

-- Tabla: salas_ingreso
CREATE TABLE salas_ingreso (
    id SERIAL PRIMARY KEY,
    nombre_sala VARCHAR(100),
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_usuario INT,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id)
);

-- Tabla: ingresos
CREATE TABLE ingresos (
    id SERIAL PRIMARY KEY,
    id_paciente INT,
    codigo_paciente VARCHAR(50),
    id_usuario INT,
    id_consulta INT,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_ingreso DATE,
    id_sala INT,
    numero_cama VARCHAR(20),
    fecha_alta DATE,
    token VARCHAR(100),
    FOREIGN KEY (id_paciente) REFERENCES pacientes(id),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id),
    FOREIGN KEY (id_consulta) REFERENCES consulta(id),
    FOREIGN KEY (id_sala) REFERENCES salas_ingreso(id)
);
