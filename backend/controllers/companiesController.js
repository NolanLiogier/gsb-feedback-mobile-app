"use strict";

const { getCompaniesList } = require("../models/company");

async function getCompaniesListHandler(req, res) {
  if (req.method !== "GET") {
    res.status(405).json({ message: "Method not allowed", data: null });
    return;
  }

  let list;
  try {
    list = await getCompaniesList();
  } catch (err) {
    res.status(500).json({ message: "Database error", data: null });
    return;
  }

  res.status(200).json({ message: "OK", data: list });
}

module.exports = { getCompaniesListHandler };
