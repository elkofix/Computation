import { Router } from "express";
import { ApiController } from "../controllers/api.controller";

const router = Router();

const apicontroller = new ApiController();
router.get("/hello", apicontroller.sayHello)
/**
 * 
 * 
 * 
 * 
 * 
 * 
 */
export default router;