"use strict";

const express = require("express");
const {
  getVisitsByUserIdHandler,
  getVisitDatasByIdHandler,
  getNewVisitDatasHandler,
  createVisitHandler,
  submitFeedbackHandler,
  deleteVisitHandler,
} = require("../controllers/visitsController");

const router = express.Router();
router.get("/getVisitsByUserId", getVisitsByUserIdHandler);
router.get("/getVisitDatasById", getVisitDatasByIdHandler);
router.get("/getNewVisitDatas", getNewVisitDatasHandler);
router.post("/createVisit", createVisitHandler);
router.post("/submitFeedback", submitFeedbackHandler);
router.post("/deleteVisit", deleteVisitHandler);

module.exports = router;
