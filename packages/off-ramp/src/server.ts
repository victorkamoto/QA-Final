import express, { Express } from "express";
import dotenv from "dotenv";
import routes from "./routes";
import { logger } from "./middleware/logger.middleware";

dotenv.config();

const app: Express = express();
const port = process.env.PORT || 5000;

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use(logger());

// mount routers
// app.use("/api/v1", ...routes);

app.listen(port, () => {
  console.log(`[server]: Server running at http://localhost:${port}`);
});