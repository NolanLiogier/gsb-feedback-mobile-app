"use strict";

const email = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
const city = /^[a-zA-Z\u00C0-\u024F\s\-']+$/;
const postcode = /^[A-Z0-9\s\-]{3,12}$/i;
const passwordMinLength = /^.{8,}$/;

function testEmail(value) {
  return typeof value === "string" && email.test(value.trim());
}

function testCity(value) {
  return typeof value === "string" && city.test(value.trim());
}

function testPostcode(value) {
  return typeof value === "string" && postcode.test(value.trim());
}

function testPasswordFormat(value) {
  return typeof value === "string" && value.length > 0 && passwordMinLength.test(value);
}

module.exports = {
  email,
  city,
  postcode,
  passwordMinLength,
  testEmail,
  testCity,
  testPostcode,
  testPasswordFormat,
};
