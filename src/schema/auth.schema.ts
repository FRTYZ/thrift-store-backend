/**
 * @openapi
 * components:
 *   schema:
 *     Auth:
 *       type: object
 *       required:
 *        - client_id
 *        - client_secret
 *        - grant_type
 *        - username
 *        - password
 *       properties:
 *         client_id:
 *           type: string
 *           default: ''
 *         client_secret:
 *           type: string
 *           default: ''
 *         grant_type:
 *           type: string
 *           default: 'password'
 *         username:
 *           type: string
 *           default: 'mail@example.com'
 *         password:
 *           type: string
 *           default: ''
 *     authResponse:
 *       type: object
 *       properties:
 *         access_token:
 *           type: string
 *         expires_in:
 *           type: number
 *         refresh_token:
 *           type: string
 *         token_type:
 *           type: string
 *
 */