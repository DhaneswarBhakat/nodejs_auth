const mongoose = require('mongoose');

/* This code snippet is defining a Mongoose schema for a user in a Node.js application. Let's break
down what each part of the schema is doing: */
const userSchema = new mongoose.Schema({
    name:{
        required: true,
        type: String,
        trim: true,
    },
    email:{
        required: true,
        type: String,
        trim: true,
        validate: {
            validator: (value) => {
            const re =
                /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
            return value.match(re);
            },
            message: "Please enter a valid email address",
        },
    },
    password: {
        required: true,
        type: String,
        validate: {
            validator: (value) => {
            return value.length >= 6;
            },
            message: "Password must be at least 6 characters long",
        },
    },
});

/* `const User = mongoose.model('User', userSchema);` is creating a Mongoose model named 'User' based
on the userSchema that was defined earlier. This line of code is essentially defining a model in
Mongoose that represents a collection in the MongoDB database. The model 'User' will have properties
and validation rules specified in the userSchema, allowing you to interact with the 'User'
collection in the database using Mongoose methods. */
const User = mongoose.model('User', userSchema);
module.exports = User;




module.exports = User;