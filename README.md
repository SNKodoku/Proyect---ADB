PokeNetwork DB — API Backend (Node + PostgreSQL)

PokeNetwork DB es una API backend desarrollada con Node.js, TypeScript, Express y Drizzle ORM sobre una base de datos PostgreSQL administrada mediante Docker.
El objetivo del proyecto es exponer información estructurada relacionada con especies de Pokémon y sus atributos básicos, manteniendo una arquitectura modular y escalable para futuras ampliaciones

Características principales

API REST construida con Express

Tipado estático mediante TypeScript

ORM basado en consultas SQL tipadas con Drizzle

Base de datos PostgreSQL ejecutada mediante Docker

Configuración de entorno con dotenv

Estructura lista para escalar a nuevos módulos

Tecnologías utilizadas
Tecnología	Uso
Node.js	Runtime del servidor
TypeScript	Tipado y desarrollo seguro
Express	Framework HTTP para endpoints REST
Drizzle ORM	ORM ligero, basado en SQL tipado
PostgreSQL	Sistema gestor de base de datos
Docker	Infraestructura de contenedores
pgAdmin	Administración visual de base de datos

Arquitectura del proyecto
pokenetwork-db/
├─ prisma/                  # Configuración de ORM Prisma (solo generate)
├─ src/
│  ├─ db.ts                 # Configuración de conexión a la BD (Drizzle)
│  ├─ schema.ts             # Modelo de tablas
│  ├─ server.ts             # Servidor Express y endpoints
├─ docker-compose.yml       # Orquestación de PostgreSQL y pgAdmin
├─ .env                     # Variables de entorno
└─ README.md                # Documentación

Configuración del entorno
Variables de entorno (.env)

Crear un archivo .env en la raíz del proyecto con el siguiente contenido:

DATABASE_URL="postgresql://admin:admin@localhost:5432/pokemon"


Este archivo contiene la cadena de conexión utilizada por Drizzle para acceder a la base de datos.

Base de datos

La base de datos está configurada con el esquema pokemon_app e incluye las siguientes tablas:

Tabla	Descripción
pokemon_species	Especies de Pokémon y estadísticas básicas
trainer	Entrenadores Pokémon
trainer_pokemon	Relación entre entrenadores y Pokémon
trade	Información de intercambios
trade_item	Items usados en intercambios
friendship	Niveles de amistad entre Pokémon

Ejemplo de estructura de pokemon_species
Columna	Tipo
species_id	integer
name	varchar
type1	varchar
type2	varchar
base_hp	integer
base_attack	integer
base_defense	integer
base_speed	integer

Instalación y ejecución
Requisitos previos

Docker y Docker Compose

Node.js v18+ o v20+

npm

1. Clonar el repositorio
git clone https://github.com/usuario/pokenetwork-db.git
cd pokenetwork-db

2. Instalar dependencias
npm install

3. Levantar la base de datos con Docker
docker compose up -d


Esto iniciará:

PostgreSQL → localhost:5432

pgAdmin → localhost:8080

4. Ejecutar el servidor
npm run dev


El servidor estará disponible en:

http://localhost:3000

Endpoints de la API
Obtener todas las especies
GET /pokemon


Respuesta ejemplo:

[
  {
    "speciesId": 1,
    "name": "Bulbasaur",
    "type1": "Grass",
    "type2": "Poison",
    "baseHp": 45,
    "baseAttack": 49,
    "baseDefense": 49,
    "baseSpeed": 45
  }
]

Obtener una especie por ID
GET /pokemon/:id

Estructura para expansión

La aplicación está diseñada para crecer fácilmente mediante:

Nuevos modelos en schema.ts

Nuevos endpoints en server.ts

Nuevas relaciones entre tablas

Servicios externos (GraphQL, caché, etc.)

Posibles módulos adicionales:

Registro y autenticación de usuarios

Sistema de intercambios

Estadísticas avanzadas

Integración con Frontend React/Vue

Desarrollo y buenas prácticas

Uso de tipado estricto con TypeScript

Variables de entorno aisladas

Arquitectura modular

Uso de Docker para estandarizar entornos

ORM basado en SQL con soporte para migraciones

Diagrama ER

erDiagram

    TRAINER {
        int trainer_id PK
        varchar username
        varchar email
        varchar password_hash
        varchar region
        timestamp created_at
    }

    POKEMON_SPECIES {
        int species_id PK
        varchar name
        varchar type1
        varchar type2
        int base_hp
        int base_attack
        int base_defense
        int base_speed
    }

    TRAINER_POKEMON {
        int trainer_pokemon_id PK
        int trainer_id FK
        int species_id FK
        int level
        int friendship_id FK
        timestamp acquired_at
    }

    FRIENDSHIP {
        int friendship_id PK
        int value
        varchar status
    }

    TRADE {
        int trade_id PK
        int sender_trainer_id FK
        int receiver_trainer_id FK
        timestamp trade_date
    }

    TRADE_ITEM {
        int trade_item_id PK
        int trade_id FK
        int species_id FK
        int quantity
    }

    TRAINER_POKEMON }o--|| TRAINER : "Belongs to"
    TRAINER_POKEMON }o--|| POKEMON_SPECIES : "Is species"
    TRAINER_POKEMON }o--|| FRIENDSHIP : "Friendship level"

    TRADE_ITEM }o--|| TRADE : "Part of trade"
    TRADE_ITEM }o--|| POKEMON_SPECIES : "Species traded"
    
    TRADE }o--|| TRAINER : "Sender"
    TRADE }o--|| TRAINER : "Receiver"

Diagrama de arquitectura

flowchart TD

Client[Cliente / Frontend] -->|HTTP (JSON)| API[Express API]

API --> Controllers[Controllers / Rutas]

Controllers --> Services[Services / Lógica de negocio]

Services --> DBLayer[Drizzle ORM]

DBLayer -->|SQL Queries| PostgreSQL[(PostgreSQL)]

PostgreSQL --> Volume[Docker Volume]

subgraph Infrastructure
DockerCompose[docker-compose.yml]
end

Subgraph pgAdmin
pgAdmin4[pgAdmin 4 UI]
end

pgAdmin4 --> PostgreSQL


Diagrama de Flujo

sequenceDiagram
    participant User
    participant API
    participant Service
    participant DB
    User->>API: GET /pokemon
    API->>Service: fetchAllPokemon()
    Service->>DB: SELECT * FROM pokemon_species
    DB-->>Service: Result Rows
    Service-->>API: Array of Pokémon
    API-->>User: JSON Response 200 OK


Diagrama de Flujo

sequenceDiagram
    participant User
    participant API
    participant Service
    participant DB

    User->>API: GET /pokemon/:id
    API->>Service: fetchPokemonById(id)
    Service->>DB: SELECT * FROM pokemon_species WHERE id = :id
    DB-->>Service: Row
    Service-->>API: Data
    API-->>User: JSON Response 200 OK

Diagrama de infraestructura

graph LR
    A[Host Machine] --> B(Docker Engine)
    B --> C[Container: PostgreSQL]
    B --> D[Container: pgAdmin]
    
    C --> F[Docker Volume Data]
    D --> C

