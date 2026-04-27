#!/bin/bash
# ─── Crear contenido web personalizado ────────────────────────────────────────
PROJECT_DIR="$HOME/practica_docker"

cat << 'HTML' > $PROJECT_DIR/nginx/html/index.html
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Practica Docker — Infraestructura</title>
  <link rel="stylesheet" href="/css/style.css">
</head>
<body>
  <header>
    <div class="logo">
      <img src="/img/logo.svg" alt="Logo" width="48" height="48">
      <span>InfraDocker</span>
    </div>
    <nav>
      <a href="/">Inicio</a>
      <a href="/uploads/">Archivos FTP</a>
    </nav>
  </header>
  <main>
    <section class="hero">
      <h1>Infraestructura en Contenedores</h1>
      <p>Servidor web Nginx · PostgreSQL · FTP · Red personalizada</p>
    </section>
    <section class="cards">
      <div class="card">
        <div class="card-icon green">N</div>
        <h3>Nginx</h3>
        <p>Imagen Alpine personalizada. Usuario no-root. Server tokens desactivados.</p>
        <span class="badge running">activo</span>
      </div>
      <div class="card">
        <div class="card-icon blue">PG</div>
        <h3>PostgreSQL</h3>
        <p>Motor de base de datos con volumen persistente y respaldos automaticos.</p>
        <span class="badge running">activo</span>
      </div>
      <div class="card">
        <div class="card-icon orange">FTP</div>
        <h3>FTP Server</h3>
        <p>vsftpd para transferencia de archivos integrado con volumen compartido.</p>
        <span class="badge running">activo</span>
      </div>
      <div class="card">
        <div class="card-icon purple">NET</div>
        <h3>infra_red</h3>
        <p>Red bridge personalizada 172.20.0.0/16. Comunicacion por nombre de contenedor.</p>
        <span class="badge running">activo</span>
      </div>
    </section>
  </main>
  <footer>
    <p>Practica 10 — Ubuntu Server 24.04 · Docker</p>
  </footer>
</body>
</html>
HTML

cat << 'CSS' > $PROJECT_DIR/nginx/html/css/style.css
*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
body { font-family: 'Segoe UI', system-ui, sans-serif; background: #f4f6f8; color: #1a1a2e; }
header { display: flex; justify-content: space-between; align-items: center; padding: 1rem 2rem; background: #1a1a2e; color: #fff; }
.logo { display: flex; align-items: center; gap: 10px; font-size: 1.2rem; font-weight: 600; }
nav a { color: #aac4ff; text-decoration: none; margin-left: 1.5rem; font-size: 14px; }
nav a:hover { color: #fff; }
.hero { text-align: center; padding: 3rem 2rem; background: #1a1a2e; color: #fff; }
.hero h1 { font-size: 2rem; margin-bottom: 0.5rem; }
.hero p { color: #aac4ff; font-size: 1rem; }
.cards { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1.25rem; padding: 2rem; max-width: 900px; margin: 0 auto; }
.card { background: #fff; border-radius: 12px; padding: 1.5rem; border: 1px solid #e2e8f0; text-align: center; }
.card h3 { margin: 0.75rem 0 0.5rem; font-size: 1rem; }
.card p { font-size: 13px; color: #555; line-height: 1.5; }
.card-icon { width: 52px; height: 52px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: 700; font-size: 13px; margin: 0 auto; }
.green  { background: #d1fae5; color: #065f46; }
.blue   { background: #dbeafe; color: #1e40af; }
.orange { background: #ffedd5; color: #9a3412; }
.purple { background: #ede9fe; color: #5b21b6; }
.badge { display: inline-block; margin-top: 0.75rem; padding: 3px 10px; border-radius: 20px; font-size: 12px; }
.running { background: #d1fae5; color: #065f46; }
footer { text-align: center; padding: 1.5rem; font-size: 13px; color: #888; }
CSS

cat << 'SVG' > $PROJECT_DIR/nginx/html/img/logo.svg
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 48 48" fill="none">
  <rect width="48" height="48" rx="10" fill="#1a1a2e"/>
  <rect x="8" y="14" width="10" height="10" rx="2" fill="#aac4ff"/>
  <rect x="22" y="14" width="10" height="10" rx="2" fill="#7ec8e3"/>
  <rect x="36" y="14" width="4" height="10" rx="2" fill="#f59e0b"/>
  <rect x="8" y="28" width="32" height="6" rx="3" fill="#aac4ff" opacity="0.4"/>
</svg>
SVG

echo "Contenido web generado: index.html, css/style.css, img/logo.svg"
