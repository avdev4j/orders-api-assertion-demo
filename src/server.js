// Minimal Orders API. No runtime dependencies.
const http = require("node:http");

const ORDERS = {
  ord_123: {
    id: "ord_123",
    customerId: "cus_456",
    status: "shipped",
    total: 42.5,
    currency: "EUR",
  },
};

const server = http.createServer((req, res) => {
  const send = (code, body) => {
    res.writeHead(code, { "Content-Type": "application/json" });
    res.end(JSON.stringify(body));
  };

  if (req.method === "GET" && req.url === "/health") {
    return send(200, { ok: true });
  }

  const match = req.method === "GET" && req.url.match(/^\/orders\/([^/]+)$/);
  if (match) {
    const order = ORDERS[match[1]];
    if (!order) return send(404, { error: "Order not found" });
    return send(200, order);
  }

  send(404, { error: "Not found" });
});

const port = process.env.PORT || 3000;
server.listen(port, () => console.log(`Orders API listening on :${port}`));
