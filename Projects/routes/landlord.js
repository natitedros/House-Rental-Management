const { Router } = require('express');
const db = require('../middleware/db_connection');
const authentication = require('../middleware/authentication.js');

const router = Router();

//Landlord Home Page
router.get('/landlord/home' , authentication.isLandlordLoggedIn,(req , res) => {
    const sql = "select * from landlord right join houses on landlord.idLandlord = houses.HouseNo where houses.Owner = 1";
    db.query(sql,[req.params.id] , (err , result) => {
        
        if (err) {
            console.log("error quering sql");
        }
        console.log(result);
        res.render('./LandLord/landlordHome.ejs' , {data : result} );
    })
});

//Add House
router.get('/addhouse' , authentication.isLandlordLoggedIn,(req , res) => {

    res.render('./LandLord/addHouse.ejs' );

});

router.post('/landlord/addhouse' , authentication.isLandlordLoggedIn,(req , res) => {

    console.log(req.body);
    let sql = "INSERT INTO houses values ('" + req.body.houseNo + "' , '" + req.body.location + "' , '" + req.body.price + "' , '" + req.body.date + "' , '" + req.body.availibility + "' , '" + req.body.owner + "')";
    db.query(sql , (err , result) => {
        if(err){
            console.log("error quering sql");
        }
       res.redirect('/landlord/home' );
   });
   

});

//
module.exports = router;