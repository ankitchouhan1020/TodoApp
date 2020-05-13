const express = require('express')
const { Task, validateTask } = require('../models/task')

const router = express.Router()

router.get('/:id', async (req,res) => {
    const task = await Task
        .findById(req.params.id);
    if(!task) return res.status(404).send('No Task found with given Id.');
    return res.send(task);
})


router.post('/', async (req,res) => {
    const {error} = validateTask(req.body);
    if(error)
        return res.status(400).send(error.details[0].message);
    const task = new Task(req.body);
    await task.save();
    return res.send(task);
})

module.exports = router