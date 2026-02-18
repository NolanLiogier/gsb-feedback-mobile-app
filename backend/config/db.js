"use strict";
require("dotenv").config();
const { Pool } = require("pg");

const required = ["DB_HOST", "DB_PORT", "DB_USER", "DB_PASSWORD", "DB_NAME"];
const missing = required.filter((key) => {
  const value = process.env[key];
  return value === undefined || value === "";
});

if (missing.length > 0) {
  throw new Error(`Missing required env: ${missing.join(", ")}`);
}

const port = Number(process.env.DB_PORT);
if (Number.isNaN(port) || port < 1 || port > 65535) {
  throw new Error("DB_PORT must be a number between 1 and 65535");
}

const pool = new Pool({
  host: process.env.DB_HOST,
  port,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
});

module.exports = { pool };
