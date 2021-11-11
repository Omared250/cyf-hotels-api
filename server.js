const express = require('express');
const bodyParser = require('body-parser');
const app = express();

const { Pool } = require('pg');

const connection = new Pool({
    user: 'postgres',
    host: 'localhost',
    database: 'cyf_hotels',
    password: 'Meneer2021',
    port: '5432'
});

const getAllHotels = async (req, res) => {
    try {
        const dbRequirement = await connection.query('select * from hotels order by id');
        await res.json(dbRequirement.rows);
    } catch (err) {
        console.error(err);
    }
    // connection.query('select * from hotels order by id', (error, result) => {
    //     res.json(result.rows);
    // })
}

const addNewHotelRow = async (req, res) => {
    try {
        // require all the elements into the body
        const newHotelName = req.body.name;
        const newHotelRooms = req.body.rooms;
        const newHotelPostCode = req.body.postcode;

        // creating a variable where save all the information that i going to use 
        const query = 'insert into hotels (name, rooms, postcode) values ($1, $2, $3) returning id'

        // checking if the number of rooms are valid
        if (!Number.isInteger(newHotelRooms) || newHotelRooms <= 0) {
            return res
            .status(400)
            .send('The number of rooms should be a positive integer.')
        }

        // waiting the connection where i can check if the hotel already exist
        const itExists = await connection.query('select * from hotels where name=$1', [newHotelName]);

        // answer if the hotel exists if not creating a new hotel
        if (itExists.rows.length > 0) {
            return res
            .status(400)
            .send('An hotel with the same name already exists!');
        } else {
            // waiting to the connection to create a new hotel
            const newHotelRow = await connection.query(query, [newHotelName, newHotelRooms, newHotelPostCode])
            await res
            .status(201)
            // getting the id of the hotel that was posted
            .json({hotelId : newHotelRow.rows[0].id});   
        }
    } catch (err) {
        // catching errors
        console.error(err);
    }
}

const addNewCustomerRow = async (req, res) => {
    try {
        // require all the elements into the body
        const newCustomer = req.body;

        // creating a variable where save all the information that i going to use 
        const query = `insert into customers (name, email, address, city, postcode, country)
        values ($1, $2, $3, $4, $5, $6) returning id`;

        // waiting the connection where i can check if the customer already exist
        const itExists = await connection.query('select * from customers where name=$1', [newCustomer.name]);

        // answer if the customer exists if not creating a new hotel
        if (itExists.rows.length > 0) {
            return res
            .status(400)
            .send('An customer with the same name already exists!');
        } else {
            // waiting to the connection to create a new hotel
            const newCustomerRow = await connection.query(query,
            [
                newCustomer.name,
                newCustomer.email,
                newCustomer.address,
                newCustomer.city,
                newCustomer.postcode,
                newCustomer.country
            ])
            await res
            .status(201)
            // getting the id of the hotel that was posted
            .json({customerId : newCustomerRow.rows[0].id});   
        }
    } catch (err) {
        // catching errors
        console.error(err);
    }
}

app.use(bodyParser.json())
app.get("/hotels", getAllHotels);
app.post("/hotels", addNewHotelRow);
app.post("/customers", addNewCustomerRow);

const port = 4000;
app.listen(port, () => console.log(`app listenign on port: ${port}`));