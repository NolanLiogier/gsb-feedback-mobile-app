"use strict";

const express = require("express");
const authRoutes = require("./routes/authRoutes");
const companiesRoutes = require("./routes/companiesRoutes");
const visitsRoutes = require("./routes/visitsRoutes");
const app = express();
const port = Number(process.env.SRV_PORT) || 3000;

app.use(express.json());
app.use("/", authRoutes);
app.use("/companies", companiesRoutes);
app.use("/visits", visitsRoutes);

app.get("/", (req, res) => {
  res.json({ ok: true });
});

app.listen(port, () => {
  console.log(`Server listening on port ${port}`);
});
