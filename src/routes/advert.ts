import express, { Express, Request, Response } from 'express';
const router = express.Router();

const advertController = require("../controllers/advert");
const multer = require('../helpers/multer');
const verifyJWT = require('../middleware/verifyJWT');

router.get('/categories', advertController.getCategories);

router.get("/actual", advertController.getActualAdvert);
