-- Insert sample trainers
INSERT INTO pokemon_app.trainer (username, email, password_hash, region)
VALUES 
  ('ashketchum', 'ash@poke.com', 'fakehash', 'Kanto'),
  ('misty', 'misty@poke.com', 'fakehash', 'Kanto'),
  ('brock', 'brock@poke.com', 'fakehash', 'Kanto'),
  ('gary', 'gary@poke.com', 'fakehash', 'Kanto');

-- Insert pokemon species
INSERT INTO pokemon_app.pokemon_species (name, type1, type2, base_hp, base_attack, base_defense, base_speed)
VALUES
  ('Bulbasaur', 'Grass', 'Poison', 45, 49, 49, 45),
  ('Charmander', 'Fire', NULL, 39, 52, 43, 65),
  ('Squirtle', 'Water', NULL, 44, 48, 65, 43),
  ('Pikachu', 'Electric', NULL, 35, 55, 40, 90),
  ('Eevee', 'Normal', NULL, 55, 55, 50, 55),
  ('Pidgey', 'Normal', 'Flying', 40, 45, 40, 56),
  ('Jigglypuff', 'Normal', 'Fairy', 115, 45, 20, 20),
  ('Zubat', 'Poison', 'Flying', 40, 45, 35, 55),
  ('Geodude', 'Rock', 'Ground', 40, 80, 100, 20),
  ('Onix', 'Rock', 'Ground', 35, 45, 160, 70);

-- Assign pokemon to trainers
INSERT INTO pokemon_app.trainer_pokemon (trainer_id, species_id, nickname, level, is_shiny)
VALUES
  (1, 1, 'Buddy', 10, FALSE),
  (1, 4, 'Sparky', 7, FALSE),
  (2, 3, 'Shell', 8, TRUE),
  (3, 9, 'Rocky', 12, FALSE),
  (4, 2, 'Flame', 15, FALSE);

-- Example trades
INSERT INTO pokemon_app.trade (sender_id, receiver_id, status)
VALUES
  (1, 2, 'pending'),
  (2, 1, 'accepted');
