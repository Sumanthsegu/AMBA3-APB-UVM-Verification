# APB Verification Plan

## Objective
Verify APB setup/access behavior, read/write functionality, reset, response signaling and selected corner/error scenarios.

## Test Categories
- Reset
- Single write/read
- Write-readback
- Sequential and back-to-back transfers
- Boundary addresses
- Data patterns
- Constrained-random traffic
- Error response

## Checking
A scoreboard maintains a reference memory model. Observed reads are compared with expected data.

## Coverage
Functional coverage targets operation type, address ranges, data patterns, error response and operation/address cross coverage. Code coverage is simulator-dependent.
