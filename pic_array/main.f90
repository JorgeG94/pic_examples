program main
   use pic_types, only: sp, default_int
   use pic_array, only: pic_copy, pic_fill, get_threading_mode, is_sorted, &
                        pic_print_array, pic_scramble_array, &
                        pic_sum, pic_transpose, set_threading_mode
   use pic_output_helpers, only: print_asterisk_row
   implicit none

   real(sp), allocatable :: a_1d(:), a_2d(:, :)
   integer(default_int), parameter :: m = 5120_default_int

! Please README.md for some info about the design choices.

   allocate (a_1d(m), a_2d(m, m))

   call print_asterisk_row(50)
   print *, "START ARRAY EXAMPLES"

   print *, "sum 1 d", pic_sum(a_1d)
   print *, "sum 2 d", pic_sum(a_2d)

! fill an array with a value
   call pic_fill(a_1d, 3.0_sp)
   call pic_fill(a_2d, 3.0_sp)

   print *, "sum 1 d", pic_sum(a_1d)
   print *, "sum 2 d", pic_sum(a_2d)

   block

      real(sp), allocatable :: copy_1d(:)

      allocate (copy_1d(m))

      print *, "sum before copy", pic_sum(copy_1d)
      call pic_copy(copy_1d, a_1d)
      print *, "sum after copy", pic_sum(copy_1d)

      deallocate (copy_1d)

   end block

   deallocate (a_1d, a_2d)

   call print_asterisk_row(50)

end program main
