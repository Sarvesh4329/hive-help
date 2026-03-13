const PORT = process.env.PORT || 5000;
const MONGODB_URI = process.env.MONGODB_URI || 'mongodb://localhost:27017/bee_nest';
const JWT_SECRET = process.env.JWT_SECRET || 'secretkey';

if (process.env.NODE_ENV === 'production' && !process.env.JWT_SECRET) {
  throw new Error('JWT_SECRET must be set in production.');
}

module.exports = { MONGODB_URI, JWT_SECRET, PORT };
