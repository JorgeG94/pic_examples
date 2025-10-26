program main
   use pic_flop_rate, only: flop_rate_type
   use pic_types, only: dp, int64
   use pic_output_helpers, only: print_asterisk_row
   implicit none
   type(flop_rate_type) :: my_flops
   real(dp), allocatable :: A(:, :), B(:, :), C(:, :)
   integer, parameter :: m = 512
   integer :: i, j, k

   allocate (A(m, m), B(m, m), C(m, m))
   A = 1.0_dp
   B = 2.0_dp
   C = 0.0_dp

   call print_asterisk_row(50)
   print *, "BEGIN FLOP RATE RECORDER EXAMPLES"
   call my_flops%add_flops(int(2*m*m*m, int64))
   call my_flops%start_time()
   do i = 1, m
      do j = 1, m
         do k = 1, m
            C(i, j) = C(i, j) + A(i, k)*B(k, j)
         end do
      end do
   end do
   call my_flops%stop_time()

   call my_flops%report()

   deallocate (A, B, C)
   call print_asterisk_row(50)

end program main
