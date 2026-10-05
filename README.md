# AMBA-3 APB UVM Verification

> **Reconstructed portfolio project:** This repository is a clean reference reconstruction based on the AMBA-3 APB/UVM verification work described in my project experience. The original project files are not currently available, so this repository does not claim to be the exact historical RTL/testbench. It documents and demonstrates the verification methodology and UVM concepts used in the project.

## Overview

Functional verification of an **AMBA-3 APB (Advanced Peripheral Bus)** design using **SystemVerilog and UVM**.

### Verification objectives
- Develop a verification plan.
- Understand APB operating states and protocol signals.
- Verify APB read/write transfers.
- Develop directed and constrained-random tests.
- Exercise corner and error scenarios.
- Check behavior with a scoreboard/reference model.
- Collect functional coverage and simulator code coverage where supported.

## APB Transfer

```text
IDLE -> SETUP -> ACCESS -> IDLE
                  |
                  +-- PREADY=0 --> ACCESS
                  +-- PREADY=1 --> IDLE
```

During SETUP, `PSEL=1, PENABLE=0`. During ACCESS, `PSEL=1, PENABLE=1`; the transfer completes when `PREADY=1`.

## Main Signals

| Signal | Purpose |
|---|---|
| `PCLK` | APB clock |
| `PRESETn` | Active-low reset |
| `PADDR` | Address |
| `PSEL` | Peripheral select |
| `PENABLE` | Access-phase indicator |
| `PWRITE` | 1=write, 0=read |
| `PWDATA` | Write data |
| `PRDATA` | Read data |
| `PREADY` | Transfer completion |
| `PSLVERR` | Error response |

## UVM Architecture

```text
 UVM Test
    |
    v
 Sequences -> Sequencer -> Driver -> APB DUT
                                      |
                                      v
                                    Monitor
                                    /     \
                                   v       v
                              Scoreboard Coverage
```

## UVM Components

- **Transaction:** address, direction, write data, read data and error response.
- **Sequence:** directed and constrained-random stimulus.
- **Driver:** converts transactions into APB SETUP/ACCESS signaling.
- **Monitor:** passively reconstructs completed APB transfers.
- **Scoreboard:** compares read data against a reference memory model.
- **Coverage:** tracks operation type, address ranges, data patterns, errors and crosses.
- **Environment/Agent:** connects reusable UVM components.

## Verification Scenarios

### Basic
- Reset
- Single write
- Single read
- Write followed by read
- Multiple sequential transfers

### Corner cases
- Minimum/maximum valid addresses
- Repeated address access
- Back-to-back transfers
- Zero data
- All-ones data
- Alternating `0xAAAAAAAA` / `0x55555555`

### Error case
The reconstructed reference DUT demonstrates an invalid-address `PSLVERR` response. This behavior should not be presented as the exact historical DUT behavior unless the original specification is recovered.

## Constrained-Random Verification

Transactions randomize legal addresses, read/write operation and write data. This provides broader stimulus than a small directed test set while keeping transactions protocol-valid.

## Coverage Strategy

Functional coverage includes read/write, address ranges, important data patterns, error response and operation/address cross coverage. **No coverage percentage is fabricated**; actual percentages should be reported only after running the environment with a supported simulator.

## Tools

- SystemVerilog
- UVM
- Xilinx Vivado / XSim
- RTL simulation
- Functional coverage
- Code coverage where supported

## Repository Structure

```text
AMBA3-APB-UVM-Verification/
├── README.md
├── .gitignore
├── rtl/apb3_slave.sv
├── tb/
│   ├── interface/apb_if.sv
│   ├── sequence/apb_pkg.sv
│   ├── sequence/apb_transaction.sv
│   ├── sequence/apb_base_sequence.sv
│   ├── sequence/apb_write_sequence.sv
│   ├── sequence/apb_read_sequence.sv
│   ├── sequence/apb_random_sequence.sv
│   ├── sequence/apb_reset_sequence.sv
│   ├── driver/apb_driver.sv
│   ├── monitor/apb_monitor.sv
│   ├── agent/apb_agent.sv
│   ├── scoreboard/apb_scoreboard.sv
│   ├── coverage/apb_coverage.sv
│   ├── env/apb_env.sv
│   └── test/{apb_base_test.sv,apb_smoke_test.sv}
├── sim/{tb_top.sv,filelist.f}
└── docs/{verification_plan.md,apb_protocol.md,test_scenarios.md,INTERVIEW_NOTES.md}
```

## How to Run

Use a SystemVerilog/UVM-capable simulator. UVM invocation differs between Vivado/XSim releases and other simulators. Add the files in `sim/filelist.f`, compile with UVM enabled, and run `apb_smoke_test`. Inspect UVM logs, scoreboard results and coverage.

## Simulation Status:
Behavioral simulation completed successfully in Xilinx Vivado 2023.1 with 0 UVM errors, 0 warnings, and 0 fatal errors.

## Interview Summary

> I worked on verification of an AMBA-3 APB-based design using UVM. I developed the verification plan by studying APB operating states and protocol signals, created tests for normal, corner and error scenarios, and used constrained-random stimulus, scoreboard checking and coverage to evaluate verification completeness.
