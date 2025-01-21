//server.js
const express = require("express");
const mongoose = require("mongoose");
const dotenv = require("dotenv");
const userRoute = require("./routes/user");
const authRoute = require("./routes/Auth");
const productRoute = require("./routes/product");
const orderRoute = require("./routes/order");
const cartRoute = require("./routes/cart");
const cors = require("cors");
const http = require("http");
dotenv.config();

dotenv.config();
const app = express();

mongoose.connect(process.env.MONGODB_URI)
.then(console.log("Mongodb Connected"))
.catch((err)=> console.log(err))

const server = http.createServer(app); // Create an HTTP server

app.use(cors());
app.use(express.json());
app.use('/api/auth', authRoute);
app.use('/api/users' , userRoute);
app.use('/api/products' , productRoute);
app.use('/api/orders' , orderRoute);
app.use('/api/cart' , cartRoute);


server.listen(5001,function(){
    console.log("Server is listening on port 5001");
});