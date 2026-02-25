"use strict";

const { pool } = require("../config/db");

async function getVisitsByUserId(userId) {
  const id = typeof userId === "number" ? userId : Number(userId);
  if (!Number.isInteger(id) || id < 1) {
    throw new RangeError("userId must be a positive integer");
  }
  let result = await pool.query(
    `SELECT visits.visit_id, visits.visit_title, visits.scheduled_date, visits.closure_date, visits.comment,
            status.status_name,
            companies.company_name
     FROM visits
     INNER JOIN status ON visits.fk_status_id = status.status_id
     INNER JOIN users AS visitor ON visits.fk_gsb_visitor_id = visitor.user_id
     INNER JOIN users AS client ON visits.fk_client_id = client.user_id
     INNER JOIN companies ON client.fk_company_id = companies.company_id
     WHERE client.user_id = $1 OR visitor.user_id = $1
     ORDER BY visits.scheduled_date DESC`,
    [id]
  );
  return result.rows ?? [];
}

async function getVisitDatasById(visitId) {
  const id = typeof visitId === "number" ? visitId : Number(visitId);
  if (!Number.isInteger(id) || id < 1) {
    throw new RangeError("visitId must be a positive integer");
  }

  let result = await pool.query(
    `SELECT v.visit_id, v.visit_title, v.scheduled_date, v.closure_date, v.creation_date, v.comment,
            v.fk_status_id AS status_id, v.feedback,
            s.status_name,
            c.company_name,
            (da.street || ', ' || da.postcode || ' ' || da.city) AS company_address,
            (u.firstname || ' ' || u.lastname) AS client_name,
            u.phone AS client_phone,
            f.fonction_name AS client_function
     FROM visits v
     INNER JOIN status s ON v.fk_status_id = s.status_id
     INNER JOIN users u ON v.fk_client_id = u.user_id
     INNER JOIN companies c ON u.fk_company_id = c.company_id
     INNER JOIN delivery_address da ON c.fk_delivery_id = da.address_id
     INNER JOIN functions f ON u.fk_function_id = f.fonction_id
     WHERE v.visit_id = $1`,
    [id]
  );
  return result.rows[0] ?? null;
}

function toPositiveInteger(value) {
  const n = typeof value === "number" ? value : Number(value);
  return Number.isInteger(n) && n >= 1 ? n : null;
}

async function checkCompanyExists(companyId) {
  const id = toPositiveInteger(companyId);
  if (id === null) return false;
  const result = await pool.query(
    "SELECT company_name FROM companies WHERE company_id = $1 LIMIT 1",
    [id]
  );
  return (result.rows?.length ?? 0) > 0;
}

async function checkStatusExists(statusId) {
  const id = toPositiveInteger(statusId);
  if (id === null) return false;
  const result = await pool.query(
    "SELECT status_name FROM status WHERE status_id = $1 LIMIT 1",
    [id]
  );
  return (result.rows?.length ?? 0) > 0;
}

async function checkProductExists(productId) {
  const id = toPositiveInteger(productId);
  if (id === null) return false;
  const result = await pool.query(
    "SELECT product_name FROM stock WHERE product_id = $1 LIMIT 1",
    [id]
  );
  return (result.rows?.length ?? 0) > 0;
}

async function createVisit(payload) {
  const {
    visit_title,
    fk_client_id,
    fk_gsb_visitor_id,
    fk_status_id,
    fk_product_id,
    scheduled_date,
    closure_date,
    comment,
  } = payload;
  
  const result = await pool.query(
    `INSERT INTO visits (
      visit_title, fk_client_id, fk_gsb_visitor_id, fk_status_id, fk_product_id,
      scheduled_date, closure_date, comment
    )
    VALUES ($1, $2, $3, $4, $5, $6, $7, $8)`,
    [
      visit_title,
      fk_client_id,
      fk_gsb_visitor_id,
      fk_status_id,
      fk_product_id ?? null,
      scheduled_date ?? null,
      closure_date ?? null,
      comment ?? null,
    ]
  );

  return result.rowCount > 0;
}

async function submitFeedback(visitId, payload) {
  const id = typeof visitId === "number" ? visitId : Number(visitId);
  if (!Number.isInteger(id) || id < 1) {
    throw new RangeError("visitId must be a positive integer");
  }
  const { rate, comment } = payload;
  const result = await pool.query(
    `UPDATE visits
     SET closure_date = CURRENT_TIMESTAMP, feedback = $1, comment = COALESCE($2, comment), fk_status_id = 3
     WHERE visit_id = $3`,
    [rate ?? null, comment ?? null, id]
  );
  return result.rowCount > 0;
}

async function deleteVisit(visitId) {
  const id = typeof visitId === "number" ? visitId : Number(visitId);
  if (!Number.isInteger(id) || id < 1) {
    throw new RangeError("visitId must be a positive integer");
  }
  const result = await pool.query(
    "DELETE FROM visits WHERE visit_id = $1",
    [id]
  );
  return result.rowCount > 0;
}

module.exports = {
  getVisitsByUserId,
  getVisitDatasById,
  checkCompanyExists,
  checkStatusExists,
  checkProductExists,
  createVisit,
  submitFeedback,
  deleteVisit,
};
