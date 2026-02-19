"use strict";

const express = require("express");
const { getVisitsByUserIdHandler, getVisitDatasByIdHandler } = require("../controllers/visitsController");

const router = express.Router();
router.get("/getVisitsByUserId", getVisitsByUserIdHandler);
router.get("/getVisitDatasById", getVisitDatasByIdHandler);

module.exports = router;
