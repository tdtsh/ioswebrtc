'use strict';

const WebSocketServer = require('ws').Server;
const port = 4000;
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
});

console.log(`server started. port:${port}`);

