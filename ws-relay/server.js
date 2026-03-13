const WebSocket = require('ws');

const port = process.env.WS_PORT || 8080;
const secret = process.env.WS_SECRET || "68d86feb1f6d7a931d179de43b171fae";

const wss = new WebSocket.Server({ port });

wss.on('connection', (ws) => {
  console.log("Neue Verbindung");

  let authenticated = false;

  ws.on('message', (raw) => {
    try {
      const msg = JSON.parse(raw);

      // Auth-Handshake
      if (!authenticated) {
        if (msg.type === 'auth' && msg.secret === secret) {
          authenticated = true;
          ws.send(JSON.stringify({ type: 'auth-ok' }));
          console.log("✅ Authentifizierung erfolgreich");
        } else {
          console.log("❌ Authentifizierung fehlgeschlagen");
          ws.close();
        }
        return;
      }

      // Nach erfolgreicher Auth: Broadcast
      wss.clients.forEach((client) => {
        if (client !== ws && client.readyState === WebSocket.OPEN) {
          client.send(raw);
        }
      });

    } catch (e) {
      console.log("⚠️ Ungültige Nachricht:", raw.toString());
    }
  });
});

console.log(`WebSocket-Relay läuft auf Port ${port}`);
