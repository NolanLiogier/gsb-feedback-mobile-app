"use strict";

const express = require("express");
const { getCompaniesListHandler } = require("../controllers/companiesController");

const router = express.Router();
router.get("/getCompaniesList", getCompaniesListHandler);

module.exports = router;
