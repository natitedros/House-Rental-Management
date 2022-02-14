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
router.get('/landlord/addhouse' , authentication.isLandlordLoggedIn,(req , res) => {

    res.render('./LandLord/addHouse.ejs' );

});

router.post('/landlord/addhouse' , authentication.isLandlordLoggedIn,(req , res) => {

    console.log(req.body);
    let sql = "INSERT INTO houses values ('" + req.body.houseNo + "' , '" + req.body.location + "' , '" + req.body.price + "' ,'" + req.body.owner + "', '" + req.body.date + "' , '" + req.body.availibility +"')";
    db.query(sql , (err , result) => {
        if(err){
            console.log("error quering sql");
        }
        let my_sql = "INSERT INTO HousingInfo (sqArea, NoOfBedrooms, Legality, HouseNumber) values ('" + req.body.sqarea + "','" + req.body.noofbedrooms + "','" + req.body.legality + "','" + req.body.houseNo + "') "
        db.query (my_sql , (err , result) => {
            if (err) throw err ; 
            else {
                console.log(req.result);
            }
        })
       res.redirect('/landlord/home' );
   });
   

});

router.get('/landlord/requestapproval' , authentication.isLandlordLoggedIn,(req , res) => {
    const sql = `SELECT RentalRequest.Tenant, RentalRequest.HouseNumberId
    FROM RentalRequest left join Houses
   ON RentalRequest.HouseNumberId = houses.HouseNo
   where Houses.Owner = 1`;
    db.query(sql , (err , result) => {
        
        if (err) {
            console.log("error quering sql");
        }
        console.log(result);
        res.render('./LandLord/requestApproval.ejs' , {data : result} );
    })
});

//
module.exports = router;