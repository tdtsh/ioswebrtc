'use strict';

const express = require('express');
const path = require('path');
const app = express();
const ECT = require('ect');
const ectRenderer = ECT({
  watch: true,
  root: __dirname + '/views',
  ext: '.ect'
});
app.set('view engine', 'ect');
app.engine('ect', ectRenderer.render);

app.use(express.static(path.join(__dirname, 'public')));

const routes = require('./routes/index');
app.use('/', routes);

const port = 4000;
/*const WebSocketServer = require('ws').Server;
const wsServer = new WebSocketServer({
  port: port
});

wsServer.on('connection', (ws) => {
  console.log('connected');
  ws.on('message', (message) => {
    wsServer.clients.forEach((client) => {
      if (ws === client) {
        console.log('skip');
      } else {
        client.send(message);
      }
    });
  });
});*/

console.log(`server started. port:${port}`);
const server = app.listen(port, () => {
  return console.log(`Express server listening on port ${port}`);
});

const io = require('socket.io')(server);
io.sockets.on('connection', (socket) => {
  console.log('connected');
  socket.on('message', (message) => {
    socket.broadcast.emit('message'. message);
  });
});
