import express from "express";
import userRouter from "./userRouter.js";
import likeRouter from "./likeRouter.js";
import orderRouter from "./orderRouter.js";

const rootRouter = express.Router();

rootRouter.use("/user", userRouter);
rootRouter.use("/like", likeRouter);
rootRouter.use("/order", orderRouter);

export default rootRouter;
