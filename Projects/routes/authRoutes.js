const { Router } = require('express');
const db = require('../middleware/db_connection');
const authentication = require('../middleware/authentication.js');
const jwt = require('jsonwebtoken');

const router = Router();

//Login page - get request
router.get('/login' , (req , res)=> {
    res.render('login' , {error: false });
});


//Login page - post request
router.post('/login' , (req , res) => { 
 
let pass = false;
let sql1 = `select * 
            from landlord inner join personalinfo
            on personalinfo.idPersonalInfo = landlord.PersonalInfoLandlord
            where email = "${req.body.email}" and password = "${req.body.password}" `;

let sql2 = `select * 
            from tenant inner join personalinfo
            on personalinfo.idPersonalInfo = tenant.PersonalInfoTenant
            where email = "${req.body.email}" and password = "${req.body.password}" `;
 
 db.query(sql1 , (error , result) => {
      if (result !==undefined && result.length > 0 ) {
          const token = jwt.sign({
              
            },
            'SECRETLANDLORD', {
              expiresIn: '7d'
            });
            
            pass=true;
            res.cookie('jwt' , token , {httpOnly:true , maxAge:3600*1000});
            res.redirect('/landlord/home')
             
      } 
      else {

       db.query(sql2 , (error , result) => {
          if (result !==undefined && result.length > 0 ) {
              const token = jwt.sign({
                  
                },
                'SECRETTENANT', {
                  expiresIn: '7d'
                });
                
                pass=true;
                res.cookie('jwt' , token , {httpOnly:true , maxAge:3600*1000});
                res.redirect('/tenant/profile')
      
                 
          } 
          if (!pass){
            res.render('login' , {error:true });
           }
          
       });


      }
     
      
      
   }); 
  
 
     
});

//Example pages
// router.get('/Admin_home' , authentication.isAdminLoggedIn ,(req , res)=> {
//   res.render('admin_home' , { user : req.userData });
// });

// router.get('/Donor_home' , authentication.isDonorLoggedIn ,(req , res)=> {
//   res.render('donor_home' , { user : req.userData });
// });


module.exports = router;





