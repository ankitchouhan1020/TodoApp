const express = require('express')
const { Task, validateTask } = require('../models/task')

const router = express.Router()

//jwt auth here
router.get('/:id', async (req,res) => {
    const tasks = await Task.find({userId: req.params.id});
    return res.send({tasks: tasks, len: tasks.length});
})


router.post('/', async (req,res) => {
    const {error} = validateTask(req.body);
    if(error)
        return res.status(400).send(error.details[0].message);
    // if user is present
    const task = new Task(req.body);
    await task.save();
    return res.send(task);
})

module.exports = router