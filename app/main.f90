program main
   use sample, only: hello_there
   use second_sample, only: answer
   use pic, only: pic_print_banner
   implicit none

call pic_print_banner()

   call hello_there()

   call answer()

end program main
