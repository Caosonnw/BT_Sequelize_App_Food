import { response } from "../config/response.js";
import initModels from "../models/init-models.js";
import { sequelize } from "../models/connect.js";
import { decodeToken } from "../config/jwt.js";
import { raw } from "mysql2";

let model = initModels(sequelize);

function generateOrderCode() {
  const randomDigits = Math.floor(100000 + Math.random() * 900000);
  return "ORDER" + randomDigits;
}

const userOrder = async (req, res) => {
  let { token } = req.headers;
  let { arr_sub_id } = req.body;

  try {
    let { data } = decodeToken(token);
    const arr_sub_id_string = JSON.stringify(arr_sub_id);
    const ordered = await model.orders.create(
      {
        amount: arr_sub_id.length,
        code: generateOrderCode(),
        user_id: data.user_id,
        arr_sub_id: arr_sub_id_string,
        food_id: arr_sub_id[0],
      },
      { fields: ["amount", "code", "arr_sub_id", "user_id", "food_id"] }
    );
    response(res, ordered, "Đặt hàng thành công", 200);
  } catch (error) {
    response(res, error, "Lỗi khi đặt hàng", 500);
  }
};

const getOrder = async (req, res) => {
  const { user_id } = req.body;
  try {
    const order = await model.orders.findAll({
      where: { user_id: user_id },
      attributes: ["amount", "code", "arr_sub_id", "user_id", "food_id"],
    });
    response(res, order, "Lấy thông tin đơn hàng thành công", 200);
  } catch (error) {
    response(res, error, "Lỗi khi lấy thông tin đơn hàng", 500);
  }
};

export { userOrder, getOrder };
