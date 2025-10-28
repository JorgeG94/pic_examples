program main
   use pic_timer, only: timer_type
   use pic_types, only: dp
   use pic_io, only: print_asterisk_row
   implicit none
   type(timer_type) :: my_timer
   real(dp), allocatable :: A(:, :), B(:, :), C(:, :)
   integer, parameter :: m = 512
   integer :: i, j, k

   allocate (A(m, m), B(m, m), C(m, m))

   A = 1.0_dp
   B = 2.0_dp
   C = 0.0_dp
   call print_asterisk_row(50)
   print *, "BEGIN TIMER TYPE EXAMPLES"
   call my_timer%start()
   do i = 1, m
      do j = 1, m
         do k = 1, m
            C(i, j) = C(i, j) + A(i, k)*B(k, j)
         end do
      end do
   end do
   call my_timer%stop()

   print *, "Dgemm time is ", my_timer%get_elapsed_time()
   call print_asterisk_row(50)

   deallocate (A, B, C)

end program main
