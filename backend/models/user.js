"use strict";

const { pool } = require("../config/db");

async function findUserByEmail(email) {
  if (typeof email !== "string") {
    throw new TypeError("email must be a string");
  }
  
  const normalized = email.trim();
  if (normalized.length === 0 || normalized.length > 255) {
    throw new RangeError("email length is invalid");
  }
  const result = await pool.query(
    `SELECT users.user_id, users.firstname, users.lastname, users.email, users.password, users.fk_function_id, users.fk_company_id,
            functions.fonction_name AS function_name, 
            companies.company_name AS company_name
     FROM users
     INNER JOIN functions ON users.fk_function_id = functions.fonction_id
     INNER JOIN companies ON users.fk_company_id = companies.company_id
     WHERE LOWER(users.email) = LOWER($1)
     LIMIT 1`,
    [normalized]
  );
  return result.rows[0] ?? null;
}

async function findUserById(userId) {
  if (typeof userId !== "number" && (typeof userId !== "string" || String(userId).trim().length === 0)) {
    throw new TypeError("userId must be a non-empty number or string");
  }
  const id = typeof userId === "number" ? userId : Number(String(userId).trim());
  if (!Number.isInteger(id) || id < 1) {
    throw new RangeError("userId must be a positive integer");
  }
  const result = await pool.query(
    `SELECT users.user_id, users.firstname, users.lastname, users.email, users.password, users.fk_function_id, users.fk_company_id,
            functions.fonction_name AS function_name,
            companies.company_name AS company_name
     FROM users
     INNER JOIN functions ON users.fk_function_id = functions.fonction_id
     INNER JOIN companies ON users.fk_company_id = companies.company_id
     WHERE users.user_id = $1
     LIMIT 1`,
    [id]
  );
  return result.rows[0] ?? null;
}

module.exports = { findUserByEmail, findUserById };
