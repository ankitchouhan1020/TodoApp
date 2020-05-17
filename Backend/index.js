const express = require('express')
const winston = require('winston')

const app = express()

// require('./startup/logging')()
require('./startup/routes')(app);
require('./startup/db')();
require('./startup/validation')();

const port = process.env.port || 3000;
app.listen(port, () => console.log(`App is up and running on ${port}`));