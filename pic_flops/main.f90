program main
   use pic_flop_recorder, only: flop_recorder_type
   use pic_types, only: dp, int64
   use pic_output_helpers, only: print_asterisk_row
   implicit none
   type(flop_recorder_type) :: my_flops
   real(dp), allocatable :: A(:, :), B(:, :), C(:, :)
   integer, parameter :: m = 512
   integer :: i, j, k

   allocate (A(m, m), B(m, m), C(m, m))
   A = 1.0_dp
   B = 2.0_dp
   C = 0.0_dp

   call print_asterisk_row(50)
   print *, "BEGIN FLOP RECORDER EXAMPLES"
   call my_flops%add(int(2*m*m*m, int64))
   do i = 1, m
      do j = 1, m
         do k = 1, m
            C(i, j) = C(i, j) + A(i, k)*B(k, j)
         end do
      end do
   end do

   print *, C(1, 1)

   print *, "FLOPS in DGEMM ARE", my_flops%get()

   deallocate (A, B, C)

end program main
