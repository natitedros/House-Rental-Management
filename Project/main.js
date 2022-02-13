const cookieParser = require('cookie-parser'); 
const express = require('express');

const app = express();

app.set('view engine' ,  'ejs');
app.use(express.json());
app.use(express.urlencoded({extended: false}));
app.use(cookieParser());
app.use(express.static('public'));

const port = 3000; //Port used

//Routes to be imported
const authRoutes = require('./routes/authRoutes');

const landlord = require('./routes/landlord');
const tenant = require('./routes/tenant');

//Routes
app.use(authRoutes);

app.use(landlord);
app.use(tenant);


app.listen(port , ()=>console.log("Server running on port ", port));
