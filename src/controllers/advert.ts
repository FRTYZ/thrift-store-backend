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
                ad.how_status,
                ad.main_category_id,
                ad.sub_category_id,
                ads.display_type,
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
}