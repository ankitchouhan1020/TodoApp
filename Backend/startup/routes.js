const express = require('express')
const user = require('../router/user')
const task = require('../router/task')
const home = require('../router/home')
const register = require('../router/register')

module.exports = function(app){
    app.use(express.json());
    app.use('/', home);
    app.use('/api/register', register)
    app.use('/api/user', user);
    app.use('/api/task', task);
}