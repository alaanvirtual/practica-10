#!/bin/bash
# ─── Script de inicializacion SQL para PostgreSQL ─────────────────────────────
PROJECT_DIR="$HOME/practica_docker"

cat << 'SQL' > $PROJECT_DIR/postgres/init/init.sql
-- Crear base de datos de usuarios
CREATE DATABASE usuarios_db;

\c usuarios_db;

CREATE TABLE IF NOT EXISTS usuarios (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(150) UNIQUE NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO usuarios (nombre, correo) VALUES
    ('Ana Garcia', 'ana.garcia@ejemplo.com'),
    ('Carlos Lopez', 'carlos.lopez@ejemplo.com'),
    ('Maria Rodriguez', 'maria.rodriguez@ejemplo.com');

SELECT * FROM usuarios;
SQL

echo "Script SQL de inicializacion creado en $PROJECT_DIR/postgres/init/init.sql"
