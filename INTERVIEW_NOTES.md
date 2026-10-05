# Interview Notes

**What is APB?** A simple, low-power, non-pipelined AMBA peripheral bus for low-bandwidth control/status accesses.

**Transfer phases?** SETUP followed by ACCESS. PSEL is asserted in SETUP; PENABLE is asserted in ACCESS; PREADY completes the transfer.

**Driver?** Converts sequence items into pin-level APB activity.

**Monitor?** Passively samples bus signals and reconstructs completed transactions.

**Scoreboard?** Compares observed behavior against expected behavior from a reference model.

**Constrained-random?** Generates varied legal stimulus to improve scenario exploration and corner-case detection.

**Functional vs code coverage?** Functional coverage measures planned scenarios; code coverage measures which RTL implementation structures were exercised.

**Project answer:** I worked on verification of an AMBA-3 APB-based design using UVM. I developed the verification plan by studying APB operating states and protocol signals, created tests for normal, corner and error scenarios, and used constrained-random stimulus, scoreboard checking and coverage to evaluate verification completeness.
