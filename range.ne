# This is the Nearley Parser Generator Language of the grammar used by the npm semver package */
# https://www.npmjs.com/package/semver 
# https://nearley.js.org/

valid_range -> range | range space:+  "||" space:+ valid_range
range -> hyphenated_ranges | list_of_ranges
hyphenated_ranges -> plain_xrange space:+  "-" space:+ plain_xrange
list_of_ranges -> simple_range | simple_range space:+ list_of_ranges
simple_range -> xrange | plain_xrange | tilde_range | caret_range
xrange -> gtlt space:* plain_xrange
gtlt -> "<" |  "<=" |  "=" |  ">=" |  ">"
prefix -> "v" |  "=" |  "v="
plain_xrange -> prefix:? xrange_identifier ( "." xrange_identifier ):? ( "." xrange_identifier ):? qualifier:?
xrange_identifier -> "x" |  "X" |  "*" | numeric_identifier
tilde_range -> "~"  ">":? plain_xrange
caret_range -> "^" plain_xrange
comparator -> gtlt space:* full_version
full_version -> "v":? valid_semver
space -> " " |  "\n" |  "\r" |  "\t"

# The following is equivalent to the semver grammar at https://semver.org 

valid_semver -> version_core | version_core  "-" pre_release | version_core  "+" build | version_core  "-" pre_release  "+" build
version_core -> major  "." minor  "." patch
major -> numeric_identifier
minor -> numeric_identifier
patch -> numeric_identifier
qualifier -> "-" pre_release |  "+" build |  "-" pre_release  "+" build
pre_release -> dot_separated_pre_release_identifiers
dot_separated_pre_release_identifiers -> pre_release_identifier | pre_release_identifier  "." dot_separated_pre_release_identifiers
build -> dot_separated_build_identifiers
dot_separated_build_identifiers -> build_identifier | build_identifier  "." dot_separated_build_identifiers
pre_release_identifier -> alphanumeric_identifier | numeric_identifier
build_identifier -> alphanumeric_identifier | digits
alphanumeric_identifier -> non_digit | non_digit identifier_characters | identifier_characters non_digit | identifier_characters non_digit identifier_characters
numeric_identifier -> "0" | positive_digit | positive_digit digits
identifier_characters -> identifier_character:+
identifier_character -> digit | non_digit
non_digit -> letter |  "-"
digits -> digit:+
digit -> "0" | positive_digit
positive_digit -> [1-9]
letter -> [A-Z] |  [a-z]