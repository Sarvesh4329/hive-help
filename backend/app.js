const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');

const app = express();
const PORT = process.env.PORT || 5000;
const MONGODB_URI = process.env.MONGODB_URI || 'mongodb://localhost:27017/bee_nest';
app.use(express.json());
app.use(cors());

// Serve static files from the 'uploads' directory
app.use('/uploads', express.static('uploads'));

app.get('/health', (req, res) => {
  res.status(200).json({ status: 'ok' });
});

// Import routes
const authRoutes = require('./routes/auth');
const appointmentRoutes = require('./routes/appointments');
const productRoutes = require('./routes/products'); // Ensure this line exists
const adminRoutes = require('./routes/admin');
const orderRoutes = require('./routes/orders');
const usersRoutes = require('./routes/users');

app.use('/api/auth', authRoutes);
app.use('/api/appointments', appointmentRoutes);
app.use('/api/products', productRoutes);
app.use('/api/admin', adminRoutes);
app.use('/api/orders', orderRoutes);
app.use('/api/users', usersRoutes);

// Connect to MongoDB
mongoose.connect(MONGODB_URI)
  .then(() => app.listen(PORT, () => console.log(`Server running on port ${PORT}`)))
  .catch(err => {
    console.error(err);
    process.exit(1);
  });
