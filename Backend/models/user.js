const Joi = require('joi')
const jwt = require('jsonwebtoken')
const mongoose = require('mongoose')

const userSchema = mongoose.Schema({
    firstName: {
        type: String,
        required: true,
        minLength: 3,
        maxLenght: 128,
        trim: true,
    },
    lastName: {
        type: String,
        required: true,
        minLength: 3,
        maxLenght: 128,
        trim: true,
    },
    email: {
        type: String,
        required: true,
        validate: {
            validator: function(v) {
                var re = /\S+@\S+\.\S+/;
                return re.test(v);
            },
            message: 'Email is formatted incorrectly.'
        },
        trim: true,
    },
    password: {
        type: String,
        required: true,
        trim: true,
    },
});

//before compilation, add a method to generate auth token
userSchema.methods.generateAuthToken = function(){
    return jwt.sign({ _id: this._id }, "mySecretHere");
}

const User = mongoose.model('User', userSchema);

function validateUser(user){
    const schema = {
        firstName: Joi.string().min(3).max(128).required(),
        lastName: Joi.string().min(3).max(128).required(),
        email: Joi.string().min(5).max(128).email({minDomainAtoms: 2}).required(),
        password: Joi.string().regex(/^[a-zA-Z0-9]{3,30}$/).required(),
    }
    return Joi.validate(user, schema);
}

exports.User = User;
exports.validateUser = validateUser;