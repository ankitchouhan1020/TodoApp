const express = require('express')

const error = require('../middleware/error');
const user = require('../router/user')
const task = require('../router/task')
const home = require('../router/home')
const register = require('../router/register')
const signin = require('../router/signin')

module.exports = function(app){
    app.use(express.json());
    app.use('/', home);
    app.use('/api/register', register)
    app.use('/api/signin', signin )
    app.use('/api/user', user);
    app.use('/api/task', task);
    app.use(error);
}