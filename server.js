const express = require('express');
const app = express();

const { Pool } = require('pg');

const connection = new Pool({
    user: 'postgres',
    host: 'localhost',
    database: 'cyf_hotels',
    password: 'Meneer2021',
    port: '5432'
});

const getAllHotels = (req, res) => {
    connection.query('select * from hotels order by id', (error, result) => {
        res.json(result.rows);
    })
}

app.get("/hotels", getAllHotels);

const port = 4000;
app.listen(port, () => console.log(`app listenign on port: ${port}`));