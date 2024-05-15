import express, { Express, Request, Response } from "express";
import dotenv from "dotenv";

dotenv.config();

const app: Express = express();
const PORT = process.env.PORT || 8080;

// Cors
import cors from 'cors';
const corsOptions = require("./config/corsOptions");

// Redis
const redis = require('./helpers/redis');

// Middlewares
const credentials = require('./middleware/credentials');
const errorHandler = require('./middleware/errorHandler');

app.use(credentials);
app.use(cors(corsOptions));

app.use(express.json());
app.use(express.urlencoded({ extended: false }));

// Routes
const authRoutes = require('./routes/auth');


app.use('/oauth', authRoutes);

app.use(errorHandler);

const startUp = async () => {
    try {
        await redis.RedisClient.connect();
    }
    catch(err){
        console.error(err);
    }

    app.listen(PORT, () => {
        console.log('Server is running at ' + PORT);
    })
    
}
startUp();