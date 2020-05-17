const express = require('express')
const bcrypt = require('bcrypt')
const Joi = require('joi')

const asyncMiddleware = require('../middleware/async')
const { User } = require('../models/user')

const router = express.Router()

router.post('/', asyncMiddleware(async (req, res) => {
    const { error } = validateSignIn(req.body);
    if (error) return res.status(400).send(error.details[0].message);

    let user = await User.findOne({ email: req.body.email });
    if (!user) return res.status(401).send('Email not registered.');

    const validatePassword = await bcrypt.compare(req.body.password, user.password);
    if (!validatePassword) return res.status(401).send('Incorrect Password');

    const token = user.generateAuthToken();
    return res.send(token);
}))

function validateSignIn(signInReq) {
    const schema = {
        email: Joi.string().min(5).max(255).email({ minDomainAtoms: 2 }).required(),
        password: Joi.string().required(),
    }
    return Joi.validate(signInReq, schema);
}

module.exports = router