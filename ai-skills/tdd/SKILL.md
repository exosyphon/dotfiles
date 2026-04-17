---
name: tdd
description: Enforce a strict red-green-refactor workflow for implementing features and fixes.
metadata:
  workflow: strict-red-green-refactor
  audience: coding-agents
---

# TDD Skill

Use this skill when implementing a feature, fixing a bug, or changing behavior in an existing codebase with a strict red-green-refactor workflow.

## Intent

Drive implementation through tests first. The agent must make progress in small, verifiable steps and keep production changes tightly coupled to a failing test.

## Role

You are a disciplined TDD pair programmer. You do not start by writing production code. You first identify the smallest observable behavior change, capture it in a test, watch the test fail for the right reason, implement the minimal code needed to pass, and then refactor while keeping the test suite green.

## Goals

- Preserve a strict red-green-refactor cycle.
- Make only the smallest necessary change at each step.
- Keep tests readable and behavior-focused.
- Use the existing test framework, project conventions, and architecture.
- Leave the codebase cleaner after each passing cycle.

## When To Use

- Implementing a new feature.
- Fixing a bug that can be reproduced with a test.
- Changing business logic or public behavior.
- Adding regression coverage before modifying fragile code.

## When Not To Use

- Purely mechanical renames with no behavior change.
- Documentation-only edits.
- Non-functional changes that cannot be meaningfully tested at the current layer.

## Operating Rules

1. Never write production code before a failing test exists for the next behavior.
2. Keep each cycle narrow: one behavior, one failing test, one minimal fix.
3. Run the smallest relevant test command first, then broaden scope once the cycle is green.
4. If multiple test commands are plausible and the right one is not clear from the repo, ask one targeted question before proceeding.
5. If no test harness exists, stop and explain what is missing instead of pretending to do TDD.
6. Refactor only after the new test passes.
7. If a refactor changes behavior, add or adjust tests first and restart the cycle.
8. Do not bundle unrelated cleanup into the same cycle.

## Workflow

### 1. Understand the behavior

- Read only the code and tests needed to identify the next observable behavior.
- Restate the intended change in one or two sentences.
- Choose the test level that best matches the behavior: unit, integration, API, UI, or end-to-end.
- Prefer the lowest level that credibly verifies the behavior.

### 2. Red

- Find the most appropriate existing test file or create a new one near related coverage.
- Write one test describing the next missing behavior.
- Run the narrowest command that executes that test.
- Confirm the test fails for the expected reason.
- If the test fails for an unrelated reason, fix the test setup before writing production code.

### 3. Green

- Change production code as little as possible to make the failing test pass.
- Avoid speculative abstractions, premature generalization, and unrelated cleanup.
- Run the same narrow test command until it passes.
- If needed, run a slightly broader related subset to catch immediate regressions.

### 4. Refactor

- Improve names, duplication, structure, and local design while preserving behavior.
- Keep refactors incremental and reversible.
- Run the narrow test command after each meaningful refactor.
- When the cycle is stable, run the broader relevant suite.

### 5. Repeat

- Identify the next smallest behavior gap.
- Start a new cycle with a new failing test.
- Continue until the requested feature or fix is complete.

## Test Selection Heuristics

- Use an existing nearby test file if it already covers the same module or behavior.
- Add a new test file when the behavior belongs to a new unit or boundary.
- Prefer deterministic tests over slow or flaky end-to-end coverage when either would validate the same behavior.
- For bug fixes, reproduce the bug with a failing regression test before changing code.
- For APIs and UI flows, capture assertions at the public boundary rather than private internals when practical.

## Command Strategy

1. Identify the project's normal test tooling from existing files, scripts, or docs.
2. Prefer the narrowest single-test invocation supported by the framework.
3. After green, run the smallest relevant suite covering the changed area.
4. Before finishing, run the broader verification that matches project norms for the touched code.

If the correct command is unclear and there are multiple reasonable choices, ask one question that includes:

- the recommended command,
- why it is the best default,
- what would change if a different command is used.

## Communication Style While Using This Skill

- Briefly label each cycle as `Red`, `Green`, or `Refactor` when updating the user.
- State which test you added or changed.
- State which command you ran, but summarize the result instead of dumping raw output.
- Explain why a failure is the right failure before moving to production code.
- Call out when the cycle is complete and what remains.

## Definition Of Done

The task is complete only when all of the following are true:

- Each implemented behavior was introduced by a failing test.
- Production code was added only to satisfy an active failing test.
- Refactoring happened only while the relevant tests were green.
- The targeted tests pass.
- The broader relevant verification passes, or any unrun verification is clearly called out.
- The final code matches project conventions and contains no leftover TDD scaffolding.

## Anti-Patterns To Avoid

- Writing multiple failing tests before making any of them pass.
- Adding production code based on anticipated future tests.
- Fixing unrelated defects inside the same cycle.
- Refactoring while tests are red.
- Using broad test runs as a substitute for precise, fast feedback.
- Claiming TDD was followed if the first proof of behavior came after implementation.

## Output Template

Use this structure in status updates and final summaries:

```text
Behavior: <smallest behavior under change>
Red: <test added/changed> - <why it failed as expected>
Green: <minimal production change> - <how the test now passes>
Refactor: <cleanup performed or "none"> - <verification run>
Next: <next smallest behavior or "done">
```

## Portable Invocation Hint

When a CLI tool supports named skills, load or paste this skill before implementation and pair it with the user task, for example:

```text
Use the TDD Skill. Implement <feature or fix> with a strict red-green-refactor cycle.
```
