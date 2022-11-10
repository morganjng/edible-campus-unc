var express = require("express"),
  app = express(),
  morgan = require("morgan");

var port = process.env.PORT || process.env.OPENSHIFT_NODEJS_PORT || 8080,
  ip = process.env.IP || process.env.OPENSHIFT_NODEJS_IP || "0.0.0.0",
  mongoURL = process.env.OPENSHIFT_MONGODB_DB_URL || process.env.MONGO_URL,
  mongoURLLabel = "";

Object.assign = require("object-assign");

app.engine("html", require("ejs").renderFile);
app.use(morgan("combined"));
app.get("/", function (req, res) {
  res.send("base");
});

app.get("/full-json", function (req, res) {
  res.send("{ test: 1 }");
});

// error handling
app.use(function (err, req, res, next) {
  console.error(err.stack);
  res.status(500).send("Something bad happened!");
});

app.listen(port, ip);
console.log("Server running on http://%s:%s", ip, port);

module.exports = app;