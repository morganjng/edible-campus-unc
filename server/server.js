var express = require("express"),
  app = express(),
  morgan = require("morgan"),
  fs = require("fs");

var port = 8080,
  ip = "0.0.0.0";

Object.assign = require("object-assign");

app.engine("html", require("ejs").renderFile);
app.use(morgan("combined"));
app.get("/", function (req, res) {
  res.send("base");
});

app.get("/data/latest", function (req, res) {
  res.send(latest);
});

// error handling
app.use(function (err, req, res, next) {
  console.error(err.stack);
  res.status(500).send("Something bad happened!");
});

app.listen(port, ip);
console.log("Server running on http://%s:%s", ip, port);

var origin_data = fs.readFileSync("data/origin_data.json");
try {
  var latest = fs.readFileSync("data/latest.json");
} catch (error) {
  fs.writeFileSync("data/latest.json", origin_data);
}
var latest = fs.readFileSync("data/latest.json");

module.exports = app;
