program main
   use pic_string_type, only: string_type, assignment(=), char
   implicit none
   type(string_type) :: my_string
   type(string_type), allocatable :: array_of_strings(:)

   allocate (array_of_strings(1))

   array_of_strings(1) = "HIII"

! lfortran does not print this
   print *, char(array_of_strings(1))

   my_string = "HELLO THERE"

   print *, char(my_string)

   deallocate (array_of_strings)

end program main
