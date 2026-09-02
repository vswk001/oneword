import { GET } from "../../src/app/api/health/route";

describe("GET /api/health", () => {
  it("should return ok status when called", async () => {
    const response = await GET();
    expect(response.status).toBe(200);
    await expect(response.json()).resolves.toEqual({ status: "ok" });
  });
});
