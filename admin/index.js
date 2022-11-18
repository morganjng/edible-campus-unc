const { spawnSync } = require('child_process');
const express = require('express')
const app = express();
const port = 3000
const fs = require('fs')



// app.post("/", function(req, res) {

// })

app.post("/", function(req, res) {
    fs.readFile("../app/edible_campus_data.json", "utf8", (err, jsonString) => {
        if (err) {
          console.log("File read failed:", err);
        }
        const jsonData = JSON.parse(jsonString)
        var gardenname = jsonData.garden
        console.log(gardenname)
      });         
      res.redirect('back');
})

app.use(express.static("webpage"))

app.listen(port,function(error) {
    if(error) {
        console.log("Error", error);
    } else {
        console.log('Server is listening on port '+port)
    }
})