import { Request, Response, NextFunction } from 'express';

require('dotenv').config();
const bcrypt = require("bcrypt");

const redis = require('../helpers/redis');
const pool = require('../helpers/postgre');
const CustomError = require('../errors/CustomError');

exports.get_member = async function (req: Request, res: Response, next: NextFunction) {
    const getRedisData = await redis.RedisClient.get('currentUser')
    const currentUser = JSON.parse(getRedisData);

    try {
        if (!currentUser) {
            throw new CustomError(403, "Client authentication failed", 'invalid_client');
        }
        const email = currentUser.username;

        if (!email || email == '') {
            throw new CustomError(403, "Client authentication failed", 'invalid_client');
        }

        const sqlQuery = `
            SELECT 
                u.id,
                u.fullname,
                u.about,
                u.phone_number,
                u.photo, 
                u.email
            FROM 
                users u 
            WHERE 
                u.is_deleted = FALSE 
            AND 
                u.email = $1
            `;

        const data = await pool.query(sqlQuery, [email]); 
        const user = data.rows[0];

        if (!user) {
            throw new CustomError(401, "The user not found", 'access_denied');
        }

        res.status(200).json(user);

    } catch (error) {
        next(error);
    }
}
exports.post_member =  async function(req: Request, res: Response, next: NextFunction) {
    const {email, password, fullname} = req.body;

    try {
        if (!email || email == '') {
            throw new CustomError(400, "you must fill in the email field", "value_error");
        }
        const oldDataQuery = `
            SELECT 
                email
            FROM
                users
            WHERE
                email = $1
        `;

        const statusOldData = await pool.query(oldDataQuery, [email]);
        const responseOldData = statusOldData.rows[0];
        
        if(responseOldData?.email){
            throw new CustomError(409, "Email address is used", 'duplicate_email');
        }

        if (!password || password == '') {
            throw new CustomError(400, "you must fill in the password field", "value_error");
        }

        const passwordHash = await bcrypt.hashSync(password, 10);

        const insertUserQuery = `
            INSERT INTO
                users
            (fullname, email, password, user_type)
                VALUES
            ($1, $2, $3, 'CONSUMER')
        `;
       
        await pool.query(insertUserQuery, [fullname, email, passwordHash])

        return res.status(200).json({'success': 'true'});
    }catch (err){
        next(err);
    }
}
