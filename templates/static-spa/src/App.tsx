import { useState } from "react";

function App() {
  const [count, setCount] = useState(0);

  return (
    <main className="flex min-h-screen flex-col items-center justify-center p-24">
      <h1 className="text-4xl font-bold">Welcome</h1>
      <p className="mt-4 text-gray-500">Your app is running.</p>
      <button
        type="button"
        className="mt-8 rounded bg-blue-600 px-4 py-2 text-white hover:bg-blue-700"
        onClick={() => setCount((current) => current + 1)}
      >
        Clicked {count} times
      </button>
    </main>
  );
}

export default App;
