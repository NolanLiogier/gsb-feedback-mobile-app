"use strict";

const { pool } = require("../config/db");

async function getVisitsByUserId(userId) {
  const id = typeof userId === "number" ? userId : Number(userId);
  if (!Number.isInteger(id) || id < 1) {
    throw new RangeError("userId must be a positive integer");
  }
  const result = await pool.query(
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
  return result.rows;
}

module.exports = { getVisitsByUserId };
