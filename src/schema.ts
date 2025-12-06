import { pgTable, integer, varchar } from "drizzle-orm/pg-core";
import { sql } from "drizzle-orm";

export const pokemonSpecies = pgTable("pokemon_species", {
  speciesId: integer("species_id").primaryKey(),
  name: varchar("name"),
  type1: varchar("type1"),
  type2: varchar("type2"),
  baseHp: integer("base_hp"),
  baseAttack: integer("base_attack"),
  baseDefense: integer("base_defense"),
  baseSpeed: integer("base_speed"),
});
