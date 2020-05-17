const express = require('express')
const pick = require('lodash.pick')
const bcrypt = require('bcrypt')
const {User, validateUser} = require('../models/user')

const router = express.Router()

router.post('/', async (req,res) => {
    const {error} = await validateUser(req.body);
    if(error) return res.status(400).send(error.details[0].message);

    let user = await User.findOne({email: req.body.email});
    if(user) return res.status(409).send('User already registered.');
    
    user = new User(pick(req.body, ['firstName','lastName','email','password']));

    const salt = await bcrypt.genSalt(10);
    user.password = await bcrypt.hash(user.password,salt);

    await user.save();

    const token = user.generateAuthToken();
    return res.status(201).header('x-auth-token', token).send(pick(user, ['firstName','lastName','email']))
})

module.exports = router