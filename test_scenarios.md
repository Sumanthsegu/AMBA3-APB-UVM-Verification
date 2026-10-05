# APB Test Scenarios

## Directed
1. Reset
2. Single write
3. Readback
4. Multiple sequential transfers
5. Zero data
6. All-ones data
7. `0xAAAAAAAA`
8. `0x55555555`

## Constrained-random
Randomize address, read/write operation and write data within legal constraints.

## Corner cases
- Minimum/maximum valid address
- Repeated address access
- Back-to-back transfers
- Reset before traffic

## Error
Exercise an invalid address in the reconstructed reference DUT and check `PSLVERR`.
