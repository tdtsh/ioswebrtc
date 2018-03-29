'use strict';

console.log('js/index.js');
const socket = io('http://localhost:4000');

socket.on('CONNECTED', function(data) {
  console.log('vindex CONNECTED');
  socket.emit('message', 'hellow world');
  socket.on('sdp', (sdp) => {
    console.log('sdp %o', sdp);
  });
});
