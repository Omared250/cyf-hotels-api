const bodyParser = require('body-parser');

const express = require('express');
const app = express();

const apiFunction = require('./api.js');
const api = apiFunction();

app.use(bodyParser.json())
app.get("/hotels", api.getAllHotels);
app.get("/customers/:customerId/bookings", api.getEspecificBookingById);
app.post("/hotels", api.addNewHotelRow);
app.post("/customers", api.addNewCustomerRow);

const port = 4000;
app.listen(port, () => console.log(`app listenign on port: ${port}`));