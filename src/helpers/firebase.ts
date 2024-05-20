const admin = require('firebase-admin');
const privateKey: any = process.env.FIREBASE_PRIVATE_KEY

admin.initializeApp({
  credential: admin.credential.cert({
    projectId: process.env.FIREBASE_PROJECT_ID,
    clientEmail: process.env.FIREBASE_CLIENT_EMAIL,
    privateKey: privateKey.replace(/\\n/g, '\n')
  }),
  storageBucket: process.env.FIREBASE_STORAGE
})

const bucket = admin.storage().bucket()

module.exports = {
  bucket
}