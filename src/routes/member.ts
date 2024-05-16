import express, { Express, Request, Response } from 'express';
const router = express.Router();

const memberController = require("../controllers/member");
const verifyJWT = require('../middleware/verifyJWT');

router.get("/session", verifyJWT, memberController.get_member);
router.post('/session', multer.body_parse.array(), memberController.post_member);
