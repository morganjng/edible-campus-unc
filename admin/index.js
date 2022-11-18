const { spawnSync } = require('child_process');
const express = require('express')
const app = express();
const port = 3000
var bodyParser = require('body-parser')

const fs = require('fs')

var urlencodedParser = bodyParser.urlencoded({ extended: false })

app.post("/",urlencodedParser, function(req, res) {
    // fs.readFile("../app/edible_campus_data.json", "utf8", (err, jsonString) => {
    const fileData = fs.readFileSync("test.json", "utf8")
    const jsonData = JSON.parse(fileData)  
    //push new plant into garden
    if(!(jsonData.garden[req.body.bed].plants.includes(req.body.name))){
        jsonData.garden[req.body.bed].plants.push(req.body.name)
    } 
    if(!(jsonData.plant_keys.includes(req.body.name))) {
        jsonData.plant_keys.push(req.body.name)
    }
    // add new plant in plant
    const plant = {
        common: req.body.name.charAt(0).toUpperCase()+ req.body.name.slice(1),
        scientific: req.body.s_name,
        images : req.body.image,
        recipes: req.body.recipe,
        description : req.body.description
    }
    jsonData.plant[req.body.name] = plant
    fs.writeFile("test.json", JSON.stringify(jsonData, null, 2), (err) => console.log(err))

    res.redirect('back');
})
// [Object: null prototype] {
//     bed: 'stacy',
//     name: 'hkj',
//     s_name: 'jkh',
//     recipe: 'khkjh',
//     image: 'plover_and_chick.jpeg'
//   }
app.post('/delete', urlencodedParser, function(req, res) {
    const fileData = fs.readFileSync("test.json", "utf8")
    const jsonData = JSON.parse(fileData)  
    
})

app.use(express.static("webpage"))
app.listen(port,function(error) {
    if(error) {
        console.log("Error", error);
    } else {
        console.log('Server is listening on port '+port)
    }
})