import express from "express";
import {
  getUser,
  signUp,
  login,
  resetToken,
} from "../controllers/userController.js";

const userRouter = express.Router();

// API get-all-user
userRouter.get("/get-user", getUser);

// API sign up
userRouter.post("/sign-up", signUp);

// API login
userRouter.post("/login", login);

// API refresh token
userRouter.post("/reset-token", resetToken);

export default userRouter;
