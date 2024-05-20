const admin = require('firebase-admin');

admin.initializeApp({
  credential: admin.credential.cert({
    projectId: process.env.FIREBASE_PROJECT_ID,
    clientEmail: process.env.FIREBASE_CLIENT_EMAIL,
    privateKey: process.env.FIREBASE_PRIVATE_KEY as string
  }),
  storageBucket: process.env.FIREBASE_STORAGE
})

const bucket = admin.storage().bucket()

module.exports = {
  bucket
}