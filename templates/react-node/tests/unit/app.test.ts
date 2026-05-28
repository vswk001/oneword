import { createApp } from "../../src/app";

describe("App", () => {
  it("should create express app without crashing", () => {
    const app = createApp();
    expect(app).toBeDefined();
  });
});
