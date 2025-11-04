program main
   use pic_types, only: int64
   use pic_array, only: pic_scramble_array, is_sorted
   use pic_sorting, only: sort, radix_sort, ord_sort
   use pic_timer, only: timer_type
   implicit none
   integer(int64), parameter :: n = 1000000
   integer(int64), allocatable :: array_int64(:)
   type(timer_type) :: my_timer

   allocate (array_int64(n))
   block
      integer(int64) :: i
      ! we initialize an array by just filling it with sequential numbers
      array_int64 = [(i, i=1, n, 1)]
      ! convenient scrambler, just for testing purposes
      call pic_scramble_array(array_int64)
   end block

   print *, "Is the array sorted? ", is_sorted(array_int64)

   ! begin sorting now
   print *, "Sorting the array..."
   call my_timer%start()
   call sort(array_int64)
   call my_timer%stop()
   print *, "sorting took ", my_timer%get_elapsed_time(), " seconds"
   print *, "Is the array sorted? ", is_sorted(array_int64)

   call pic_scramble_array(array_int64)
   print *, "Rescrmabled: Is the array sorted? ", is_sorted(array_int64)
   print *, "Sorting the array with ord algorithm..."
   call my_timer%start()
   call ord_sort(array_int64)
   call my_timer%stop()
   print *, "sorting took ", my_timer%get_elapsed_time(), " seconds"
   print *, "Is the array sorted? ", is_sorted(array_int64)

   call pic_scramble_array(array_int64)
   print *, "Rescrmabled: Is the array sorted? ", is_sorted(array_int64)
   print *, "Sorting the array with radix algorithm..."
   call my_timer%start()
   call radix_sort(array_int64)
   call my_timer%stop()
   print *, "sorting took ", my_timer%get_elapsed_time(), " seconds"
   print *, "Is the array sorted? ", is_sorted(array_int64)

   deallocate (array_int64)
end program main
