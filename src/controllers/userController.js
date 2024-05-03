import { response } from "../config/response.js";
import initModels from "../models/init-models.js";
import { sequelize } from "../models/connect.js";
import bcrypt from "bcrypt";
import {
  checkToken,
  checkTokenRef,
  createToken,
  createTokenRef,
  decodeToken,
} from "../config/jwt.js";

let model = initModels(sequelize);

const getUser = async (req, res) => {
  let data = await model.users.findAll();
  response(res, data, "", 200);
};

const signUp = async (req, res) => {
  let { fullName, email, password } = req.body;

  let checkEmail = await model.users.findOne({
    where: {
      email: email,
    },
  });
  if (checkEmail) {
    response(res, "", "Email đã tồn tại", 400);
    return;
  }

  let newData = {
    full_name: fullName,
    email: email,
    password: bcrypt.hashSync(password, 10),
    refresh_token: "",
  };
  try {
    let createdUser = await model.users.create(newData);
    response(res, createdUser, "Đăng ký thành công", 200);
  } catch (error) {
    console.error(error);
    response(res, "", error, 500);
  }
};

const generateRandomString = (length) => {
  let result = "";
  const characters =
    "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
  const charactersLength = characters.length;
  for (let i = 0; i < length; i++) {
    result += characters.charAt(Math.floor(Math.random() * charactersLength));
  }
  return result;
};

const login = async (req, res) => {
  let { email, password } = req.body;

  let checkEmail = await model.users.findOne({
    where: {
      email: email,
    },
  });
  if (checkEmail) {
    if (bcrypt.compare(password, checkEmail.password)) {
      let key = generateRandomString(6);
      let token = createToken({ user_id: checkEmail.dataValues.user_id, key });

      let tokenRef = createTokenRef({
        user_id: checkEmail.dataValues.user_id,
        key,
      });

      // Cập nhật lại refresh token trong cơ sở dữ liệu
      await model.users.update(
        { refresh_token: tokenRef },
        {
          where: {
            user_id: checkEmail.user_id,
          },
        }
      );

      checkEmail = await model.users.findOne({
        where: {
          email: email,
        },
      });

      response(res, token, "Đăng nhập thành công", 200);
    } else {
      response(res, "", "Mật khẩu không đúng", 400);
    }
  } else {
    response(res, "", "Email không đúng", 400);
  }
};

const resetToken = async (req, res) => {
  let { token } = req.headers;
  let errToken = checkToken(token);
  if (errToken != null && errToken.name != "TokenExpiredError") {
    response(res, "", "Not Authorized", 401);
    return;
  }

  let { data } = decodeToken(token);
  let getUser = await model.users.findByPk(data.user_id);

  let tokenRef = decodeToken(getUser.dataValues.refresh_token);

  if (data.key != tokenRef.data.key) {
    response(res, "", "Not Authorized", 401);
    return;
  }
  if (checkTokenRef(getUser.dataValues.refresh_token) != null) {

    response(res, "", "Not Authorized", 401);
    return;
  }

  let tokenNew = createToken({
    user_id: getUser.dataValues.user_id,
    key: tokenRef.data.key,
  });
  response(res, tokenNew, "", 200);
};

export { getUser, signUp, login, resetToken };
