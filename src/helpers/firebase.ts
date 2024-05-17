const admin = require('firebase-admin');
const serviceAccount = require('../config/firebase-adminsdk.json');

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
    storageBucket:  process.env.FIREBASE_STORAGE
})

const bucket = admin.storage().bucket()

module.exports = {
  bucket
}