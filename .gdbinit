set print pretty on
set print object on
set print static-members on
set print vtbl on
set print demangle on
set demangle-style gnu-v3

# https://sourceware.org/gdb/wiki/STLSupport
python
import sys
sys.path.insert(0, '/home/cut/Source/python')
from libstdcxx.v6.printers import register_libstdcxx_printers
register_libstdcxx_printers (None)
end
