CREATE SCHEMA IF NOT EXISTS pokemon_app;

CREATE TABLE pokemon_app.trainer (
  trainer_id SERIAL PRIMARY KEY,
  username VARCHAR(50) UNIQUE NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  password_hash VARCHAR(200) NOT NULL,
  region VARCHAR(50),
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE pokemon_app.pokemon_species (
  species_id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  type1 VARCHAR(50) NOT NULL,
  type2 VARCHAR(50),
  base_hp INT,
  base_attack INT,
  base_defense INT,
  base_speed INT
);

CREATE TABLE pokemon_app.trainer_pokemon (
  id SERIAL PRIMARY KEY,
  trainer_id INT REFERENCES pokemon_app.trainer(trainer_id),
  species_id INT REFERENCES pokemon_app.pokemon_species(species_id),
  nickname VARCHAR(100),
  level INT DEFAULT 1,
  is_shiny BOOLEAN DEFAULT FALSE,
  obtained_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE pokemon_app.trade (
  trade_id SERIAL PRIMARY KEY,
  sender_id INT REFERENCES pokemon_app.trainer(trainer_id),
  receiver_id INT REFERENCES pokemon_app.trainer(trainer_id),
  status VARCHAR(20) DEFAULT 'pending',
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE pokemon_app.trade_item (
  id SERIAL PRIMARY KEY,
  trade_id INT REFERENCES pokemon_app.trade(trade_id),
  trainer_pokemon_id INT REFERENCES pokemon_app.trainer_pokemon(id)
);

CREATE TABLE pokemon_app.friendship (
  id SERIAL PRIMARY KEY,
  requester_id INT REFERENCES pokemon_app.trainer(trainer_id),
  receiver_id INT REFERENCES pokemon_app.trainer(trainer_id),
  status VARCHAR(20) DEFAULT 'pending',
  created_at TIMESTAMP DEFAULT NOW()
);
