import request from "supertest";
import { createApp } from "../../src/app";

describe("App", () => {
  it("should create express app without crashing", () => {
    const app = createApp();
    expect(app).toBeDefined();
  });

  it("should return ok status when GET /api/health is called", async () => {
    const app = createApp();
    const response = await request(app).get("/api/health");
    expect(response.status).toBe(200);
    expect(response.body).toEqual({ status: "ok" });
  });
});
