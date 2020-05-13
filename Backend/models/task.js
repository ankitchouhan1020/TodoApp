const Joi = require('joi')
const mongoose = require('mongoose')

const User = require('./user')

const taskSchema = mongoose.Schema({
    title: {
        type: String,
        required: true,
        minLength: 3,
        maxLength: 128,
        trim: true,
    },
    userId:{
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
    },
    note:{
        type: String,
        maxLength: 1028,
        trim: true,
    },
    completed:{
        type: Boolean,
        default: false,
    },
    deadline: {
        type: Date,
        required: true,
    },
    reminders:{
        type: [Date],
    },
});

const Task = mongoose.model('Task', taskSchema);

function validateTask(task){
    const schema = {
        title: Joi.string().min(3).max(128).required(),
        userId: Joi.string().required(), //change to objectId()
        note: Joi.string().max(1028),
        completed: Joi.boolean(),
        deadline: Joi.date().required(),
        reminders: Joi.array().items(Joi.date()),
    }
    return Joi.validate(task, schema);
}

exports.Task = Task;
exports.validateTask = validateTask;