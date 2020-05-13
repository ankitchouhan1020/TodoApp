const express = require('express')
const {User, validateUser} = require('../models/user')

const router = express.Router()

router.post('/', async (req,res) => {
    const {error} = await validateUser(req.body);
    if(error) return res.status(400).send(error.details[0].message);

    let user = new User(req.body);
    user = await user.save();
    return res.send(user);
})

module.exports = router