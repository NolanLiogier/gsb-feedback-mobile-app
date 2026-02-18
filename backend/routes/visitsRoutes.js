"use strict";

const express = require("express");
const { getVisitsByUserIdHandler } = require("../controllers/visitsController");

const router = express.Router();
router.get("/getVisitsByUserId", getVisitsByUserIdHandler);

module.exports = router;
