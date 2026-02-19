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
     INNER JOIN companies ON visits.fk_client_id = companies.company_id
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
            s.status_name,
            c.company_name,
            (da.street || ', ' || da.postcode || ' ' || da.city) AS company_address,
            (u.firstname || ' ' || u.lastname) AS client_name,
            u.phone AS client_phone,
            f.fonction_name AS client_function
     FROM visits v
     INNER JOIN status s ON v.fk_status_id = s.status_id
     INNER JOIN companies c ON v.fk_client_id = c.company_id
     INNER JOIN delivery_address da ON c.fk_delivery_id = da.address_id
     INNER JOIN users u ON v.fk_client_id = u.user_id
     INNER JOIN functions f ON u.fk_function_id = f.fonction_id
     WHERE v.visit_id = $1`,
    [id]
  );
  return result.rows[0] ?? null;
}

module.exports = { getVisitsByUserId, getVisitDatasById };
