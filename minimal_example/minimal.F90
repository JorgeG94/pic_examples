program main
   use pic, only: pic_print_banner
#ifndef __LFORTRAN__
   use pic_knowledge, only: get_knowledge
#endif
   implicit none

   call pic_print_banner
#ifndef __LFORTRAN__
   call get_knowledge
#endif
end program main
