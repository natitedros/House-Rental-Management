const { Router } = require('express');
const db = require('../middleware/db_connection');
const authentication = require('../middleware/authentication.js');

const router = Router();

//Home Page for Tenant
router.get("/tenant/home",  authentication.isAdminLoggedIn   , (req, res) => {
    res.render("Tenant/tenantHome", { error: false, error2: false});
});

//Popular Houses List
router.get('/popular' , (req , res) => {
    const sql = "select houses.* from houses left join houserating on houses.HouseNo = houserating.idHouseRating where houserating.Rating >= 3 ";
    db.query(sql , (err , result) => {
        
        if (err) {
            console.log("error quering sql");
        }
        console.log(result);
        res.render('popular' , {data : result} );
    })
});


module.exports = router;