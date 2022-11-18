const port = 3000
const http = require('http')
const fs = require('fs')
// var e = document.getElementById("#bed");
// var bedname = e.options[e.selectedIndex].text;

const server = http.createServer(function(req, res) {
    res.writeHead(200, {'Content-Type': 'text/html'})
    fs.readFile('index.html', function(error, data) {
        if(error) {
            res.writeHead(404)
            res.write('Error: File Not Found')
        } else {
            res.write(data)
            fs.readFile("../app/edible_campus_data.json", "utf8", (err, jsonString) => {
                if (err) {
                  console.log("File read failed:", err);
                }
                console.log("File data:", jsonString);
              });              
        }
        res.end()
    })
})

server.listen(port, function(error) {
    if(error) {
        console.log("Error", error);
    } else {
        console.log('Server is listening on port '+port)
    }
})
