import express, { Express, Request, Response } from 'express';
const router = express.Router();

const memberController = require("../controllers/member");
const multer = require('../helpers/multer');
const verifyJWT = require('../middleware/verifyJWT');

router.get("/session", verifyJWT, memberController.get_member);
router.put('/session', verifyJWT, multer.image_upload.array('photo'), memberController.put_member, multer.body_parse.array());
router.post('/session', multer.body_parse.array(), memberController.post_member);
