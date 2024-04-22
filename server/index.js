const express = require('express');
const mongoose = require('mongoose');
const authRouter = require('./routes/auth');

const PORT = process.env.PORT || 3000;
const app = express();

app.use(express.json());
app.use(authRouter);

/* The `const DB` variable is storing the connection string for MongoDB. This connection string
includes the necessary information to connect to a MongoDB database hosted on the MongoDB Atlas
cloud service. It contains details such as the username, password, cluster address, database name,
and other options like retryWrites and appName. This connection string is then used by Mongoose to
establish a connection to the specified MongoDB database when the application starts. */
const DB = 'mongodb+srv://dhaneswar:DzxgIAXMhpgDrmXo@cluster0.hl3aeih.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0';

/* The `mongoose.connect(DB)` function is establishing a connection to a MongoDB database using the
connection string stored in the `DB` variable. */
mongoose.connect(DB).then(() =>{
    console.log("Connection successful");
}).catch((err) => {
    console.log(err);
})

/* The `app.listen(PORT, "0.0.0.0", () => { console.log(`Server is running on port `); });` code
snippet is setting up the Express application to listen for incoming HTTP requests on a specific
port. */
app.listen(PORT, "0.0.0.0", () => {
    console.log(`Server is running on port ${PORT}`);
});