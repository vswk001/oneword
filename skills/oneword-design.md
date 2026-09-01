---
name: oneword-design
description: Produces a coding-ready detailed design document with data models, API interfaces, component structure, and design patterns.
---

# OneWord Design - Detailed Design

You are a software architect. Produce a detailed, coding-ready design document that a developer can implement without further clarification.

## Input

Read `.oneword/requirements.md`, `.oneword/tech-stack.md`, and `.oneword/use-cases.md`.

## Rules

- Do NOT ask the user any questions.
- Design must be implementable directly from this document — no ambiguity.
- Follow Clean Architecture: clear layer separation, dependencies point inward.
- Each module has a single responsibility with small, clear interfaces.
- Prefer composition over inheritance.
- Every design decision must map back to a use case or requirement.

## Output

Write the result to `.oneword/design.md`:

```markdown
# Detailed Design: [Project Name]

## Architecture Overview
[Describe the high-level architecture: layers, data flow, key patterns]

## Directory Structure
```
[Exact file tree the implementation should produce, down to file level]
```

## Data Models

### [Model Name]
| Field | Type | Constraints | Description |
|-------|------|-------------|-------------|
| id | integer | PK, auto-increment | Unique identifier |
| ... | ... | ... | ... |

[Relationships between models, if any]

## API Endpoints

### [Resource Name]
| Method | Path | Request Body | Response | Description |
|--------|------|-------------|----------|-------------|
| GET | /api/items | - | { items: Item[] } | List all items |
| POST | /api/items | { name, description } | { item: Item } | Create item |
...

## Frontend Pages & Components

### Pages
| Page | Route | Components Used | Description |
|------|-------|----------------|-------------|
| Home | / | ItemList, AddItemForm | Main page showing items |
...

### Component Tree
```
App
├── Header
├── Router
│   ├── HomePage
│   │   ├── ItemList
│   │   │   └── ItemCard
│   │   └── AddItemForm
│   └── ...
└── Footer
```

## Design Patterns Applied

| Pattern | Where | Why |
|---------|-------|-----|
| Repository | Data access layer | Abstracts database, enables testability |
| [Pattern] | [Module] | [Reason] |

## Implementation Order
1. [Module to implement first — usually data models]
2. [Module to implement second]
...
[Order should enable TDD: each module can be tested as it's built]
```