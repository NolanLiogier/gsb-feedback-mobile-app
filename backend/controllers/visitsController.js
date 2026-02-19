"use strict";

const { findUserById } = require("../models/user");
const { getVisitsByUserId, getVisitDatasById } = require("../models/visit");

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

module.exports = { getVisitsByUserIdHandler, getVisitDatasByIdHandler };
