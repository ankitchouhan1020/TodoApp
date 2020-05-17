const mongoose = require('mongoose')

module.exports = function(){
    mongoose.connect('mongodb://localhost/intray')
        .then(() => "Database Connected")
}