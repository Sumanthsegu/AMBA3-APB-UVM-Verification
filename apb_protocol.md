# AMBA-3 APB Protocol Notes

## Transfer phases

### IDLE
`PSEL=0`, `PENABLE=0`.

### SETUP
`PSEL=1`, `PENABLE=0`; address/control are presented.

### ACCESS
`PSEL=1`, `PENABLE=1`; transfer completes when `PREADY=1`.

## Read
`PWRITE=0`; slave returns data on `PRDATA`.

## Write
`PWRITE=1`; master supplies `PWDATA`.

## Error
`PSLVERR` indicates an error for a completed transfer when asserted.
