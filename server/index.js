const express = require('express');
const app = express();
const port = 3000;

app.use(express.json());

class Player {
    constructor() {
        this.maxHealth = 100;
        this.currentHealth = 100.0;
        this.maxMana = 10;
        this.currentMana = 10;
        this.muscle = 50;
        this.gravity = 250;
        this.jumpVelocity = -250;
        this.maxVelocityX = 250;
        this.accelerationX = 100;
        this.itemBase = [];
        this.itemUlt = "";
    }
}

// Create two instances of Player
let player1 = new Player();
let player2 = new Player();

// Endpoint to get the state of both players
app.get('/players', (req, res) => {
    res.json({ player1, player2 });
});

// Endpoint to set the state of player1
app.post('/player1', (req, res) => {
    const newState = req.body;
    console.log(newState)
    player1 = { ...player1, ...newState };
    res.json(player1);
});

// Endpoint to set the state of player2
app.post('/player2', (req, res) => {
    const newState = req.body;
    player2 = { ...player2, ...newState };
    res.json(player2);
});

// Endpoint to reset both players to their default states
app.post('/reset', (req, res) => {
    player1 = new Player();
    player2 = new Player();
    res.json({ player1, player2 });
});

app.listen(port, () => {
    console.log(`Server running at http://localhost:${port}`);
});
