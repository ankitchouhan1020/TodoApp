const logger = require('../startup/logging')

module.exports = function (err, req, res, next){
    // Logger Code
    logger.add('error',err.message);
    res.status(500).send('Something went wrong.')
}