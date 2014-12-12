use v6;
use NativeCall;
use Bio::HTSLib::Library;

# Find our compiled library.
# It was installed along with this .pm6 file, so it should be somewhere in
# @*INC

class Bio::HTSLib;
    
method install-library {
    return Bio::HTSLib::Library::library();
}
    
