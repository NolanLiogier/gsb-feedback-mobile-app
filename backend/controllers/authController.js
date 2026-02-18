"use strict";

const argon2 = require("argon2");
const { findUserByEmail } = require("../models/user");
const { testEmail, testPasswordFormat } = require("../utils/regex");

async function login(req, res) {
  if (req.method !== "POST") {
    res.status(405).json({ message : "Method not allowed", data: null});
    return;
  }

  const body = req.body;
  if (!body || typeof body !== "object") {
    res.status(400).json({ message : "Invalid body", data: null});
    return;
  }

  const email = body.email;
  const password = body.password;
  if (email === undefined || password === undefined) {
    res.status(400).json({ message : "Missing required keys: email, password", data: null});
    return;
  }

  if (!testEmail(email)) {
    res.status(400).json({ message : "Invalid email format", data: null});
    return;
  }

  if (!testPasswordFormat(password)) {
    res.status(400).json({ message : "Password must be at least 8 characters", data: null});
    return;
  }

  let user;
  try {
    user = await findUserByEmail(String(email));
  } catch (err) {
    res.status(500).json({ message : "Database error", data: null});
    return;
  }

  if (!user || !user.password) {
    res.status(401).json({ message : "Invalid credentials", data: null});
    return;
  }

  let valid;
  try {
    valid = await argon2.verify(user.password, password);
  } catch (err) {
    res.status(500).json({ message : "Password verification failed", data: null});
    return;
  }

  if (!valid) {
    res.status(401).json({ message : "Invalid credentials", data: null});
    return;
  }

  const { password: _, ...userDatas } = user;
  res.status(200).json({ message : "Login successful", data: userDatas });
}

module.exports = { login };