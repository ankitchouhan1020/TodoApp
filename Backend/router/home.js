const express = require('express')

const router = express.Router()

router.get('/', (req,res) => {
    res.send('Node app is running...hi there..');
})

module.exports = router