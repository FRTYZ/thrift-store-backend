import express, { Request, Response, NextFunction } from 'express';
const CustomError = require('../errors/CustomError');

const pool = require('../helpers/postgre');
const redis = require('../helpers/redis');
const Image = require('../helpers/uploadImage');

exports.getCategories = async function (req: Request, res: Response, next: NextFunction) {
    try {
        const categorySqlQuery = `
            SELECT
                mc.category_id,
                mc.category_name,
                mc.color,
                CASE WHEN COUNT(sc.sub_category_id) > 0 THEN
                    jsonb_agg (
                        jsonb_build_object (
                            'sub_category_id', sc.sub_category_id,
                            'sub_category_name', sc.sub_category_name,
                            'sub_category_icon', sc.icon,
                            'main_category_id', mc.category_id
                        )
                    )
                ELSE
                    jsonb_build_array()
                END as sub_category
            FROM
                main_categories mc
            LEFT JOIN
                sub_categories sc ON sc.main_category_id = mc.category_id
            WHERE
                sc.is_visible = TRUE
            GROUP BY
                mc.category_id
            ORDER BY
                mc.category_id ASC
        `;
        
        const categoryResults = await pool.query(categorySqlQuery);
        const categoryData = categoryResults.rows;

        return res.status(200).json(categoryData);
    }catch (err){
        next(err)
    }
}

exports.getActualAdvert = async function (req: Request, res: Response, next: NextFunction) {
    const getRedisData = await redis.RedisClient.get('currentUser')
    const currentUser = JSON.parse(getRedisData);

    const search_query = req.query.search as string;
    const selected_city = req.query.selected_city;
    const selected_county = req.query.selected_county;
    const min_price = req.query.min_price;
    const max_price = req.query.max_price;
    const main_category = req.query.main_category;
    const sub_category = req.query.sub_category;
    const sorting = req.query.sorting as string
   
    try {

        let sqlNonAuthQuery = `
            SELECT 
                ad.id, 
                ad.title, 
                to_char(ad.created_at,'DD Month') as date, 
                ad.description,
                ad.price,
                ad.main_category_id,
                ad.sub_category_id,
                ads.id as status_id,
                ads.display_name,
                cy.city,
                ct.county,
                ai.url as photo,
                u.fullname,
                u.photo as user_photo,
                mc.category_name as main_category_name,
                sc.sub_category_name
            FROM 
                adverts ad 
            LEFT JOIN 
                users u ON ad.user_id = u.id 
            LEFT JOIN 
                advert_status ads ON ads.id = ad.status_id 
            LEFT JOIN 
                cities cy ON cy.id = ad.city_id 
            LEFT JOIN 
                counties ct ON ct.id = ad.county_id
            LEFT JOIN
                advert_images ai ON ai.advert_id = ad.id
            LEFT JOIN
                main_categories mc ON mc.category_id = ad.main_category_id
			LEFT JOIN
				sub_categories sc ON sc.sub_category_id = ad.sub_category_id
            WHERE 
                ad.is_deleted = FALSE 
                    AND 
                ad.is_visible = TRUE 
                    AND 
                ad.is_sell = FALSE
                    AND
                u.is_deleted = FALSE 
                    AND 
                ads.is_visible = TRUE
                    AND
                ai.is_cover_image = TRUE
        `;
        const data = await pool.query(sqlNonAuthQuery,values);
        let result = data.rows;

        if(result && currentUser?.user_id){
            const favoriteQuery = `
                SELECT 
                    ad.id
                FROM 
                    advert_favorites adf
                LEFT JOIN 
                    users u ON adf.user_id = u.id 
                LEFT JOIN
                    adverts ad ON adf.advert_id = ad.id
                WHERE 
                    ad.is_deleted = FALSE 
                        AND 
                    ad.is_visible = TRUE 
                        AND 
                    ad.is_sell = FALSE
                        AND
                    u.is_deleted = FALSE
                        AND
                    adf.user_id = $1
                `;

            const favoriteResult = await pool.query(favoriteQuery, [currentUser?.user_id])
            const favoriteData = favoriteResult.rows;

            const newData = result.map((item: any) => {
                const hasId = favoriteData.find((idObj: any) => idObj.id == item.id);

                return {
                    ...item,
                    has_favorite: hasId ? true : false
                }
            })
            result = newData
        }

        return res.status(200).json(result);

    } catch(err) {
        next(err); 
    }
}

exports.getAdvertStatus = async function (req: Request, res: Response, next: NextFunction) {
    try {
        const statusSqlQuery = `
            SELECT
                id,
                display_name as value
            FROM
                advert_status
            WHERE
                is_visible = TRUE
        `;

        const statusResponse = await pool.query(statusSqlQuery);
        const statusResult = statusResponse.rows;

        return res.status(200).json(statusResult);

    }catch(err){
        console.log(err)
        next(err)
    }
}

exports.postAdvert = async function (req: Request, res: Response, next: NextFunction) {
    const getRedisData = await redis.RedisClient.get('currentUser');
    const parseUser = JSON.parse(getRedisData);

    const user_id = parseUser.user_id;
    const email =  parseUser.username;

    const {title, description, how_status, price, city_id, county_id, main_category_id, sub_category_id} = req.body;

    const advertImages = req.files; 

    try {
        if (!user_id || user_id == '') {
            throw new CustomError(403, "You must specify the user_id field.");
        }

        if (!title || title == '') {
            throw new CustomError(400, "You must specify the title field.");
        }

        if (!description || description == '') {
            throw new CustomError(400, "You must specify the description field.");
        }

        if (!advertImages) {
            throw new CustomError(400, "You must specify the images field.");
        }

        if (!how_status) {
            throw new CustomError(400, "You must specify the how_status field.");
        }

        if (!price || price == '') {
            throw new CustomError(400, "You must specify the price field.");
        }

        if (!city_id || city_id == '') {
            throw new CustomError(400, "You must specify the city_id field.");
        }

        if (!county_id || county_id == '') {
            throw new CustomError(400, "You must specify the county_id field.");
        }

        const insertQuery = `
            INSERT INTO adverts 
                (title, 
                description, 
                user_id, 
                status_id, 
                price, 
                city_id, 
                county_id,
                main_category_id,
                sub_category_id
                ) 
            VALUES
                ($1, $2, $3, $4, $5, $6, $7, $8, $9) 
            RETURNING *
            `;
        const values = [title, description, user_id, how_status, price, city_id, county_id, main_category_id, sub_category_id];

        const status = await pool.query(insertQuery, values);
        const advert_id = status.rows[0].id;

        const advertImagesResponse = await Image.uploadMultipleImages(advertImages, 'members/' + email  + '/adverts/' + advert_id + '/' , title);

        for(const item of advertImagesResponse){

            const imageInsertQuery = `
                INSERT INTO advert_images
                    (url, path, width, height, advert_id, is_cover_image) 
                VALUES
                    ($1, $2, $3, $4, $5, $6) 
            `;

            const values = [
                item.url, 
                item.path, 
                item.width, 
                item.height, 
                advert_id, 
                advertImagesResponse[0].path == item.path ? true : false 
            ];

            await pool.query(imageInsertQuery, values);
        }
       
        return res.status(201).json({ 'success': 'true' , 'advert_id' : advert_id}) 
    }catch (err){
        next(err)
    }
}
exports.getMyAdvert = async function (req: Request, res: Response, next: NextFunction) {
    const getRedisData = await redis.RedisClient.get('currentUser')
    const currentUser = JSON.parse(getRedisData);

    const userId = currentUser?.user_id;

    try {
        const sqlQuery = `
            SELECT
                ad.id,
                ad.title,
                ad.price,
                ad.is_visible,
                ad.is_sell,
                ad.status_id,
                COUNT(adf.favorite_id) as likes,
                STRING_AGG(CASE WHEN aim.is_cover_image = TRUE THEN aim.url ELSE NULL END, '') AS is_cover_image
            FROM
                adverts ad
            LEFT JOIN
                advert_favorites adf
            ON
                adf.advert_id = ad.id
            LEFT JOIN
				advert_images aim
			ON
				ad.id = aim.advert_id
            WHERE
                ad.user_id = $1
            AND
                is_deleted = FALSE
            GROUP BY
				ad.id
        `;

        const response = await pool.query(sqlQuery, [userId]);

        const result = response.rows;

        res.status(200).json(result);

    }
    catch (err){
        next(err)
    }

}
exports.getMyFavoriteAdvert = async function (req: Request, res: Response, next: NextFunction) {
    const getRedisData = await redis.RedisClient.get('currentUser')
    const currentUser = JSON.parse(getRedisData);

    const userId = currentUser?.user_id;

    try {
        const sqlQuery = `
            SELECT 
                ad.id, 
                ad.title, 
                to_char(ad.created_at,'DD Month') as date, 
                ad.description,
                ad.price,
                ad.how_status,
                u.user_type,
                ads.display_type,
                ads.display_name,
                cy.city,
                ct.county,
                ai.url as photo,
            CASE
                WHEN adf.favorite_id IS NULL THEN false
                ELSE true END
                AS has_favorite
            FROM 
                adverts ad 
            LEFT JOIN 
                users u ON ad.user_id = u.id 
            LEFT JOIN 
                advert_status ads ON ads.id = ad.status_id 
            LEFT JOIN 
                cities cy ON cy.id = ad.city_id 
            LEFT JOIN 
                counties ct ON ct.id = ad.county_id 
            LEFT JOIN
                advert_favorites adf ON adf.advert_id = ad.id
            LEFT JOIN
                advert_images ai ON ai.advert_id = ad.id
            WHERE 
                ad.is_deleted = FALSE 
                    AND 
                ad.is_visible = TRUE 
                    AND 
                u.is_deleted = FALSE 
                    AND 
                ads.is_visible = TRUE
                    AND
                ai.is_cover_image = TRUE
                    AND
                adf.user_id = $1
        `;

        const responseData = await pool.query(sqlQuery, [userId]);
        const getData = responseData.rows;

        if(getData.length == 0){
            throw new CustomError(404); 
        }

        return res.status(200).json(getData);
    }
    catch(err){
        next(err)
    }
}exports.patchSettingAdvert = async function (req: Request, res: Response, next: NextFunction) {
    const advert_id = req.params.advert_id;
    const path = req.body.path;
    const op = req.body.op;
    const value = req.body.value;

    try {
        if(path == "has_advert_visible" && op == 'replace') {
            const visibleQuery = `
                UPDATE
                    adverts
                SET
                    is_visible = $1
                WHERE
                    id = $2
            `;
            await pool.query(visibleQuery, [value, advert_id]);

            return res.status(200).json({'success' : true})
        }
        else if(path == "has_advert_remove" && op == 'remove'){
            const visibleQuery = `
                UPDATE
                    adverts
                SET
                    is_deleted = $1
                WHERE
                    id = $2
            `;
            await pool.query(visibleQuery, [value, advert_id]);

            return res.status(200).json({'success' : true})
        }
        else if(path == "has_advert_sell" && op == 'replace') {
            const visibleQuery = `
                UPDATE
                    adverts
                SET
                    is_sell = $1
                WHERE
                    id = $2
            `;
            await pool.query(visibleQuery, [value, advert_id]);

            return res.status(200).json({'success' : true})
        }
        else if(path == "has_advert_status" && op == 'replace') {
            const visibleQuery = `
                UPDATE
                    adverts
                SET
                    status_id = $1
                WHERE
                    id = $2
            `;
            await pool.query(visibleQuery, [value, advert_id]);

            return res.status(200).json({'success' : true})
        }
        else{
            throw new CustomError(204);
        }
    }
    catch (err)
    {
        next(err)
    }
}

exports.getLocationCity =  async function (req: Request, res: Response, next: NextFunction) {
    try {
        const data = await pool.query(`
            SELECT 
                id,
                city as value
            FROM 
                cities
        `);
        const response = data.rows;

        return res.status(200).json(response);

    }catch(err){
        next(err)
    }
}

exports.getCountyForCity =  async function (req: Request, res: Response, next: NextFunction) {
    const city_id = req.params.city_id;

    try {

        if(city_id == '' || city_id == 'undefined'){
            throw new CustomError(404, "you must specify the city_id field"); 
        }

        const sqlQuery = `
            SELECT 
                id,
                county as value
            FROM 
                counties
            WHERE
                city_id = $1
        `
        const data = await pool.query(sqlQuery, [city_id]);
        const response = data.rows;

        return res.status(200).json(response);

    }catch(err){
        next(err)
    }
}

exports.patchFavoriteAdvert =  async function (req: Request, res: Response, next: NextFunction) {
    const getRedisData = await redis.RedisClient.get('currentUser')
    const currentUser = JSON.parse(getRedisData);

    const advertId = req.params.advert_id;
    const userId = currentUser.user_id;
    const op = req.body.op;
    const path = req.body.path;

    try {
        if(path !== 'has_advert_favorite'){
            throw new CustomError(403); 
        }

        const sqlQuery = `
            SELECT 
                favorite_id
            FROM
                advert_favorites
            WHERE 
                user_id = $1
            AND
                advert_id = $2
        `;

        const responseData = await pool.query(sqlQuery, [userId, advertId]);
        const result = responseData.rows[0];

        if(result && op == 'remove'){
            const favoriteId = result.favorite_id;
             const deleteQuery = `
                DELETE FROM
                    advert_favorites
                WHERE
                    favorite_id = $1
            `;
            await pool.query(deleteQuery, [favoriteId]);

            return res.status(202).json({ 'success': true })
        }
        else if (!result && op == 'add'){
            const insertQuery = `
                INSERT INTO
                    advert_favorites
                    (user_id, advert_id) 
                VALUES
                    ($1, $2)
                RETURNING *
            `;
            await pool.query(insertQuery, [userId, advertId]);

            return res.status(201).json({ 'success': true })
        }
        else{
            throw new CustomError(404, "NOT FOUND");
        }
   
    }
    catch (err){
        next(err);
    }
}

