program main
   use pic_error, only: error_t, code_to_string, &
      SUCCESS, ERROR_IO, ERROR_PARSE, ERROR_VALIDATION
   use pic_types, only: default_int
   use pic_io, only: print_asterisk_row
   implicit none
   type(error_t) :: err
   real :: values(3)

   call print_asterisk_row(50)
   print *, "BEGIN ERROR TYPE EXAMPLES"

   ! -------------------------------------------------------
   ! Example 1: Basic error handling
   ! -------------------------------------------------------
   call print_asterisk_row(50)
   print *, "Example 1: Basic set / check / clear"

   call err%set(ERROR_IO, "could not open 'data.txt'")
   print *, "Has error? ", err%has_error()
   print *, "Code:      ", code_to_string(err%get_code())
   print *, "Message:   ", err%get_message()
   call err%clear()
   print *, "After clear, has error? ", err%has_error()

   ! -------------------------------------------------------
   ! Example 2: The is() check for category handling
   ! -------------------------------------------------------
   call print_asterisk_row(50)
   print *, "Example 2: Category checking with is()"

   call err%set(ERROR_VALIDATION, "temperature out of range")
   if (err%is(ERROR_VALIDATION)) then
      print *, "Caught a validation error, can handle gracefully"
   end if
   if (.not. err%is(ERROR_IO)) then
      print *, "It is NOT an IO error"
   end if
   call err%clear()

   ! -------------------------------------------------------
   ! Example 3: Stack trace with add_context
   ! -------------------------------------------------------
   call print_asterisk_row(50)
   print *, "Example 3: Propagating errors with stack trace"

   call read_config("missing.toml", values, err)
   if (err%has_error()) then
      call err%print_trace()
      call err%clear()
   end if

   ! -------------------------------------------------------
   ! Example 4: Error wrapping (Rust-style "caused by")
   ! -------------------------------------------------------
   call print_asterisk_row(50)
   print *, "Example 4: Error wrapping with cause chain"

   call load_simulation("bad_input.json", err)
   if (err%has_error()) then
      print *, "--- print_trace output ---"
      call err%print_trace()
      print *, ""
      print *, "--- get_full_trace output ---"
      print *, err%get_full_trace()
      call err%clear()
   end if

   ! -------------------------------------------------------
   ! Example 5: fatal() for unrecoverable errors
   ! -------------------------------------------------------
   call print_asterisk_row(50)
   print *, "Example 5: fatal() would stop the program"
   print *, "(Skipping actual call to err%fatal() so the example continues)"
   print *, "Usage: if (err%has_error()) call err%fatal()"

   call print_asterisk_row(50)
   print *, "All examples completed."

contains

   subroutine open_file(filename, unit_num, err)
      !! Simulates opening a file that does not exist
      character(len=*), intent(in) :: filename
      integer(default_int), intent(out) :: unit_num
      type(error_t), intent(inout) :: err

      unit_num = -1
      ! Simulate a failure
      call err%set(ERROR_IO, "file not found: "//trim(filename))
   end subroutine open_file

   subroutine read_config(filename, values, err)
      !! Reads a config file, propagating errors with context
      character(len=*), intent(in) :: filename
      real, intent(out) :: values(:)
      type(error_t), intent(inout) :: err
      integer(default_int) :: unit_num

      values = 0.0

      call open_file(filename, unit_num, err)
      if (err%has_error()) then
         call err%add_context("read_config")
         return
      end if
   end subroutine read_config

   subroutine parse_input(data, err)
      !! Simulates a parse failure
      character(len=*), intent(in) :: data
      type(error_t), intent(inout) :: err

      call err%set(ERROR_PARSE, "unexpected token at position 42 in '"//trim(data)//"'")
   end subroutine parse_input

   subroutine validate_params(err)
      !! Simulates a validation failure caused by a parse failure
      type(error_t), intent(inout) :: err

      call parse_input("{bad json}", err)
      if (err%has_error()) then
         call err%wrap(ERROR_VALIDATION, "input parameters are invalid")
         call err%add_context("validate_params")
         return
      end if
   end subroutine validate_params

   subroutine load_simulation(filename, err)
      !! Top-level routine that wraps everything
      character(len=*), intent(in) :: filename
      type(error_t), intent(inout) :: err

      call validate_params(err)
      if (err%has_error()) then
         call err%wrap(ERROR_IO, "failed to load simulation from '"//trim(filename)//"'")
         call err%add_context("load_simulation")
         return
      end if
   end subroutine load_simulation

end program main
