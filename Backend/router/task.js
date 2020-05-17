const express = require('express')

const { Task, validateTask } = require('../models/task')
const asyncMiddleware = require('../middleware/async')
const auth = require('../middleware/auth')

const router = express.Router()

router.get('/:id',auth, asyncMiddleware(async (req,res) => {
    const tasks = await Task.find({userId: req.params.id});
    return res.send({tasks: tasks, len: tasks.length});
}))


router.post('/', asyncMiddleware(async (req,res) => {
    const {error} = validateTask(req.body);
    if(error)
        return res.status(400).send(error.details[0].message);
    // if user is present
    const task = new Task(req.body);
    await task.save();
    return res.send(task);
}))

module.exports = router