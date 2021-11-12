const { Pool } = require('pg');
const secrest = require('./secrest.json');
const connection = new Pool(secrest);


const api = () => {
    const getAllHotels = async (req, res) => {
        try {
            const dbRequirement = await connection.query('select * from hotels order by id');
            await res.json(dbRequirement.rows);
        } catch (err) {
            console.error(err);
        }
    }

    const getHotelsById = async (req, res) => {
        const hotelId = req.params.hotelId;
        const query = 'select * from hotels where id=$1';

        // if (!Number.isInteger(hotelId)) {
        //     res.status(400).json({message: 'The given id is invalid!!'})
        // }

        const getHotel = await connection.query(query, [hotelId]);
        await res.json(getHotel.rows);
    }

    const getEspecificBookingById = async (req, res) => {
        // getting the param 
        const customerId = req.params.customerId;
    
        // checking if the id is a valid number
        // if (!Number.isInteger(customerId)) {
        //     return res.status(400).send('The given ID is not valid!')
        // }
    
        // making the connection with the data base and passing the param 
        const getBooking = await connection.query(`select c.name as customer_name, b.checkin_date, 
        h.name as hotel_name,
        b.nights as number_of_nights,
        h.postcode as hotel_postcode
        from customers c
        inner join bookings b on b.customer_id=c.id
        inner join hotels h on h.id=b.hotel_id
        where c.id=$1`, [customerId])
    
        // responding with the information that i got from the connection
        await res.json(getBooking.rows);
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

    return {
        getAllHotels,
        getHotelsById,
        getEspecificBookingById,
        addNewHotelRow,
        addNewCustomerRow
    }
}

module.exports = api;



