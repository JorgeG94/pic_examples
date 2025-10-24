set(_lib "pic")
set(_pkg "pic")
set(_url "https://github.com/JorgeG94/pic")
# not used atm
set(_rev "v0.5.0")

include("${CMAKE_CURRENT_LIST_DIR}/sample_utils.cmake")

my_fetch_package("${_lib}" "${_url}" "${_rev}")

unset(_lib)
unset(_pkg)
unset(_url)
unset(_rev)
