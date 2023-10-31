require('./routes')
const { restoreSessions } = require('./sessions')
const { routes } = require('./routes')
const app = require('express')()
const bodyParser = require('body-parser')
const { maxAttachmentSize } = require('./config')
const cors = require('cors');

// Initialize Express app
app.disable('x-powered-by')
app.use(bodyParser.json({ limit: maxAttachmentSize + 1000000 }))
app.use(bodyParser.urlencoded({ limit: maxAttachmentSize + 1000000, extended: true }))

restoreSessions()

//app.use(cors());

/*app.use((req, res, next) => {
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept, Authortization');
    res.setHeader('Acces-Control-Allow-Methods', 'GET, POST, PATCH, DELETE');
});*/

app.use('/', routes)

module.exports = app
