import { render, screen } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import App from "./App";

describe("App", () => {
  it("should show the welcome heading when the page loads", () => {
    render(<App />);
    expect(screen.getByRole("heading", { name: /welcome/i })).toBeInTheDocument();
  });

  it("should increase the counter when the button is clicked", async () => {
    const user = userEvent.setup();
    render(<App />);
    const button = screen.getByRole("button", { name: /clicked 0 times/i });
    await user.click(button);
    expect(screen.getByRole("button", { name: /clicked 1 times/i })).toBeInTheDocument();
  });
});
