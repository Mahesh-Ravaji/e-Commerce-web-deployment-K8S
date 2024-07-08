const express = require('express');
const path = require('path');
const app = express();
const port = 8000;

// Serve static files
app.use('/anime_assetts', express.static(path.join(__dirname, 'anime_assetts')));

// Routes
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'index.html'));
});

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
