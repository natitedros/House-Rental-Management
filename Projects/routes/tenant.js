const { Router } = require('express');
const db = require('../middleware/db_connection');
const authentication = require('../middleware/authentication.js');

const router = Router();

//Home Page for Tenant
router.get("/tenant/home",  authentication.isTenantLoggedIn, (req, res) => {
    res.render("./Tenant/tenantHome", { error: false, error2: false});
});

//Popular Houses List
router.get('/tenant/popular' , authentication.isTenantLoggedIn,(req , res) => {
    const sql = `select houses.* 
    from houses left join houserating 
    on houses.HouseNo = houserating.HouseNumberRating 
    where houserating.Rating >= 4`;
    db.query(sql , (err , result) => {
        
        if (err) {
            console.log("error quering sql");
        }
        console.log(result);
        res.render('tenant/popular' , {data : result} );
    })
});

router.get('/tenant/popular/:id' , (req , res) => {
    const sql = `SELECT * FROM houses LEFT JOIN housinginfo 
    ON houses.HouseNo = housingInfo.HouseNumber 
    WHERE housinginfo.HouseNumber = ?`;
    db.query(sql,[req.params.id] , (err , result) => {
        
        if (err) {
            console.log("error quering sql");
        }
        console.log(result);
        res.render('tenant/popularDetails' , {data : result} );
    })
});

//Houses Near You
router.get('/tenant/nearyou' , authentication.isTenantLoggedIn,(req , res) => {
    const sql = `select houses.* 
    from houses where 
    location = (select personalInfo.location 
    from personalinfo 
    where idPersonalInfo = 4)`;
    db.query(sql , (err , result) => {
        
        if (err) {
            console.log("error quering sql");
        }
        console.log(result);
        res.render('Tenant/nearyou' , {data : result} );
    })
});

//Cheapest Houses
router.get('/tenant/cheapest' , authentication.isTenantLoggedIn,(req , res) => {
    const sql = "select houses.* from houses where PricePerHour < (select AVG(PricePerHour) from houses ) ";
    db.query(sql , (err , result) => {
        
        if (err) {
            console.log("error quering sql");
        }
        console.log(result);
        res.render('tenant/cheapest' , {data : result} );
    })
});

router.get('/tenant/cheapest/:id' , (req , res) => {
    const sql = `SELECT * FROM houses LEFT JOIN housinginfo 
    ON houses.HouseNo = housingInfo.HouseNumber 
    WHERE housinginfo.HouseNumber = ?`;
    db.query(sql,[req.params.id] , (err , result) => {
        
        if (err) {
            console.log("error quering sql");
        }
        console.log(result);
        res.render('tenant/cheapestDetails' , {data : result} );
    })
});

router.get('/tenant/request' , authentication.isTenantLoggedIn,(req , res) => {
    const sql = `select houses.* 
    from houses left join houserating 
    on houses.HouseNo = houserating.HouseNumberRating`;
    db.query(sql , (err , result) => {
        
        if (err) {
            console.log("error quering sql");
        }
        console.log(result);
        res.render('tenant/request' , {data : result} );
    })
});

router.get('/tenant/request/:id' , (req , res) => {
    const sql = `SELECT * FROM houses LEFT JOIN housinginfo 
    ON houses.HouseNo = housingInfo.HouseNumber 
    WHERE housinginfo.HouseNumber = ?`;
    db.query(sql,[req.params.id] , (err , result) => {
        
        if (err) {
            console.log("error quering sql");
        }
        console.log(result);
        res.render('tenant/requestDetail' , {data : result} );
    })
});

router.post('/tenant/request/:id' , authentication.isTenantLoggedIn,(req , res) => {

    console.log(req.body);
    let sql = "INSERT INTO RentalRequest(Tenant, HouseNumberId) values ('" + req.body.tenantid + "' , '" + req.body.houseno + "')";
    db.query(sql , (err , result) => {
        if(err){
            console.log(err.message);
        }
        console.log(result);
       res.redirect('/tenant/request' );
   });
   

});

module.exports = router;