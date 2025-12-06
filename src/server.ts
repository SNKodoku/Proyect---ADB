import express from "express";
import cors from "cors";
import { db } from "./db";
import { pokemonSpecies } from "./schema";
import { eq } from "drizzle-orm";

const app = express();
app.use(cors());
app.use(express.json());

// Lista todos los Pokémon
app.get("/pokemon", async (req, res) => {
  const result = await db.select().from(pokemonSpecies);
  res.json(result);
});

// Pokémon por ID
app.get("/pokemon/:id", async (req, res) => {
  const id = Number(req.params.id);

  const result = await db
    .select()
    .from(pokemonSpecies)
    .where(eq(pokemonSpecies.speciesId, id));

  res.json(result);
});

app.listen(3000, () => {
  console.log("Servidor escuchando en http://localhost:3000");
});
