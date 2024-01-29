const express = require('express');
const app = express();
const port = 3000;
const cors = require('cors');

app.use(express.json());
app.use(cors());

let favorites = []; // This will store favorite words in-memory

// Endpoint to get the list of favorite words
const logFavorites = () => {
    console.log("Current Favorites:", favorites);
  };
  
  app.get('/favorites', (req, res) => {
    res.json({ favorites });
  });
  
  
  app.post('/favorites', (req, res) => {
    const word = req.body.word;
    if (!favorites.includes(word)) {
      favorites.push(word);
    }
    logFavorites(); // Log after adding a favorite
    res.status(201).json({ favorites });
  });
  
  app.delete('/favorites', (req, res) => {
    const word = req.body.word;
    favorites = favorites.filter(fav => fav !== word);
    logFavorites(); // Log after removing a favorite
    res.json({ favorites });
  });

app.listen(port, () => {
  console.log(`Server listening at http://localhost:${port}`);
});
