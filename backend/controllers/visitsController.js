"use strict";

const { findUserById, getEmployeesByCompanyAndFunction, getEmployeesByCompanyId } = require("../models/user");
const { getCompaniesList } = require("../models/company");
const { getStockList } = require("../models/stock");
const {
  getVisitsByUserId,
  getVisitDatasById,
  checkStatusExists,
  checkProductExists,
  createVisit,
  submitFeedback,
  deleteVisit,
} = require("../models/visit");

async function getNewVisitInfosHandler(req, res) {
  if (req.method !== "GET") {
    res.status(405).json({ message: "Method not allowed", data: null });
    return;
  }

  let companies;
  let gsbVisitors;
  try {
    companies = await getCompaniesList();
    gsbVisitors = await getEmployeesByCompanyAndFunction(1, 2);
  } catch (err) {
    res.status(500).json({ message: "Database error", data: null });
    return;
  }

  res.status(200).json({
    message: "OK",
    data: { companies, gsbVisitors },
  });
}

async function getNewVisitDatasHandler(req, res) {
  if (req.method !== "GET") {
    res.status(405).json({ message: "Method not allowed", data: null });
    return;
  }

  const body = req.body;
  if (!body || typeof body !== "object") {
    res.status(400).json({ message: "Invalid body", data: null });
    return;
  }

  const rawCompanyId = body.companyId;
  if (rawCompanyId === undefined) {
    res.status(400).json({ message: "Missing required key: companyId", data: null });
    return;
  }

  const companyId = typeof rawCompanyId === "number" ? rawCompanyId : Number(rawCompanyId);
  if (!Number.isInteger(companyId) || companyId < 1) {
    res.status(400).json({ message: "companyId must be a positive integer", data: null });
    return;
  }

  let gsbVisitors;
  let employeesByCompanyId;
  let stockList;
  try {
    gsbVisitors = await getEmployeesByCompanyAndFunction(1, 2);
    employeesByCompanyId = await getEmployeesByCompanyId(companyId);
    stockList = await getStockList();
  } catch (err) {
    if (err instanceof RangeError) {
      res.status(400).json({ message: err.message, data: null });
      return;
    }
    res.status(500).json({ message: "Database error", data: null });
    return;
  }

  res.status(200).json({
    message: "OK",
    data: {
      gsbVisitors,
      employeesByCompanyId,
      stockList,
    },
  });
}

async function getVisitsByUserIdHandler(req, res) {
  if (req.method !== "GET") {
    res.status(405).json({ message: "Method not allowed", data: null });
    return;
  }

  const body = req.body;
  if (!body || typeof body !== "object") {
    res.status(400).json({ message: "Invalid body", data: null });
    return;
  }

  const userId = body.userId;
  if (userId === undefined) {
    res.status(400).json({ message: "Missing required key: userId", data: null });
    return;
  }

  const id = typeof userId === "number" ? userId : Number(userId);
  if (!Number.isInteger(id) || id < 1) {
    res.status(400).json({ message: "userId must be a positive integer", data: null });
    return;
  }

  let user;
  try {
    user = await findUserById(id);
  } catch (err) {
    if (err instanceof TypeError || err instanceof RangeError) {
      res.status(400).json({ message: err.message, data: null });
      return;
    }
    res.status(500).json({ message: "Database error", data: null });
    return;
  }

  if (!user) {
    res.status(404).json({ message: "User not found", data: null });
    return;
  }

  let visits;
  try {
    visits = await getVisitsByUserId(id);
  } catch (err) {
    res.status(500).json({ message: "Database error", data: null });
    return;
  }

  res.status(200).json({ message: "OK", data: visits });
}

async function getVisitDatasByIdHandler(req, res) {
  if (req.method !== "GET") {
    res.status(405).json({ message: "Method not allowed", data: null });
    return;
  }

  const body = req.body;
  if (!body || typeof body !== "object") {
    res.status(400).json({ message: "Invalid body", data: null });
    return;
  }

  const visitId = body.visitId;
  if (visitId === undefined) {
    res.status(400).json({ message: "Missing required key: visitId", data: null });
    return;
  }

  const id = typeof visitId === "number" ? visitId : Number(visitId);
  if (!Number.isInteger(id) || id < 1) {
    res.status(400).json({ message: "visitId must be a positive integer", data: null });
    return;
  }

  let data;
  try {
    data = await getVisitDatasById(id);
  } catch (err) {
    if (err instanceof RangeError) {
      res.status(400).json({ message: err.message, data: null });
      return;
    }
    res.status(500).json({ message: "Database error", data: null });
    return;
  }

  if (!data) {
    res.status(404).json({ message: "Visit not found", data: null });
    return;
  }
  
  res.status(200).json({ message: "OK", data });
}

function toPositiveInteger(value) {
  const n = typeof value === "number" ? value : Number(value);
  return Number.isInteger(n) && n >= 1 ? n : null;
}

function validNonEmptyString(value, maxLength) {
  if (typeof value !== "string") return false;
  const s = value.trim();
  return s.length > 0 && (maxLength == null || s.length <= maxLength);
}

async function createVisitHandler(req, res) {
  if (req.method !== "POST") {
    res.status(405).json({ message: "Method not allowed", data: null });
    return;
  }

  const body = req.body;
  if (!body || typeof body !== "object") {
    res.status(400).json({ message: "Invalid body", data: null });
    return;
  }

  const visitTitle = body.visit_title;
  if (!validNonEmptyString(visitTitle, 255)) {
    res.status(400).json({
      message: "visit_title is required and must be a non-empty string (max 255)",
      data: null,
    });
    return;
  }

  const fkClientId = toPositiveInteger(body.fk_client_id);
  if (fkClientId === null) {
    res.status(400).json({
      message: "fk_client_id is required and must be a positive integer",
      data: null,
    });
    return;
  }

  const fkGsbVisitorId = toPositiveInteger(body.fk_gsb_visitor_id);
  if (fkGsbVisitorId === null) {
    res.status(400).json({
      message: "fk_gsb_visitor_id is required and must be a positive integer",
      data: null,
    });
    return;
  }

  const fkStatusId = toPositiveInteger(body.fk_status_id);
  if (fkStatusId === null) {
    res.status(400).json({
      message: "fk_status_id is required and must be a positive integer",
      data: null,
    });
    return;
  }

  const fkProductId = body.fk_product_id != null
    ? toPositiveInteger(body.fk_product_id)
    : null;

  const scheduledDate = body.scheduled_date != null ? body.scheduled_date : null;
  const closureDate = body.closure_date != null ? body.closure_date : null;
  const comment =
    body.comment != null && typeof body.comment === "string"
      ? body.comment.trim()
      : null;

  let clientExists;
  let visitorExists;
  let statusExists;
  let productExists = true;

  try {
    const clientUser = await findUserById(fkClientId);
    clientExists = !!clientUser;
    const visitorUser = await findUserById(fkGsbVisitorId);
    visitorExists = !!visitorUser;
    statusExists = await checkStatusExists(fkStatusId);
    if (fkProductId != null) {
      productExists = await checkProductExists(fkProductId);
    }
  } catch (err) {
    res.status(500).json({ message: "Database error", data: null });
    return;
  }

  if (!clientExists) {
    res.status(400).json({
      message: "fk_client_id does not exist in users",
      data: null,
    });
    return;
  }
  if (!visitorExists) {
    res.status(400).json({
      message: "fk_gsb_visitor_id does not exist in users",
      data: null,
    });
    return;
  }
  if (!statusExists) {
    res.status(400).json({
      message: "fk_status_id does not exist in status",
      data: null,
    });
    return;
  }
  if (fkProductId != null && !productExists) {
    res.status(400).json({
      message: "fk_product_id does not exist in stock",
      data: null,
    });
    return;
  }

  let created;
  try {
    created = await createVisit({
      visit_title: visitTitle.trim(),
      fk_client_id: fkClientId,
      fk_gsb_visitor_id: fkGsbVisitorId,
      fk_status_id: fkStatusId,
      fk_product_id: fkProductId,
      scheduled_date: scheduledDate,
      closure_date: closureDate,
      comment,
    });
  } catch (err) {
    res.status(500).json({ message: "Database error", data: null });
    return;
  }

  res.status(201).json({ message: "OK", data: created });
}

async function submitFeedbackHandler(req, res) {
  if (req.method !== "POST") {
    res.status(405).json({ message: "Method not allowed", data: null });
    return;
  }

  const body = req.body;
  if (!body || typeof body !== "object") {
    res.status(400).json({ message: "Invalid body", data: null });
    return;
  }

  const visitId = body.visitId;
  if (visitId === undefined) {
    res.status(400).json({ message: "Missing required key: visitId", data: null });
    return;
  }

  const id = typeof visitId === "number" ? visitId : Number(visitId);
  if (!Number.isInteger(id) || id < 1) {
    res.status(400).json({ message: "visitId must be a positive integer", data: null });
    return;
  }

  const rawRate = body.rate;
  if (rawRate === undefined) {
    res.status(400).json({ message: "Missing required key: rate", data: null });
    return;
  }
  const rateNum = typeof rawRate === "number" ? rawRate : Number(rawRate);
  if (!Number.isInteger(rateNum) || rateNum < 0 || rateNum > 5) {
    res.status(400).json({ message: "rate must be an integer between 0 and 5", data: null });
    return;
  }

  const comment =
    body.comment != null && typeof body.comment === "string"
      ? body.comment.trim()
      : null;

  let updated;
  try {
    updated = await submitFeedback(id, { rate: rateNum, comment });
  } catch (err) {
    if (err instanceof RangeError) {
      res.status(400).json({ message: err.message, data: null });
      return;
    }
    res.status(500).json({ message: "Database error", data: null });
    return;
  }

  if (!updated) {
    res.status(404).json({ message: "Visit not found", data: null });
    return;
  }

  res.status(200).json({ message: "OK", data: { updated: true } });
}

async function deleteVisitHandler(req, res) {
  if (req.method !== "POST") {
    res.status(405).json({ message: "Method not allowed", data: null });
    return;
  }

  const body = req.body;
  if (!body || typeof body !== "object") {
    res.status(400).json({ message: "Invalid body", data: null });
    return;
  }

  const visitId = body.visitId;
  if (visitId === undefined) {
    res.status(400).json({ message: "Missing required key: visitId", data: null });
    return;
  }

  const id = typeof visitId === "number" ? visitId : Number(visitId);
  if (!Number.isInteger(id) || id < 1) {
    res.status(400).json({ message: "visitId must be a positive integer", data: null });
    return;
  }

  let deleted;
  try {
    deleted = await deleteVisit(id);
  } catch (err) {
    if (err instanceof RangeError) {
      res.status(400).json({ message: err.message, data: null });
      return;
    }
    res.status(500).json({ message: "Database error", data: null });
    return;
  }

  if (!deleted) {
    res.status(404).json({ message: "Visit not found", data: null });
    return;
  }

  res.status(200).json({ message: "OK", data: { deleted: true } });
}

module.exports = {
  getNewVisitInfosHandler,
  getNewVisitDatasHandler,
  getVisitsByUserIdHandler,
  getVisitDatasByIdHandler,
  createVisitHandler,
  submitFeedbackHandler,
  deleteVisitHandler,
};
