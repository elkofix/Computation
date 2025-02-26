"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const api_controller_1 = require("./api.controller");
const router = (0, express_1.Router)();
const apicontroller = new api_controller_1.ApiController();
router.get("/hello", apicontroller.sayHello);
exports.default = router;
