require('./routes')
const { restoreSessions } = require('./sessions')
const { routes } = require('./routes')
const app = require('express')()
const bodyParser = require('body-parser')
const { maxAttachmentSize } = require('./config')
const cors = require('cors');

// Initialize Express app
app.disable('x-powered-by')

let corsOptions = { 
    origin : ['http://localhost:3002','http://localhost:3003','http://localhost:3000'], 
} 

app.use(cors(corsOptions));
app.use(bodyParser.json({ limit: maxAttachmentSize + 1000000 }))
app.use(bodyParser.urlencoded({ limit: maxAttachmentSize + 1000000, extended: true }))

restoreSessions()

app.use('/', routes)

module.exports = app
