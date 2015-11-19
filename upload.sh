openocd -f board/nordic_nrf51822_mkit.cfg -c "init; reset init; halt; nrf51 mass_erase; program $1; reset; exit"

