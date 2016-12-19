<<<<<<< HEAD
#***********************************************************************
#
# Name:   open_data_csv.pm
#
# $Revision$
# $URL$
# $Date$
#
# Description:
#
#   This file contains routines that parse CSV files and check for
# a number of open data check points.
#
# Public functions:
#     Set_Open_Data_CSV_Language
#     Set_Open_Data_CSV_Debug
#     Set_Open_Data_CSV_Testcase_Data
#     Set_Open_Data_CSV_Test_Profile
#     Open_Data_CSV_Check_Data
#
# Terms and Conditions of Use
#
# Unless otherwise noted, this computer program source code
# is covered under Crown Copyright, Government of Canada, and is
# distributed under the MIT License.
#
# MIT License
#
# Copyright (c) 2011 Government of Canada
#
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included
# in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
# OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.
#
#***********************************************************************

package open_data_csv;

use strict;
use URI::URL;
use File::Basename;
use Text::CSV;

#***********************************************************************
#
# Export package globals
#
#***********************************************************************
BEGIN {
    use Exporter   ();
    use vars qw($VERSION @ISA @EXPORT);

    @ISA     = qw(Exporter);
    @EXPORT  = qw(Set_Open_Data_CSV_Language
                  Set_Open_Data_CSV_Debug
                  Set_Open_Data_CSV_Testcase_Data
                  Set_Open_Data_CSV_Test_Profile
                  Open_Data_CSV_Check_Data
                  );
    $VERSION = "1.0";
}

#***********************************************************************
#
# File Local variable declarations
#
#***********************************************************************

my ($debug) = 0;
my (%testcase_data, $results_list_addr);
my (@paths, $this_path, $program_dir, $program_name, $paths);
my (%open_data_profile_map, $current_open_data_profile, $current_url);

my ($max_error_message_string)= 2048;

#
# Status values
#
my ($check_fail)       = 1;

#
# String table for error strings.
#
my %string_table_en = (
    "Parse error in line",           "Parse error in line",
    "Inconsistent number of fields, found", "Inconsistent number of fields, found ",
    "expecting",                     "expecting",
    "No content in file",            "No content in file",
    "Missing header row terms",      "Missing header row terms",
    );

my %string_table_fr = (
    "Parse error in line",           "Parse error en ligne",
    "Inconsistent number of fields, found", "Num�ro incoh�rente des champs, a constat� ",
    "expecting",                     "expectant",
    "No content in file",            "Aucun contenu dans fichier",
    "Missing header row terms",      "Manquant termes de lignes d'en-t�te",
    );

#
# Default messages to English
#
my ($string_table) = \%string_table_en;

#***********************************************************************
#
# Name: Set_Open_Data_CSV_Debug
#
# Parameters: this_debug - debug flag
#
# Description:
#
#   This function sets the package global debug flag.
#
#***********************************************************************
sub Set_Open_Data_CSV_Debug {
    my ($this_debug) = @_;

    #
    # Copy debug value to global variable
    #
    $debug = $this_debug;
}

#**********************************************************************
#
# Name: Set_Open_Data_CSV_Language
#
# Parameters: language
#
# Description:
#
#   This function sets the language of error messages generated
# by this module.
#
#***********************************************************************
sub Set_Open_Data_CSV_Language {
    my ($language) = @_;

    #
    # Check for French language
    #
    if ( $language =~ /^fr/i ) {
        $string_table = \%string_table_fr;
    }
    else {
        #
        # Default language is English
        #
        $string_table = \%string_table_en;
    }
}

#**********************************************************************
#
# Name: String_Value
#
# Parameters: key - string table key
#
# Description:
#
#   This function returns the value in the string table for the
# specified key.  If there is no entry in the table an error string
# is returned.
#
#**********************************************************************
sub String_Value {
    my ($key) = @_;

    #
    # Do we have a string table entry for this key ?
    #
    if ( defined($$string_table{$key}) ) {
        #
        # return value
        #
        return ($$string_table{$key});
    }
    else {
        #
        # No string table entry, either we are missing a string or
        # we have a typo in the key name.
        #
        return ("*** No string for $key ***");
    }
}

#***********************************************************************
#
# Name: Set_Open_Data_CSV_Testcase_Data
#
# Parameters: testcase - testcase identifier
#             data - string of data
#
# Description:
#
#   This function copies the passed data into a hash table
# for the specified testcase identifier.
#
#***********************************************************************
sub Set_Open_Data_CSV_Testcase_Data {
    my ($testcase, $data) = @_;

    #
    # Copy the data into the table
    #
    $testcase_data{$testcase} = $data;
}

#***********************************************************************
#
# Name: Set_Open_Data_CSV_Test_Profile
#
# Parameters: profile - CSV check test profile
#             testcase_names - hash table of testcase name
#
# Description:
#
#   This function copies the passed table to unit global variables.
# The hash table is indexed by CSV testcase name.
#
#***********************************************************************
sub Set_Open_Data_CSV_Test_Profile {
    my ($profile, $testcase_names) = @_;

    my (%local_testcase_names);

    #
    # Make a local copy of the hash table as we will be storing the address
    # of the hash.
    #
    print "Set_Open_Data_CSV_Test_Profile, profile = $profile\n" if $debug;
    %local_testcase_names = %$testcase_names;
    $open_data_profile_map{$profile} = \%local_testcase_names;
}

#***********************************************************************
#
# Name: Initialize_Test_Results
#
# Parameters: profile - CSV check test profile
#             local_results_list_addr - address of results list.
#
# Description:
#
#   This function initializes the test case results table.
#
#***********************************************************************
sub Initialize_Test_Results {
    my ($profile, $local_results_list_addr) = @_;

    #
    # Set current hash tables
    #
    $current_open_data_profile = $open_data_profile_map{$profile};
    $results_list_addr = $local_results_list_addr;
}

#***********************************************************************
#
# Name: Print_Error
#
# Parameters: line - line number
#             column - column number
#             text - text from tag
#             error_string - error string
#
# Description:
#
#   This function prints error messages if debugging is enabled..
#
#***********************************************************************
sub Print_Error {
    my ( $line, $column, $text, $error_string ) = @_;

    #
    # Print error message if we are in debug mode
    #
    if ( $debug ) {
        print "$error_string\n";
    }
}

#***********************************************************************
#
# Name: Record_Result
#
# Parameters: testcase - testcase identifier
#             line - line number
#             column - column number
#             text - text from tag
#             error_string - error string
#
# Description:
#
#   This function records the testcase result.
#
#***********************************************************************
sub Record_Result {
    my ( $testcase, $line, $column,, $text, $error_string ) = @_;

    my ($result_object);

    #
    # Is this testcase included in the profile
    #
    if ( defined($testcase) && defined($$current_open_data_profile{$testcase}) ) {
        #
        # Create result object and save details
        #
        $result_object = tqa_result_object->new($testcase, $check_fail,
                                                Open_Data_Testcase_Description($testcase),
                                                $line, $column, $text,
                                                $error_string, $current_url);
        push (@$results_list_addr, $result_object);

        #
        # Print error string to stdout
        #
        Print_Error($line, $column, $text, "$testcase : $error_string");
    }
}

#***********************************************************************
#
# Name: Check_First_Data_Row
#
# Parameters: dictionary - address of a hash table for data dictionary
#             fields - list of field values
#
# Description:
#
#   This function checks the fields from the first row of SV file.
# It checks to see if the values match the terms found in the data
# dictionary.  If there is a match on 25% of the fields, a check is
# made to ensure all fields match data dictionary terms.
#
#***********************************************************************
sub Check_First_Data_Row {
    my ($dictionary, @fields) = @_;

    my ($count, $term, $field, @unmatched_fields);
    
    #
    # Do we have any dictionary terms ?
    #
    if ( keys(%$dictionary) == 0 ) {
        print "No terms to check for first row of CSV file\n" if $debug;
        return();
    }
    
    #
    # Count the number of terms found in the fields
    #
    print "Check for terms in first row of CSV file\n" if $debug;
    $count = 0;
    #
    # Check each field for a matching term
    #
    foreach $field (@fields) {
        if ( defined($$dictionary{$field}) ) {
            print "Found term/field match for $term\n" if $debug;
            $count++;
        }
        else {
            #
            # An unmatched field, save it for possible use later
            #
            push (@unmatched_fields, $field);
        }
    }
    
    #
    # Did we find a matching term for each field ?
    #
    if ( $count == @fields ) {
        print "All fields match a term\n" if $debug;
        return();
    }
    #
    # Did we match no terms, we may not have a heading row in this
    # CSV file
    #
    elsif ( $count == 0 ) {
        print "Fields do not match any terms, assume no heading row\n" if $debug;
        return();
    }
    #
    # Didn't we get a match on atleast 25% of the fields ? If so we expect
    # all the fields to match.
    #
    elsif ( $count >= (@fields / 4) ) {
        print "Found atleast 25% match on fields and terms\n" if $debug;
        Record_Result("OD_3", 1, 0, "",
                      String_Value("Missing header row terms") .
                      " \"" . join(", ", @unmatched_fields) . "\"");
    }
    else {
        #
        # Found a matching term for all fields
        #
        print "Found a matching term for all fields\n" if $debug;
    }
}

#***********************************************************************
#
# Name: Open_Data_CSV_Check_Data
#
# Parameters: this_url - a URL
#             profile - testcase profile
#             content - CSV content
#             dictionary - address of a hash table for data dictionary
#
# Description:
#
#   This function runs a number of open data checks on CSV data file content.
#
#***********************************************************************
sub Open_Data_CSV_Check_Data {
    my ($this_url, $profile, $content, $dictionary) = @_;

    my ($parser, $url, @tqa_results_list, $result_object, $testcase);
    my ($line, @fields, $line_no, $status, $found_fields, $field_count);
    my ($csv_file, $csv_file_name, $rows, $message);

    #
    # Do we have a valid profile ?
    #
    print "Open_Data_CSV_Check_Data: Checking URL $this_url, profile = $profile\n" if $debug;
    if ( ! defined($open_data_profile_map{$profile}) ) {
        print "Open_Data_CSV_Check_Data: Unknown CSV testcase profile passed $profile\n";
        return(@tqa_results_list);
    }

    #
    # Save URL in global variable
    #
    if ( $this_url =~ /^http/i ) {
        $current_url = $this_url;
    }
    else {
        #
        # Doesn't look like a URL.  Could be just a block of CSV
        # from the standalone validator which does not have a URL.
        #
        $current_url = "";
    }

    #
    # Initialize the test case pass/fail table.
    #
    Initialize_Test_Results($profile, \@tqa_results_list);

    #
    # Did we get any content ?
    #
    if ( length($content) == 0 ) {
        print "No content passed to Open_Data_CSV_Check_Data\n" if $debug;
        Record_Result("OD_3", -1, 0, "",
                      String_Value("No content in file"));
    }
    else {

        #
        # Remove BOM from UTF-8 content ($EF $BB $BF)
        #  Byte Order Mark - http://en.wikipedia.org/wiki/Byte_order_mark
        #
        $content =~ s/^\xEF\xBB\xBF//;

        #
        # Create a temporary file for the PDF content.
        #
        $csv_file_name = "csv_text$$.csv";
        unlink($csv_file_name);
        print "Create temporary CSV file $csv_file_name\n" if $debug;
        open($csv_file, ">$csv_file_name") ||
            die "Open_Data_CSV_Check_Data: Failed to open $csv_file_name for writing\n";
        binmode $csv_file;
        print $csv_file $content;
        close($csv_file);
        open($csv_file, "$csv_file_name") ||
            die "Open_Data_CSV_Check_Data: Failed to open $csv_file_name for reading\n";

        #
        # Create a document parser
        #
        $parser = Text::CSV->new ({ binary => 1, eol => $/ });

        #
        # Parse each line/record of the content
        #
        $line_no = 0;
        while ( $rows = $parser->getline($csv_file) ) {
            #
            # Increment record/line number
            #
            $line_no++;

            #
            # Get the set of fields from the parsed line/record
            #
            @fields = @$rows;

            #
            # Is this the first row ? If so check for a possible heading
            # row (i.e. the field values are the dictionary terms)
            #
            if ( $line_no == 1 ) {
                Check_First_Data_Row($dictionary, @fields);
            }

            #
            # Do we have the number of expected fields ?
            #
            if ( ! defined($field_count) ) {
                $field_count = @fields;
                print "Expected fields count = $field_count\n" if $debug;
            }
            #
            # Does the field count match the expected number of fields ?
            #
            elsif ( $field_count != @fields ) {
                $found_fields = @fields;
                Record_Result("OD_3", $line_no, 0, "$line",
                      String_Value("Inconsistent number of fields, found") .
                       " $found_fields " . String_Value("expecting") .
                       " $field_count");
            }
        }

        #
        # Did we get to the end of file or did we encounter a parsing error
        #
        if ( ! $parser->eof() ) {
            $line = $parser->error_input();
            $message = $parser->error_diag();
            print "CSV file error at line $line_no, line = \"$line\"\n" if $debug;
            print "parser->error_diag = \"$message\"\n" if $debug;
            Record_Result("OD_3", $line_no, 0, $line,
                          String_Value("Parse error in line"));
        }
        close($csv_file);
        unlink($csv_file_name);

        #
        # Did we find any rows in the CSV content ?
        #
        if ( $line_no == 0 ) {
            Record_Result("OD_3", -1, 0, "",
                          String_Value("No content in file"));
        }
    }

    #
    # Print testcase information
    #
    if ( $debug ) {
        print "Open_Data_CSV_Check_Data results\n";
        foreach $result_object (@tqa_results_list) {
            print "Testcase: " . $result_object->testcase;
            print "  message  = " . $result_object->message . "\n";
        }
    }

    #
    # Return list of results
    #
    return(@tqa_results_list);
}

#***********************************************************************
#
# Name: Import_Packages
#
# Parameters: none
#
# Description:
#
#   This function imports any required packages that cannot
# be handled via use statements.
#
#***********************************************************************
sub Import_Packages {

    my ($package);
    my (@package_list) = ("tqa_result_object", "open_data_testcases");

    #
    # Import packages, we don't use a 'use' statement as these packages
    # may not be in the INC path.
    #
    foreach $package (@package_list) {
        #
        # Import the package routines.
        #
        if ( ! defined($INC{$package}) ) {
            require "$package.pm";
        }
        $package->import();
    }
}

#***********************************************************************
#
# Mainline
#
#***********************************************************************

#
# Get our program directory, where we find supporting files
#
$program_dir  = dirname($0);
$program_name = basename($0);

#
# If directory is '.', search the PATH to see where we were found
#
if ( $program_dir eq "." ) {
    $paths = $ENV{"PATH"};
    @paths = split( /:/, $paths );

    #
    # Loop through path until we find ourselves
    #
    foreach $this_path (@paths) {
        if ( -x "$this_path/$program_name" ) {
            $program_dir = $this_path;
            last;
        }
    }
}

#
# Import required packages
#
Import_Packages;

#
# Return true to indicate we loaded successfully
#
return 1;

=======
#***********************************************************************
#
# Name:   open_data_csv.pm
#
# $Revision: 7632 $
# $URL: svn://10.36.21.45/trunk/Web_Checks/Open_Data/Tools/open_data_csv.pm $
# $Date: 2016-07-22 03:05:47 -0400 (Fri, 22 Jul 2016) $
#
# Description:
#
#   This file contains routines that parse CSV files and check for
# a number of open data check points.
#
# Public functions:
#     Set_Open_Data_CSV_Language
#     Set_Open_Data_CSV_Debug
#     Set_Open_Data_CSV_Testcase_Data
#     Set_Open_Data_CSV_Test_Profile
#     Open_Data_CSV_Check_Data
#     Open_Data_CSV_Check_Get_Row_Count
#     Open_Data_CSV_Check_Get_Column_Count
#     Open_Data_CSV_Check_Get_Headings_List
#
# Terms and Conditions of Use
#
# Unless otherwise noted, this computer program source code
# is covered under Crown Copyright, Government of Canada, and is
# distributed under the MIT License.
#
# MIT License
#
# Copyright (c) 2011 Government of Canada
#
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included
# in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
# OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.
#
#***********************************************************************

package open_data_csv;

use strict;
use URI::URL;
use File::Basename;
use IO::Handle;
use File::Temp qw/ tempfile tempdir /;
use HTML::Entities;
use Digest::MD5 qw(md5_hex);
use Encode;

#***********************************************************************
#
# Export package globals
#
#***********************************************************************
BEGIN {
    use Exporter   ();
    use vars qw($VERSION @ISA @EXPORT);

    @ISA     = qw(Exporter);
    @EXPORT  = qw(Set_Open_Data_CSV_Language
                  Set_Open_Data_CSV_Debug
                  Set_Open_Data_CSV_Testcase_Data
                  Set_Open_Data_CSV_Test_Profile
                  Open_Data_CSV_Check_Data
                  Open_Data_CSV_Check_Get_Row_Count
                  Open_Data_CSV_Check_Get_Column_Count
                  Open_Data_CSV_Check_Get_Headings_List
                  );
    $VERSION = "1.0";
}

#***********************************************************************
#
# File Local variable declarations
#
#***********************************************************************

my ($debug) = 0;
my (%testcase_data, $results_list_addr, $last_csv_row_count);
my (@paths, $this_path, $program_dir, $program_name, $paths);
my (%open_data_profile_map, $current_open_data_profile, $current_url);
my ($csv_validator, $last_csv_headings_list, $last_csv_column_count);

my ($max_error_message_string)= 2048;
my ($runtime_error_reported) = 0;

#
# Status values
#
my ($check_fail)       = 1;

#
# String table for error strings.
#
my %string_table_en = (
    "and",                           "and",
    "Column",                        "Column",
    "csv-validator failed",          "csv-validator failed",
    "Data pattern",                  "Data pattern",
    "Duplicate column header",       "Duplicate column header",
    "Duplicate content in columns",  "Duplicate content in columns",
    "Duplicate row content, first instance at", "Duplicate row content, first instance at row",
    "expecting",                     "expecting",
    "failed for value",              "failed for value",
    "Found at",                      "Found at",
    "Inconsistent number of fields, found", "Inconsistent number of fields, found ",
    "Missing header row",            "Missing header row",
    "Missing header row terms",      "Missing header row terms",
    "Missing UTF-8 BOM",             "Missing UTF-8 BOM",
    "No content in file",            "No content in file",
    "No content in row",             "No content in row",
    "Parse error in line",           "Parse error in line",
    "Runtime Error",                 "Runtime Error",
    );

my %string_table_fr = (
    "and",                           "et",
    "Column",                        "Colonne",
    "csv-validator failed",          "csv-validator a �chou�",
    "Data pattern",                  "Mod�le de donn�es",
    "Duplicate column header",       "Duplicate t�te de colonne",
    "Duplicate content in columns",  "Dupliquer le contenu dans les colonnes",
    "Duplicate row content, first instance at", "Dupliquer le contenu en ligne, premi�re instance � ligne",
    "expecting",                     "expectant",
    "failed for value",              "a �chou� pour la valeur",
    "Found at",                      "Trouv� �",
    "Inconsistent number of fields, found", "Num�ro incoh�rente des champs, a constat� ",
    "Missing header row",            "Manquant lignes d'en-t�te",
    "Missing header row terms",      "Manquant termes de lignes d'en-t�te",
    "Missing UTF-8 BOM",             "Manquant UTF-8 BOM",
    "No content in file",            "Aucun contenu dans fichier",
    "No content in row",             "Aucun contenu dans ligne",
    "Parse error in line",           "Parse error en ligne",
    "Runtime Error",                 "Erreur D'Ex�cution",
    );

#
# Default messages to English
#
my ($string_table) = \%string_table_en;

#***********************************************************************
#
# Name: Set_Open_Data_CSV_Debug
#
# Parameters: this_debug - debug flag
#
# Description:
#
#   This function sets the package global debug flag.
#
#***********************************************************************
sub Set_Open_Data_CSV_Debug {
    my ($this_debug) = @_;

    #
    # Copy debug value to global variable
    #
    $debug = $this_debug;
    
    #
    # Set debug flag in supporting modules
    #
    CSV_Parser_Debug($debug);
}

#**********************************************************************
#
# Name: Set_Open_Data_CSV_Language
#
# Parameters: language
#
# Description:
#
#   This function sets the language of error messages generated
# by this module.
#
#***********************************************************************
sub Set_Open_Data_CSV_Language {
    my ($language) = @_;

    #
    # Check for French language
    #
    if ( $language =~ /^fr/i ) {
        $string_table = \%string_table_fr;
    }
    else {
        #
        # Default language is English
        #
        $string_table = \%string_table_en;
    }
}

#**********************************************************************
#
# Name: String_Value
#
# Parameters: key - string table key
#
# Description:
#
#   This function returns the value in the string table for the
# specified key.  If there is no entry in the table an error string
# is returned.
#
#**********************************************************************
sub String_Value {
    my ($key) = @_;

    #
    # Do we have a string table entry for this key ?
    #
    if ( defined($$string_table{$key}) ) {
        #
        # return value
        #
        return ($$string_table{$key});
    }
    else {
        #
        # No string table entry, either we are missing a string or
        # we have a typo in the key name.
        #
        return ("*** No string for $key ***");
    }
}

#***********************************************************************
#
# Name: Set_Open_Data_CSV_Testcase_Data
#
# Parameters: testcase - testcase identifier
#             data - string of data
#
# Description:
#
#   This function copies the passed data into a hash table
# for the specified testcase identifier.
#
#***********************************************************************
sub Set_Open_Data_CSV_Testcase_Data {
    my ($testcase, $data) = @_;

    #
    # Copy the data into the table
    #
    $testcase_data{$testcase} = $data;
}

#***********************************************************************
#
# Name: Set_Open_Data_CSV_Test_Profile
#
# Parameters: profile - CSV check test profile
#             testcase_names - hash table of testcase name
#
# Description:
#
#   This function copies the passed table to unit global variables.
# The hash table is indexed by CSV testcase name.
#
#***********************************************************************
sub Set_Open_Data_CSV_Test_Profile {
    my ($profile, $testcase_names) = @_;

    my (%local_testcase_names);

    #
    # Make a local copy of the hash table as we will be storing the address
    # of the hash.
    #
    print "Set_Open_Data_CSV_Test_Profile, profile = $profile\n" if $debug;
    %local_testcase_names = %$testcase_names;
    $open_data_profile_map{$profile} = \%local_testcase_names;
}

#***********************************************************************
#
# Name: Initialize_Test_Results
#
# Parameters: profile - CSV check test profile
#             local_results_list_addr - address of results list.
#
# Description:
#
#   This function initializes the test case results table.
#
#***********************************************************************
sub Initialize_Test_Results {
    my ($profile, $local_results_list_addr) = @_;

    #
    # Set current hash tables
    #
    $current_open_data_profile = $open_data_profile_map{$profile};
    $results_list_addr = $local_results_list_addr;
    
    #
    # Initialize global variables
    #
    $last_csv_row_count = 0;
    $last_csv_column_count = 0;
}

#***********************************************************************
#
# Name: Print_Error
#
# Parameters: line - line number
#             column - column number
#             text - text from tag
#             error_string - error string
#
# Description:
#
#   This function prints error messages if debugging is enabled..
#
#***********************************************************************
sub Print_Error {
    my ( $line, $column, $text, $error_string ) = @_;

    #
    # Print error message if we are in debug mode
    #
    if ( $debug ) {
        print "$error_string\n";
    }
}

#***********************************************************************
#
# Name: Record_Result
#
# Parameters: testcase - testcase identifier
#             line - line number
#             column - column number
#             text - text from tag
#             error_string - error string
#
# Description:
#
#   This function records the testcase result.
#
#***********************************************************************
sub Record_Result {
    my ( $testcase, $line, $column,, $text, $error_string ) = @_;

    my ($result_object);

    #
    # Is this testcase included in the profile
    #
    if ( defined($testcase) && defined($$current_open_data_profile{$testcase}) ) {
        #
        # Create result object and save details
        #
        $result_object = tqa_result_object->new($testcase, $check_fail,
                                                Open_Data_Testcase_Description($testcase),
                                                $line, $column, $text,
                                                $error_string, $current_url);
        push (@$results_list_addr, $result_object);

        #
        # Print error string to stdout
        #
        Print_Error($line, $column, $text, "$testcase : $error_string");
    }
}

#***********************************************************************
#
# Name: Check_First_Data_Row
#
# Parameters: dictionary - address of a hash table for data dictionary
#             fields - list of field values
#
# Description:
#
#   This function checks the fields from the first row of SV file.
# It checks to see if the values match the terms found in the data
# dictionary.  If there is a match on 25% of the fields, a check is
# made to ensure all fields match data dictionary terms.
#
#***********************************************************************
sub Check_First_Data_Row {
    my ($dictionary, @fields) = @_;

    my ($count, $field, @unmatched_fields, %headers);
    my (@headings) = ();
    
    #
    # Do we have any dictionary terms ?
    #
    if ( keys(%$dictionary) == 0 ) {
        print "No terms to check for first row of CSV file\n" if $debug;
        return(@headings);
    }
    
    #
    # Count the number of terms found in the fields
    #
    print "Check for terms in first row of CSV file\n" if $debug;
    $count = 0;
    foreach $field (@fields) {
        #
        # Don't convert to lower case, terms are case sensitive
        #
        # Check to see if it matches a dictionary entry.
        #
        $field =~ s/^\s*//g;
        $field =~ s/\s*$//g;
        if ( defined($$dictionary{$field}) ) {
            print "Found term/field match for \"$field\"\n" if $debug;
            $count++;
        }
        else {
            #
            # An unmatched field, save it for possible use later
            #
            push (@unmatched_fields, "$field");
            print "No dictionary value for \"$field\"\n" if $debug;
        }
        
        #
        # Do we have a duplicate header ?
        #
        if ( defined($headers{$field}) ) {
            Record_Result("TP_PW_OD_CSV_1", 1, 0, "",
                          String_Value("Duplicate column header") .
                          " \"$field\". " .
                          String_Value("Found at" . " " .
                          $headers{$field} .
                          String_Value("and") . " $count"));
        }
        else {
            #
            # Save header name
            #
            $headers{$field} = $count;
        }
    }
    
    #
    # Did we find a matching term for each field ?
    #
    if ( $count == @fields ) {
        print "All fields match a term\n" if $debug;
        
        #
        # Create a list of dictionary objects for the headings
        #
        foreach $field (@fields) {
            push(@headings, $$dictionary{$field});
        }
    }
    #
    # Did we get a match on atleast 25% of the fields ? If so we expect
    # all the fields to match.
    #
    elsif ( $count >= (@fields / 4) ) {
        print "Found atleast 25% match on fields and terms\n" if $debug;
        Record_Result("TP_PW_OD_CSV_1", 1, 0, "",
                      String_Value("Missing header row terms") .
                      " \"" . join(", ", @unmatched_fields) . "\"");
    }
    else {
        #
        # Missing header row, found a match on fewer than 25% of fields
        #
        print "Found a match on fewer than 25% fields\n" if $debug;
        if ( $count == 0 ) {
            Record_Result("TP_PW_OD_CSV_1", 1, 0, "",
                          String_Value("Missing header row"));
        }
        else {
            Record_Result("TP_PW_OD_CSV_1", 1, 0, "",
                          String_Value("Missing header row terms") .
                          " \"" . join(", ", @unmatched_fields) . "\"");
        }
    }
    
    #
    # Return list of headings found
    #
    $last_csv_headings_list = join(",", @fields);
    return(@headings);
}

#***********************************************************************
#
# Name: Check_UTF8_BOM
#
# Parameters: tcsv_file - CSV file object
#
# Description:
#
#   This function reads the passed file object and checks to see
# if a UTF-8 BOM is present.  If one is, the current reading position
# is set to just after the BOM.  The avoids parsing errors with the
# file.
#
# UTF-8 BOM = $EF $BB $BF
# Byte Order Mark - http://en.wikipedia.org/wiki/Byte_order_mark
#
#***********************************************************************
sub Check_UTF8_BOM {
    my ($csv_file) = @_;
    
    my ($line, $char, $have_bom);
    
    #
    # Get a line of content from the file
    #
    print "Check_UTF8_BOM\n" if $debug;
    $line = $csv_file->getline();

    #
    # Check first character of line for character 65279 (xFEFF)
    #
    print "line = \"$line\"\n" if $debug;
    $char = substr($line, 0, 1);
    if ( ord($char) == 65279 ) {
        #
        # Set reading position at character 3
        #
        print "Skip over BOM xFEFF\n" if $debug;
        seek($csv_file, 3, 0);
        $line = $csv_file->getline();
        print "line = \"$line\"\n" if $debug;
        seek($csv_file, 3, 0);
        $have_bom = 1;
    }
    elsif ( $line =~ s/^\xEF\xBB\xBF// ) {
        #
        # Set reading position at character 3
        #
        print "Skip over BOM xFEBBBF\n" if $debug;
        seek($csv_file, 3, 0);
        $line = $csv_file->getline();
        print "line = \"$line\"\n" if $debug;
        seek($csv_file, 3, 0);
        $have_bom = 1;
    }
    else {
        #
        # Reposition to the beginning of the file
        #
        print "Reset reading position to beginning of the file\n" if $debug;
        seek($csv_file, 0, 0);
        $have_bom = 0;
    }
    
    #
    # Are we missing the BOM ?
    #
    if ( ! $have_bom ) {
        Record_Result("TP_PW_OD_BOM", 1, 0, $line,
                      String_Value("Missing UTF-8 BOM"));
    }
    
    #
    # Return BOM flag
    #
    return($have_bom);
}

#***********************************************************************
#
# Name: Run_CSV_Validator
#
# Parameters: this_url - a URL
#             filename - CSV content file
#             have_bom - flag to indicate if the file contains a
#                        BOM - Byte Order Mark
#             headings - array of dictionary objects
#
# Description:
#
#   This function check the headings to see if there are any data
# conditions.  If there are some, it then runs the csv-validator
# tool to validate the contents of the CSV file.
#
#***********************************************************************
sub Run_CSV_Validator {
    my ($this_url, $filename, $have_bom, @headings) = @_;

    my ($heading, $condition, $csvs_fh, $csvs_filename, $output);
    my ($csv_filename, $csv_fh, $temp_csv_fh, $line);
    my ($have_condition) = 0;
    
    #
    # Do we have headings ?
    #
    if ( @headings > 0 ) {
        print "Run_CSV_Validator\n" if $debug;

        #
        # Construct a cvs-validator schema file with the
        # column conditions.
        #
        ($csvs_fh, $csvs_filename) = tempfile("WPSS_TOOL_XXXXXXXXXX",
                                              SUFFIX => '.csvs',
                                              TMPDIR => 1);
        if ( ! defined($csvs_fh) ) {
            print "Error: Failed to create temporary file in Run_CSV_Validator\n";
            print STDERR "Error: Failed to create temporary file in Run_CSV_Validator\n";
            return;
        }
        binmode $csvs_fh, ":utf8";
        print "CSV schema file = $csvs_filename\n" if $debug;
        
        #
        # print version number and number of columns to schema file
        #
        print $csvs_fh "version 1.0\n";
        print $csvs_fh '@totalColumns ' . scalar(@headings) . "\n";
        print "version 1.0\n" if $debug;
        print '@totalColumns ' . scalar(@headings) . "\n" if $debug;

        #
        # Add heading conditions
        #
        foreach $heading (@headings) {
            #
            # Print heading label to the schema file.
            #
            print $csvs_fh "\"" . $heading->term() . "\":";
            print $heading->term() . ":" if $debug;

            #
            # Do we have a heading condition ?
            #
            $condition = $heading->condition();
            if ( $condition ne "" ) {
                #
                # Include condition for this heading
                #
                print $csvs_fh " $condition\n";
                print " $condition\n" if $debug;

                #
                # Set flag to indicate we have at least 1 condition to check
                #
                $have_condition = 1;
            }
            else {
                #
                # No condition for this heading, just include the heading
                # in the schema file without any condition.
                #
                print $csvs_fh "\n";
                print "\n" if $debug;
            }
        }
        
        #
        # Close the schema file
        #
        close($csvs_fh);
        
        #
        # Did we find at least 1 data condition
        #
        if ( $have_condition ) {
            #
            # Do we have a byte order mark in the CSV file ?
            #
            if ( $have_bom ) {
                #
                # Make a copy of the CSV file and strip out any UTF-8 BOM that
                # may be present.  The csv-validator does not handle the BOM and
                # reports problems with the header line.
                #
                print "Have BOM, create temporary CSV file before running csv-validator\n" if $debug;
                ($temp_csv_fh, $csv_filename) = tempfile("WPSS_TOOL_XXXXXXXXXX",
                                                         SUFFIX => '.csv',
                                                         TMPDIR => 1);
                if ( ! defined($temp_csv_fh) ) {
                    print "Error: Failed to create temporary file in Run_CSV_Validator\n";
                    print STDERR "Error: Failed to create temporary file in Run_CSV_Validator\n";
                    unlink($csvs_filename);
                    return;
                }
                binmode $temp_csv_fh, ":utf8";
                print "Temporary CSV file = $csv_filename\n" if $debug;
                
                #
                # Open the original CSV file and skip over the BOM
                #
                open($csv_fh, "$filename");
                binmode $csv_fh, ":utf8";
                seek($csv_fh, 3, 0);
                
                #
                # Copy original CSV content into the temporary CSV file
                #
                print "Copy original CSV file after skipping BOM\n" if $debug;
                while ( $line = $csv_fh->getline() ) {
                    $temp_csv_fh->write($line, length($line));
                }
                close($csv_fh);
                close($temp_csv_fh);
            }
            else {
                $csv_filename = $filename;
            }
            
            #
            # Run the csv-validator
            #
            print "Run $csv_validator\n --> $csv_filename $csvs_filename 2>\&1\n" if $debug;
            $output = `$csv_validator \"$csv_filename\" \"$csvs_filename\" 2>\&1`;
            print "Validator output = $output\n" if $debug;
            
            #
            # Did the validator report any errors ?
            #
            if ( $output =~ /Error:/ ) {
                print "csv-validator failed\n" if $debug;
                Record_Result("OD_CSV_1", -1, -1, "",
                              String_Value("csv-validator failed") .
                              " \"$output\"");
            }
            elsif ( $output =~ /PASS/ ) {
                #
                # CSV validation passed
                #
                print "csv-validator passed\n" if $debug;
            }
            else {
                #
                # Some error trying to run the validator
                #
                print "csv-validator command failed\n" if $debug;
                print STDERR "csv-validator command failed\n";
                print STDERR "  $csv_validator $csv_filename $csvs_filename\n";
                print STDERR "$output\n";
                
                #
                # Report runtime error only once
                #
                if ( ! $runtime_error_reported ) {
                    Record_Result("OD_CSV_1", -1, -1, "",
                                  String_Value("Runtime Error") .
                                  " \"$csv_validator $csv_filename $csvs_filename\"\n" .
                                  " \"$output\"");
                    $runtime_error_reported = 1;
                }
            }
        }
        else {
            print "No data conditions, skipping csv-validator\n" if $debug;
        }
        
        #
        # Clean up the temporary schema file and temporary CSV file
        #
        unlink($csvs_filename);
        if ( $have_bom ) {
            unlink($csv_filename);
        }
    }
}

#***********************************************************************
#
# Name: Open_Data_CSV_Check_Data
#
# Parameters: this_url - a URL
#             profile - testcase profile
#             filename - CSV content file
#             dictionary - address of a hash table for data dictionary
#
# Description:
#
#   This function runs a number of open data checks on CSV data file content.
#
#***********************************************************************
sub Open_Data_CSV_Check_Data {
    my ($this_url, $profile, $filename, $dictionary) = @_;

    my ($parser, $url, @tqa_results_list, $result_object, $testcase);
    my ($line, @fields, $line_no, $status, $found_fields, $field_count);
    my ($csv_file, $csv_file_name, $rows, $message, $content);
    my ($row_content, $eval_output, @headings, $i, $regex, $heading, $data);
    my ($have_regex, $have_bom, %row_checksum, $checksum);
    my (%duplicate_columns, %duplicate_columns_flag, $j, $this_field);
    my ($duplicate_columns_ptr, $duplicate_column_list, $other_heading);
    my (%blank_zero_column_flag);

    #
    # Do we have a valid profile ?
    #
    print "Open_Data_CSV_Check_Data: Checking URL $this_url, profile = $profile\n" if $debug;
    if ( ! defined($open_data_profile_map{$profile}) ) {
        print "Open_Data_CSV_Check_Data: Unknown CSV testcase profile passed $profile\n";
        return(@tqa_results_list);
    }

    #
    # Save URL in global variable
    #
    if ( ($this_url =~ /^http/i) || ($this_url =~ /^file/i) ) {
        $current_url = $this_url;
    }
    else {
        #
        # Doesn't look like a URL.  Could be just a block of CSV
        # from the standalone validator which does not have a URL.
        #
        $current_url = "";
    }

    #
    # Initialize the test case pass/fail table.
    #
    Initialize_Test_Results($profile, \@tqa_results_list);

    #
    # Open the CSV file for reading.
    #
    print "Open CSV file $filename\n" if $debug;
    open($csv_file, "$filename") ||
        die "Open_Data_CSV_Check_Data: Failed to open $filename for reading\n";
    binmode $csv_file;

    #
    # Check for UTF-8 BOM (Byte Order Mark) at the top of the
    # file
    #
    $have_bom = Check_UTF8_BOM($csv_file);

    #
    # Create a document parser
    #
    $parser = csv_parser->new();
    if ( ! defined($parser) ) {
        print STDERR "Error: Failed to create CSV parser in Open_Data_CSV_Check_Data\n";
        exit(1);
    }

    #
    # Parse each line/record of the content
    #
    $eval_output = eval { $rows = $parser->getrow($csv_file); 1 };
    $line_no = 0;
    while ( $eval_output && defined($rows) && ( ! $parser->eof()) ) {
        #
        # Increment record/line number
        #
        $line_no++;
        
        #
        # Get the set of fields from the parsed line/record
        #
        @fields = @$rows;
        print "Line # $line_no, field count " . scalar(@fields) . "\n" if $debug;

        #
        # Did we get an error ?
        #
        if ( ! $parser->status() ) {
            $line = $parser->error_input();
            $message = $parser->error_diag();
            print "CSV file error at line $line_no, line = \"$line\"\n" if $debug;
            print "parser->error_diag = \"$message\"\n" if $debug;
            Record_Result("OD_3", $line_no, 0, $line,
                          String_Value("Parse error in line") .
                          " \"$message\"");
            last;
        }

        #
        # Is this the first row ? If so check for a possible heading
        # row (i.e. the field values are the dictionary terms)
        #
        if ( $line_no == 1 ) {
            @headings = Check_First_Data_Row($dictionary, @fields);

            #
            # Set the number of expected fields
            #
            $field_count = @fields;
            $last_csv_column_count = $field_count;
            print "Expected fields count = $field_count\n" if $debug;
            
            #
            # Initialize the blank/zero column flag. This is used to track
            # whether or not the column contains any non-blank/non-zero data.
            #
            for ($i = 0; $i < $field_count; $i++) {
                $blank_zero_column_flag{$i} = 1;
            }
            
            #
            # If we did find a heading row, skip to the next (data) row
            #
            $have_regex = 0;
            if ( @headings > 0 ) {
                print "Have headings\n" if $debug;
                
                #
                # Do any of the headings have data regular expression patterns ?
                #
                foreach $heading (@headings) {
                    $regex = $heading->regex();
                    if ( $regex ne "" ) {
                        $have_regex = 1;
                        last;
                    }
                }

                #
                # Get next line from the CSV file
                #
                $eval_output = eval { $rows = $parser->getrow($csv_file); 1 };
                next;
            }
        }

        #
        # Check for a blank row, remove whitespace from content string.
        #
        $row_content = join("", @fields);
        $row_content =~ s/\s|\n|\r//g;
        if ( $row_content eq "" ) {
            Record_Result("OD_CSV_1", $line_no, 0, "$line",
                          String_Value("No content in row"));

            #
            # Get next line from the CSV file
            #
            $eval_output = eval { $rows = $parser->getrow($csv_file); 1 };
            next;
        }
        #
        # Does the field count match the expected number of fields ?
        #
        elsif ( $field_count != @fields ) {
            $found_fields = @fields;
            Record_Result("OD_CSV_1", $line_no, 0, "$line",
                          String_Value("Inconsistent number of fields, found") .
                          " $found_fields " . String_Value("expecting") .
                          " $field_count");
            if ( $debug ) {
               print "Field values are\n";
               $field_count = 0;
               foreach (@fields) {
                   $field_count++;
                   print " Field $field_count \"$_\"\n";
               }
            }

            #
            # Get next line from the CSV file
            #
            $eval_output = eval { $rows = $parser->getrow($csv_file); 1 };
            next;
        }
        #
        # Do we have data regular expressions ? If so check data quality
        #
        elsif ( $have_regex ) {
            for ($i = 0; $i < @headings; $i++) {
                $heading = $headings[$i];
                $data = $fields[$i];
                $regex = $heading->regex();
                
                #
                # Do we have a regular expression pattern for this heading ?
                #
                if ( $regex ne "" ) {
                    # print "Check \"$data\" against regular expression $regex\n" if $debug;
                    if ( ! ($data =~ qr/$regex/) ) {
                        #
                        # Regular expression pattern fails
                        #
                        print "Regular expression failed for column $i, regex = $regex, data = $data\n" if $debug;
                        Record_Result("OD_CSV_1", $line_no, ($i + 1), "$line",
                                      String_Value("Data pattern") .
                                      " \"$regex\" " .
                                      String_Value("failed for value") .
                                      " \"$data\" " .
                                      String_Value("Column") . " \"" .
                                      $heading->term() . "\" (#" . ($i + 1) . ")");
                    }
                }
            }
        }
            
        #
        # Generate a checksum of the row content.
        #
        $checksum = md5_hex(encode_utf8(join("", @fields)));

        #
        # Have we seen this checksum before ? If so we have a duplicate
        # row of content.
        #
        print "Check for duplicate row, checksum = $checksum\n" if $debug;
        if ( defined($row_checksum{$checksum}) ) {
            Record_Result("OD_CSV_1", $line_no, 0, "$line",
                          String_Value("Duplicate row content, first instance at") .
                          " " . $row_checksum{$checksum});
        }
        else {
            #
            # Record this checksum and row number
            #
            $row_checksum{$checksum} = $line_no;
        }

        #
        # Check data cells for duplicate data.
        #
        # If we do not have any recognized headings (i.e. didn't hava a data
        # dictionary to check against) and this is row 1 of the CSV, we skip
        # checking for duplicate column content.  This row may be a heading row
        # and not a data row.  The heading row may not have duplicate column
        # values, but the subsequent data rows may have duplicates.  If we
        # include the possible heading row in the check we may miss the
        # duplicate data columns.
        #
        if ( ($line_no == 1) && (@headings == 0) ) {
            print "Skip field duplicates check for row 1 with no headings\n" if $debug;
        }
        else {
            print "Check for field duplicates\n" if $debug;
            for ($i = 0; $i < @fields; $i++) {
                #
                # Do we have any non-blank/non-zero data in this field ?
                # If so reset the blank column flag
                #
                if ( ($fields[$i] ne "") && ($fields[$i] ne "0") ) {
                    $blank_zero_column_flag{$i} = 0;
                }

                #
                # Do we have a value for the duplicate columns flag ?
                # If we don't, or it is true, we have not ruled out the
                # possibility that this column is a duplicate.
                #
                if ( (! defined($duplicate_columns_flag{$i})) ||
                     $duplicate_columns_flag{$i} ) {
                    #
                    # Get the current field value and a pointer to the
                    # hash table of which columns were previously found
                    # to be duplicates
                    #
                    print "Check for duplicates in row $line_no, column $i\n" if $debug;
                    $this_field = $fields[$i];
                    $duplicate_columns_ptr = $duplicate_columns{$i};

                    #
                    # Check this field against all other fields that come
                    # after it in the row (no need to check earlier fields as
                    # they would have checked against this field).
                    #
                    # Clear the duplicate column flag before the loop.  If a
                    # duplicate is found, the flag is reset.  If no duplicate
                    # is found we will not have to check this column again for
                    # any subsequent rows of data.
                    #
                    $duplicate_columns_flag{$i} = 0;
                    for ($j = $i + 1; $j < @fields; $j++) {
                        #
                        # Do we have a list of columns that are duplicates (from
                        # checks of previous rows)? If so, don't check the columns
                        # that previously were not duplicates (we have to have
                        # duplicate values for columns in every row).
                        #
                        print "Check for duplicates in row $line_no, column $i and $j\n" if $debug;
                        if ( (! defined($duplicate_columns_ptr)) ||
                             (defined($$duplicate_columns_ptr{$j})) ) {
                            #
                            # Do field values match ?
                            #
                            if ( $this_field eq $fields[$j] ) {
                                #
                                # Duplicate content in fields $i and $j
                                # Add this column number to the set of duplicate
                                # columns and set the duplicate columns flag for the
                                # main column being checked.
                                #
                                print "Duplicate content fields $i and $j\n" if $debug;
                                if ( ! defined($duplicate_columns_ptr) ) {
                                    my (%columns);
                                    $duplicate_columns_ptr = \%columns;
                                    $duplicate_columns{$i} = $duplicate_columns_ptr;
                                }
                                $$duplicate_columns_ptr{$j} = $j;
                                $duplicate_columns_flag{$i} = 1;
                            }
                        }
                    }
                }
            }
        }

        #
        # Get next line from the CSV file
        #
        $eval_output = eval { $rows = $parser->getrow($csv_file); 1 };
    }

    #
    # Did we get a runtime error ?
    #
    $last_csv_row_count = $line_no;
    if ( ! $eval_output ) {
        print STDERR "parser->getrow fail, eval_output = \"$@\"\n";
        print "parser->getrow fail, eval_output = \"$@\"\n" if $debug;
        Record_Result("OD_CSV_1", $line_no, 0, $line,
                      String_Value("Parse error in line") .
                      " \"$@\"");
    }
    #
    # Did we get an error on the last line ?
    #
    elsif ( defined($parser) && (! $parser->eof()) && (! $parser->status()) ) {
        $line = $parser->error_input();
        $message = $parser->error_diag();
        print "CSV file error at end of CSV at line $line_no, line = \"$line\"\n" if $debug;
        print "parser->error_diag = \"$message\"\n" if $debug;
        Record_Result("OD_CSV_1", $line_no, 0, $line,
                      String_Value("Parse error in line") .
                      " \"$message\"");
    }
    #
    # Did we find any rows in the CSV content ?
    #
    elsif ( $line_no == 0 ) {
        Record_Result("OD_3", -1, 0, "", String_Value("No content in file"));
    }
    close($csv_file);
    
    #
    # Check columns for duplicates, only if we have at least 10 rows of data
    #
    if ( $line_no > 9 ) {
        undef $heading;
        for ($i = 0; $i < @fields; $i++) {
            #
            # Get heading, if we have defined headings.
            #
            if ( @headings > 0 ) {
                $heading = $headings[$i];
            }
            
            #
            # Does the column contain any non-blank/non-zero content ?
            # (the assumption is that a column could be blank and we don't
            # want to report duplicate columns if the columns are blank).
            #
            if ( defined($blank_zero_column_flag{$i}) && $blank_zero_column_flag{$i} ) {
                #
                # Skip this field for duplicates reporting
                #
                next;
            }

            #
            # Do we have a value for the duplicate columns flag and
            # is it true ?
            #
            if ( defined($duplicate_columns_flag{$i}) &&
                 $duplicate_columns_flag{$i} ) {
                #
                # This column has other columns with duplicate
                # content.
                #
                $duplicate_columns_ptr = $duplicate_columns{$i};
                
                #
                # Get column headings, if we have defined headings.
                #
                if ( @headings > 0 ) {
                    $duplicate_column_list = "\"" . $heading->term() .
                                             "\" (#" . ($i + 1) . ")";
                    $duplicate_column_list = join(", ", keys(%$duplicate_columns_ptr));
                    foreach $j (keys(%$duplicate_columns_ptr)) {
                        $other_heading = $headings[$j];
                        $duplicate_column_list .= ", \"" . $other_heading->term() .
                                                  "\" (#" . ($j + 1) . ")";
                    }
                }
                else {
                    #
                    # Just include column numbers in the message
                    #
                    $duplicate_column_list = "" . ($i + 1);
                    foreach $j (keys(%$duplicate_columns_ptr)) {
                        $duplicate_column_list .= ", " . ($j + 1);
                    }
                }
                print "Duplicate columns $duplicate_column_list\n" if $debug;
                Record_Result("OD_CSV_1", -1, $i + 1, "$line",
                              String_Value("Duplicate content in columns") .
                              " $duplicate_column_list");
            }
        }
    }
    
    #
    # Check data conditions for data columns
    #
    Run_CSV_Validator($this_url, $filename, $have_bom, @headings);
    
    #
    # Print testcase information
    #
    if ( $debug ) {
        print "Open_Data_CSV_Check_Data results\n";
        foreach $result_object (@tqa_results_list) {
            print "Testcase: " . $result_object->testcase;
            print "  message  = " . $result_object->message . "\n";
        }
    }

    #
    # Return list of results
    #
    return(@tqa_results_list);
}

#***********************************************************************
#
# Name: Open_Data_CSV_Check_Get_Row_Count
#
# Parameters: this_url - a URL
#
# Description:
#
#   This function runs the number of rows found in the last CSV file
# analysed.
#
#***********************************************************************
sub Open_Data_CSV_Check_Get_Row_Count {
    my ($this_url) = @_;

    #
    # Check that the last URL process matches the one requested
    #
    if ( $this_url eq $current_url ) {
        print "Open_Data_CSV_Check_Get_Row_Count url = $this_url, row count = $last_csv_row_count\n" if $debug;
        return($last_csv_row_count);
    }
    else {
        print "Error: Open_Data_CSV_Check_Get_Row_Count url = $this_url, current_url = $current_url\n"if $debug;
        return(-1);
    }
}

#***********************************************************************
#
# Name: Open_Data_CSV_Check_Get_Column_Count
#
# Parameters: this_url - a URL
#
# Description:
#
#   This function runs the number of columns found in the last CSV file
# analysed.
#
#***********************************************************************
sub Open_Data_CSV_Check_Get_Column_Count {
    my ($this_url) = @_;

    #
    # Check that the last URL process matches the one requested
    #
    if ( $this_url eq $current_url ) {
        print "Open_Data_CSV_Check_Get_Column_Count url = $this_url, row count = $last_csv_row_count\n" if $debug;
        return($last_csv_column_count);
    }
    else {
        print "Error: Open_Data_CSV_Check_Get_Column_Count url = $this_url, current_url = $current_url\n"if $debug;
        return(-1);
    }
}

#***********************************************************************
#
# Name: Open_Data_CSV_Check_Get_Headings_List
#
# Parameters: this_url - a URL
#
# Description:
#
#   This function runs the headings lsit found in the last CSV file
# analysed.
#
#***********************************************************************
sub Open_Data_CSV_Check_Get_Headings_List {
    my ($this_url) = @_;

    #
    # Check that the last URL process matches the one requested
    #
    if ( $this_url eq $current_url ) {
        print "Open_Data_CSV_Check_Get_Headings_List url = $this_url, headings list = $last_csv_headings_list\n" if $debug;
        return($last_csv_headings_list);
    }
    else {
        print "Error: Open_Data_CSV_Check_Get_Headings_List url = $this_url, current_url = $current_url\n"if $debug;
        return("");
    }
}

#***********************************************************************
#
# Name: Import_Packages
#
# Parameters: none
#
# Description:
#
#   This function imports any required packages that cannot
# be handled via use statements.
#
#***********************************************************************
sub Import_Packages {

    my ($package);
    my (@package_list) = ("csv_parser", "open_data_testcases",
                          "tqa_result_object");

    #
    # Import packages, we don't use a 'use' statement as these packages
    # may not be in the INC path.
    #
    foreach $package (@package_list) {
        #
        # Import the package routines.
        #
        if ( ! defined($INC{$package}) ) {
            require "$package.pm";
        }
        $package->import();
    }
}

#***********************************************************************
#
# Mainline
#
#***********************************************************************

#
# Get our program directory, where we find supporting files
#
$program_dir  = dirname($0);
$program_name = basename($0);

#
# If directory is '.', search the PATH to see where we were found
#
if ( $program_dir eq "." ) {
    $paths = $ENV{"PATH"};
    @paths = split( /:/, $paths );

    #
    # Loop through path until we find ourselves
    #
    foreach $this_path (@paths) {
        if ( -x "$this_path/$program_name" ) {
            $program_dir = $this_path;
            last;
        }
    }
}

#
# Generate path the the csv-validator
#
if ( $^O =~ /MSWin32/ ) {
    #
    # Windows.
    #
    $csv_validator = ".\\bin\\csv-validator\\bin\\validate.bat";
} else {
    #
    # Not Windows.
    #
    $csv_validator = "$program_dir/bin/csv-validator/bin/validate";
}

#
# Import required packages
#
Import_Packages;

#
# Return true to indicate we loaded successfully
#
return 1;

>>>>>>> cd924f176ead1826c0dd8e811da53b9f1ee1e583
