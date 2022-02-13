const jwt = require("jsonwebtoken");

module.exports = {
    isLandlordLoggedIn: (req, res, next) => {
        try {
          const token = req.cookies.jwt;
          const decoded = jwt.verify(
            token,
            'SECRETLANDLORD'
          );
          req.userData = decoded;
          next();
        } catch (err) {
          return res.redirect('/login');
        }
      } ,
      isTenantLoggedIn: (req, res, next) => {
        try {
          const tokenn = req.cookies.jwt;
          const decodedd = jwt.verify(
            tokenn,
            'SECRETTENANT'
          );
          req.userData = decodedd;
          next();
        } catch (err) {
          return res.redirect('/login');
        }
      } ,
      
}