import { greet } from "../../../src/commands/greet";

describe("greet command", () => {
  it("should return a greeting containing the name when called with a valid name", () => {
    expect(greet("World")).toBe("Hello, World!");
  });

  it("should trim surrounding whitespace from the name when called", () => {
    expect(greet("  World  ")).toBe("Hello, World!");
  });

  it("should throw a clear error when the name is empty or whitespace only", () => {
    expect(() => greet("   ")).toThrow("name must not be empty");
  });
});
