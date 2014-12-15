use v6;

# Find our compiled library.
# It was installed along with this .pm6 file, so it should be somewhere in
# @*INC

class Bio::HTSLib;
use Bio::HTSLib::Library;

method install-library {
    return $HTSLIB;
}
    
