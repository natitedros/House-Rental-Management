const { Router } = require('express');
const db = require('../middleware/db_connection');
const authentication = require('../middleware/authentication.js');

const router = Router();

//Home Page for Tenant
router.get("/tenant/home",  authentication.isTenantLoggedIn, (req, res) => {
    res.render("Tenant/tenantHome", { error: false, error2: false});
});

//Popular Houses List
router.get('tenant/popular' , authentication.isTenantLoggedIn,(req , res) => {
    const sql = "select houses.* from houses left join houserating on houses.HouseNo = houserating.idHouseRating where houserating.Rating >= 3 ";
    db.query(sql , (err , result) => {
        
        if (err) {
            console.log("error quering sql");
        }
        console.log(result);
        res.render('tenant/popular' , {data : result} );
    })
});

//Houses Near You
router.get('tenant/nearyou' , authentication.isTenantLoggedIn,(req , res) => {
    const sql = "select houses.* from houses where location = {select personalInfo.location from tenant left join personalinfo on tenant.idTenant = ?} ";
    db.query(sql , (err , result) => {
        
        if (err) {
            console.log("error quering sql");
        }
        console.log(result);
        res.render('tenant/nearyou' , {data : result} );
    })
});

//Cheapest Houses
router.get('tenant/cheapest' , authentication.isTenantLoggedIn,(req , res) => {
    const sql = "select houses.* from houses where PricePerHour < {select AVG(PricePerHour) from houses } ";
    db.query(sql , (err , result) => {
        
        if (err) {
            console.log("error quering sql");
        }
        console.log(result);
        res.render('tenant/cheapest' , {data : result} );
    })
});
module.exports = router;