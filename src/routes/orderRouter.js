import express from "express";
import { userOrder, getOrder } from "../controllers/orderController.js";

const orderRouter = express.Router();

// API user order
orderRouter.post("/user-order", userOrder);

// API get order
orderRouter.get("/get-order", getOrder);

export default orderRouter;
