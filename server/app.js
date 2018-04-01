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

console.log(`server started. port:${port}`);
const server = app.listen(port, () => {
  return console.log(`Express server listening on port ${port}`);
});

const io = require('socket.io')(server);
io.sockets.on('connection', (socket) => {
  console.log('connected');

  socket.emit('CONNECTED');
  let clients = io.sockets.sockets;

  socket.on('message', (message) => {
    console.log('on message %o', message);
    socket.broadcast.emit('sdp', message);
  });
});
