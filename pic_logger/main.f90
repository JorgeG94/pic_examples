program main
   use pic_logger, only: logger => global_logger, verbose_level, info_level
   use pic_io, only: print_asterisk_row
   implicit none

   call print_asterisk_row(50)

   print *, "BEGIN LOGGER TESTS"

   call logger%info("HIII")
   call logger%verbose("WON'T BE PRINTED")
   call logger%configure(verbose_level)
   call logger%verbose("VERBOSE ACTIVATED")
   call logger%warning("WARNING")

   call print_asterisk_row(50)
end program main
