"use strict";

const { pool } = require("../config/db");

async function getCompaniesList() {
  const result = await pool.query(
    `SELECT company_id, company_name
     FROM companies
     ORDER BY company_name`
  );
  return result.rows ?? [];
}

module.exports = { getCompaniesList };
