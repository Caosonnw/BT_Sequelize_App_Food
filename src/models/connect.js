import { Sequelize } from "sequelize";
import config from "../config/config.js";

export const sequelize = new Sequelize(
  config.db_database,
  config.db_user,
  config.db_pass,
  {
    host: config.db_host,
    dialect: config.db_dialect,
    port: config.db_port,
  }
);

// yarn sequelize-auto -h localhost -d bt_sql -u root -x 1234 -p 3306 --dialect mysql -o src/models -l esm
