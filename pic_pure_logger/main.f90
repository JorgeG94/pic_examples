program main
   use pic_pure_logger, only: log_buffer_type, &
      pure_info, pure_debug, pure_warning, flush_log_buffer
   use pic_logger, only: logger => global_logger, debug_level
   use pic_types, only: default_int, dp
   use pic_io, only: print_asterisk_row
   implicit none
   type(log_buffer_type) :: log_buf
   real(dp) :: result

   call print_asterisk_row(50)
   print *, "BEGIN PURE LOGGER EXAMPLES"

   ! Set logger to debug so we see everything
   call logger%configure(debug_level)

   ! Call a pure subroutine that logs internally
   call safe_divide(10.0_dp, 3.0_dp, result, log_buf)
   call flush_log_buffer(logger, log_buf)
   print *, "10 / 3 =", result

   call print_asterisk_row(50)

   ! Call with a problematic denominator
   call safe_divide(5.0_dp, 0.0_dp, result, log_buf)
   call flush_log_buffer(logger, log_buf)
   print *, "5 / 0 =", result

   call print_asterisk_row(50)

   ! Pure subroutine that does multiple logs
   call normalize_vector([1.0_dp, 0.0_dp, 0.0_dp], log_buf)
   call flush_log_buffer(logger, log_buf)

   call print_asterisk_row(50)

   call normalize_vector([0.0_dp, 0.0_dp, 0.0_dp], log_buf)
   call flush_log_buffer(logger, log_buf)

   call print_asterisk_row(50)

contains

   pure subroutine safe_divide(a, b, c, buf)
      !! A pure subroutine that uses the pure logger for diagnostics
      !! Note: pure functions require all args to be intent(in),
      !! so use a subroutine when you need intent(inout) for the buffer
      real(dp), intent(in) :: a, b
      real(dp), intent(out) :: c
      type(log_buffer_type), intent(inout) :: buf

      call pure_debug(buf, "Entering safe_divide", module="example", procedure="safe_divide")

      if (abs(b) < 1.0e-15_dp) then
         call pure_warning(buf, "Division by near-zero, returning 0", &
                           module="example", procedure="safe_divide")
         c = 0.0_dp
      else
         call pure_info(buf, "Division ok", module="example", procedure="safe_divide")
         c = a / b
      end if
   end subroutine safe_divide

   pure subroutine normalize_vector(vec, buf)
      !! A pure subroutine that normalizes a vector and logs what happens
      real(dp), intent(in) :: vec(:)
      type(log_buffer_type), intent(inout) :: buf
      real(dp) :: nrm

      call pure_info(buf, "Normalizing vector", module="example", procedure="normalize_vector")

      nrm = norm2(vec)

      if (nrm < 1.0e-15_dp) then
         call pure_warning(buf, "Zero-length vector, cannot normalize", &
                           module="example", procedure="normalize_vector")
         return
      end if

      call pure_debug(buf, "Normalization successful", module="example", procedure="normalize_vector")
   end subroutine normalize_vector

end program main
