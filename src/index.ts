import express, { Express, Request, Response } from "express";
import dotenv from "dotenv";

dotenv.config();

const app: Express = express();
const PORT = process.env.PORT || 8080;

// Cors
import cors from 'cors';
const corsOptions = require("./config/corsOptions");

// Middlewares
const credentials = require('./middleware/credentials');

app.use(credentials);
app.use(cors(corsOptions));

app.use(express.json());
app.use(express.urlencoded({ extended: false }));

app.listen(PORT, () => {
  console.log(`[server]: Server is running at ${PORT}`);
});
