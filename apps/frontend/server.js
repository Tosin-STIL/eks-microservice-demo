const express = require('express');
const bodyParser = require('body-parser');
const axios = require('axios');
const app = express();
const path = require("path");
const Prometheus = require('prom-client');
const AWSXRay = require('aws-xray-sdk');

// Instrumentation setup
app.use(AWSXRay.express.openSegment('Frontend-Node'));
Prometheus.collectDefaultMetrics();

// Fallback base URL to Kubernetes service
let baseProductUrl = process.env.BASE_URL;
if (!baseProductUrl) {
    baseProductUrl = 'http://detail:3000/catalogDetail';  // ✅ Kubernetes DNS-based routing
}

console.log(`Catalog Detail Base URL: ${baseProductUrl}`);

// ========================
// Middleware and Static Assets
// ========================
app.set('view engine', 'ejs');
app.use(express.static(path.join(__dirname, "public")));
app.use(bodyParser.urlencoded({ extended: true }));

// ========================
// Routes
// ========================
app.get('/', (req, res) => {
    axios.all([axios.get(baseProductUrl)])
        .then(axios.spread((responseOne) => {
            res.render('index.ejs', {
                vendors: responseOne.data.vendors,
                version: responseOne.data.version
            });
            console.log("Catalog Detail get call was Successful from frontend");
        }))
        .catch(errors => {
            console.error(errors);
            console.log("There was an error in Catalog Detail get call from frontend");
            res.status(500).send("Internal Server Error");
        });
});

app.get("/ping", (req, res) => {
    res.json("Healthy");
});

app.get('/stats/prometheus', (req, res) => {
    res.set('Content-Type', Prometheus.register.contentType);
    res.end(Prometheus.register.metrics());
});

// Finalize segment
app.use(AWSXRay.express.closeSegment());

// ========================
// Start Server
// ========================
app.listen(9000, '0.0.0.0', () => {
    console.log('Listening on port 9000');
});
