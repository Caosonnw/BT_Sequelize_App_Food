import express from "express";
import {
  getLikeResByUser,
  getUsersWhoLikedRes,
  likeRes,
} from "../controllers/likeController.js";

const likeRouter = express.Router();

// API lấy danh sách like theo nhà hàng
likeRouter.get("/get-like-res/:user_id", getLikeResByUser);

// API lấy danh sách người dùng đã like nhà hàng
likeRouter.get("/get-users-who-liked-res/:res_id", getUsersWhoLikedRes);

// API like nhà hàng
likeRouter.post("/like-res/:res_id", likeRes);


export default likeRouter;
