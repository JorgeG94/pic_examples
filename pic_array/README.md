# Array operations with pic


The reason for `pic_array` to exist with its "threading" options
is because when I was writing some code to use GPUs using
OpenMP offloading, see my shallow water equation solver
which is just a simple but working example of a dam break
https://github.com/JorgeG94/pic-swe/tree/main
I quickly noticed that having array operations as in native
fortran, i.e. `a = 0.0_dp`, when a is an allocatable array of
a large size, for example `n = 1e6` - this would be very slow
since the compiler will try to parallelize it in a non
GPU fashion. It works well for small sizes but not great
for larger sizes.

Therefore, `pic_array` is able to use threading for very large
arrays. The idea is that those loops will run on the GPU
but as of now they are just threaded on the CPU.

For performance, the operations are blocked to provide
better memory access and whooosh performance.

## Future work for array operations

Development for this module is not finished yet. One of my
design choices for PIC is that it should allow for people
using a high degree of flexibility. The idea is to provide
non-derived type functionality that is interoperable with
other programming languages.

However, for extra power in native Fortran derived types that
build on the array functionality will be created. So that one
can do:

```fortran
type(pic_array_1d) :: 1d_array
type(pic_array_1d) :: 1d_array_copy

call 1d_array%fill(value)
call 1d_array_copy%copy_from(1d_array)

block
  real(dp) :: sum_of_elements
  sum_of_elements = 1d_array_copy%sum()
end block

```

Plus interoperability between ranks, of course. Such that one can do:

```fortran
type(pic_array_1d) :: 1d_array
type(pic_array_2d) :: 2d_array

1d_array = 2d_array%flatten()
```

If you've used Mathematica you're familiar with the "flatten" technique.

In reality, we could do some runtime polymorphism to make this quite powerful.
But this will be done step by step, testing for _portability_ across all
interesting compilers!
