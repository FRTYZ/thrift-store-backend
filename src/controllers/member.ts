import { Request, Response, NextFunction } from 'express';

require('dotenv').config();
const bcrypt = require("bcrypt");

const redis = require('../helpers/redis');
const pool = require('../helpers/postgre');
const Image = require('../helpers/uploadImage');

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

exports.put_member = async function(req: Request, res: Response, next: NextFunction) {
    const getRedisData = await redis.RedisClient.get('currentUser')
    const currentUser = JSON.parse(getRedisData);

    let fullname = req.body.fullname;
    let email = req.body.email;
    let about = req.body.about;
    let phone_number = req.body.phone_number;
    const password = req.body.password;
    const currentPass = req.body.current_pass;
    const photo = req.files;

    try {
        if (!currentUser || currentUser == '') {
            throw new CustomError(403);
        }

        const current_email = currentUser.username 
        const user_id = currentUser.user_id

        const oldDataQuery = `
            SELECT 
                fullname,
                photo,
                email,
                about,
                password,
                phone_number 
            FROM
                users
            WHERE
                email = $1
        `;

        const statusOldData = await pool.query(oldDataQuery, [current_email]);
        const responseOldData = statusOldData.rows[0];

        if (!fullname || fullname == '') {
            fullname = responseOldData.fullname
        }
        if (!email || email == '') {
            email = responseOldData.email
        }
        if (!phone_number) {
            phone_number = responseOldData.phone_number
        }

        let hashedPass;
        if(currentPass && currentPass !== ''){
            const passCheck = await bcrypt.compare(currentPass, responseOldData.password);

            if(passCheck){
                hashedPass = await bcrypt.hashSync(password, 10);
            }else{
                throw new CustomError(404, "Check your current password.", 'invalid_grant');
            }
        }
     
        let selectedPhoto;

        if(photo && photo.length != 0){
            await Image.removeOldImage(responseOldData?.photo ? responseOldData?.photo?.path : '')
            const uploadImage = await Image.uploadMultipleImages(photo, 'members/' + email  + '/avatar/', fullname);
            selectedPhoto = JSON.stringify(uploadImage[0]);
        }else{
            selectedPhoto = responseOldData.photo
        }
        
        const updateQuery = `
            UPDATE
                users
            SET
                fullname = $1,
                email = $2,
                about = $3,
                phone_number = $4,
                password = $5,
                photo = $6
            WHERE
                id = $7
        `;

        const updateValues = [
            fullname,
            email,
            about,
            phone_number,
            hashedPass == undefined ? responseOldData.password : hashedPass,
            selectedPhoto,
            user_id
        ];

        await pool.query(updateQuery, updateValues);

        return res.status(200).json({'success': 'true', photo: selectedPhoto });

    }catch (err){
        next(err)
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
