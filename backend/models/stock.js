"use strict";

const { pool } = require("../config/db");

async function getStockList() {
  const result = await pool.query(
    `SELECT product_id, product_name
     FROM stock
     ORDER BY product_name`
  );
  return result.rows ?? [];
}

module.exports = { getStockList };