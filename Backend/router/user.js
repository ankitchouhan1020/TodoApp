const express = require('express')
const {User} = require('../models/user')
const asyncMiddleware = require('../middleware/async')

const router = express.Router()

router.get('/:id', asyncMiddleware(async (req,res) => {
    const user = await User
        .findById(req.params.id);
    if(!user) return res.status(404).send('No user found with given Id.');
    return res.send(user);
}))

module.exports = router