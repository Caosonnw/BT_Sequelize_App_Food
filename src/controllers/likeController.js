import { response } from "../config/response.js";
import initModels from "../models/init-models.js";
import { sequelize } from "../models/connect.js";
import { decodeToken } from "../config/jwt.js";

let model = initModels(sequelize);

const getLikeResByUser = async (req, res) => {
  const { user_id } = req.params;
  try {
    const likedRestaurants = await model.like_res.findAll({
      where: { user_id },
      attributes: ["date_like", "user_id"],
      include: [
        {
          model: model.users,
          as: "user",
          attributes: ["user_id", "full_name"],
        },
        {
          model: model.restaurant,
          as: "re",
          attributes: ["res_id", "res_name"],
        },
      ],
      raw: true,
    });

    response(res, likedRestaurants, "Lấy danh sách thành công", 200);
  } catch (error) {
    response(res, error, "Lỗi khi lấy danh sách nhà hàng đã thích", 500);
  }
};

const getUsersWhoLikedRes = async (req, res) => {
  const { res_id } = req.params;
  try {
    const likedUsers = await model.like_res.findAll({
      where: { res_id },
      attributes: [],
      include: [
        {
          model: model.users,
          as: "user",
          attributes: ["user_id", "full_name", "email"],
        },
      ],
      raw: true,
    });
    response(res, likedUsers, "Lấy danh sách thành công", 200);
  } catch (error) {
    response(res, error, "Lỗi khi lấy danh sách người dùng đã thích", 500);
  }
};

const likeRes = async (req, res) => {
  const res_id = req.params.res_id;
  let { token } = req.headers;

  try {
    let { data } = decodeToken(token);
    const existingLike = await model.like_res.findOne({
      where: {
        user_id: data.user_id,
        res_id: res_id,
      },
      attributes: { exclude: ["id"] },
    });
    if (existingLike) {
      await model.like_res.destroy({
        where: {
          user_id: data.user_id,
          res_id: res_id,
        },
      });
      response(res, null, "Unlike nhà hàng thành công", 200);
    } else {
      const like = await model.like_res.create(
        {
          user_id: data.user_id,
          res_id: res_id,
          date_like: new Date(),
        },
        { fields: ["user_id", "res_id", "date_like"] }
      );
      response(res, like, "Like nhà hàng thành công", 200);
    }
  } catch (error) {
    response(res, error, "Lỗi khi like nhà hàng", 500);
  }
};

export { getLikeResByUser, getUsersWhoLikedRes, likeRes };

