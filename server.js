const bodyParser = require('body-parser');

const express = require('express');
const app = express();

const apiFunction = require('./api.js');
const api = apiFunction();

app.use(bodyParser.json())
app.get("/hotels", api.getAllHotels);
app.get("/hotels/:hotelId", api.getHotelsById);
app.get("/customers/:customerId/bookings", api.getEspecificBookingById);
app.get("/customers", api.getAllCustomers);
app.get("/customers/:customerId", api.getCustomerById);
app.post("/hotels", api.addNewHotelRow);
app.post("/customers", api.addNewCustomerRow);
app.patch("/customers/:customerId", api.updateCustomer);
app.delete("/customers/:customerId", api.deleteCustomer);
app.delete("/hotels/:hotelId", api.deleteHotel);

const port = 4000;
app.listen(port, () => console.log(`app listenign on port: ${port}`));