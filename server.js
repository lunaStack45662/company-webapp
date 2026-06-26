const http = require('http');
const url = require('url');

const server = http.createServer((req, res) => {
  if (req.method === 'POST') {
    let body = '';
    req.on('data', chunk => body += chunk);
    req.on('end', () => {
      console.log('[STOLEN SECRET]', body);
      res.writeHead(200, { 'Content-Type': 'text/plain' });
      res.end('received');
    });
    
  } else {
    res.writeHead(200, { 'Content-Type': 'text/plain' });
    res.end('webhook ready');
  }
});

server.listen(3000, () => console.log('Webhook server listening on :3000'));