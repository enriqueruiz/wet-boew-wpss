<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
# WPSS Validation Tool version 4.0.1

The WPSS Validation Tool provides web developers and quality assurance testers the ability to perform a number of web site and web page validation tasks at one time. The tool crawls a site to find all of the documents then analyses each document with a number of validation tools.

Version 4.0.1 contains the following updates and additions
 - Add open data checking tool (open_data_check.pl and desktop shortcut)  to check open dataset files (dictionary, data, resources).
 - Do case insensitive checks on titles to find matching HTML and PDF versions of a document.
 - Allow for binary data in CSV files (e.g. new-line in the cell content).
 - Report Interoperability failure for web feeds that do not parse properly - SWI_B.
 - Check for table headers that reference undefined headers or headers outside the current table - WCAG_2.0-H43.
 - Check for all language markers to determine if a page is archived or not (handles the case where wrong language message is used).
 - Encode text that is written to results tabs, this eliminates garbled French characters.
 - Report unknown mime-type documents as non-HTML primary format.
 - Accept enter key in URL list tab to move to the next input line.
 - Check for very long (> 500 characters) title and heading text - WCAG_2.0-H42, WCAG_2.0-H25
 - Don't report zoom failure for fix size fonts as current browsers can handle this - WCAG_2.0-G142
 - Decode HTML entities before checking the length of titles and headings to eliminate the length of the HTML code from the actual text length.


Reminder: The WPSS Tool DOES NOT validate HTML5 markup.

# WPSS_Tool Installer

The tool installer, WPSS_Tool.exe, does NOT include the required Perl or Python installers (as was the case for previous releases).  Perl and Python must be installed on the workstation prior to installing the WPSS_Tool.

Supported versions of Perl include
  - ActiveState Perl 5.14 (does not support 5.16)
  - Strawberry Perl 5.18 (32 bit) available from http://strawberry-perl.googlecode.com/files/strawberry-perl-5.18.1.1-32bit.msi

Supported versions of Python include
  - Python 2.7.3
  - Python 2.7.6 available from http://python.org/ftp/python/2.7.6/python-2.7.6.msi

The WPSS_Tool has been tested on the following platforms
  - Windows XP (32 bit), ActiveState Perl 5.14, Python 2.7.3
  - Windows XP (32 bit), Strawberry Perl 5.18, Python 2.7.3
  - Windows XP (32 bit), Strawberry Perl 5.18, Python 2.7.6
  - Windows 7 (64 bit), Strawberry Perl 5.18 (32 bit), Python 2.7.3

The WPSS Tool installer is available as a release in this repository
  - https://github.com/wet-boew/wet-boew-wpss/releases/download/4.0.1/WPSS_Tool.exe
=======
WPSS Validation Tool version 4.6.0
=======
WPSS Validation Tool version 5.0.1
>>>>>>> upstream/master
=======
WPSS Validation Tool version 5.2.0
>>>>>>> upstream/master
-----------------------------------
=======
Web and Open Data Validator version 6.2.0
-----------------------------------------
>>>>>>> upstream/master

The Web and Open Data Validator (formerly the WPSS Validation Tool) provides web developers and quality assurance testers the ability to perform a number of web site, web page validation and Open data validation tasks at one time.

Major Changes
----------------------
Web Tool

    - Change program folder and program names in Windows start menu.  Folder is "Web and Open Data Validator", 
      tools are "Web Tool" and "Open Data Tool".
    - Update Core Subject Thesaurus to July 4, 2016 version - DC Subject	
    - Add a PhantomJS markup server program to remain active for an analysis run and save the delays in 
      starting PhantomJS for each page retrieved.
    - When merging link details from original markup and generated markup, use line/column information 
      from the generated markup.

Open Data_Tool

    - Check for duplicate rows in CSV file - OD_CSV_1
    - Check for duplicate columns in CSV file - OD_CSV_1
    - If an XML data file contains a schema specification using the xsi:schemaLocation or 
      xsi:noNamespaceSchemaLocation attribute, validate the XML against the schema - OD_3
    - Check for BOM (Byte Order Mark) in all text files - OD_TP_PW_BOM
    - If an XML data file contains a DOCTYPE declaration, validate the XML against the DOCTYPE - OD_3
    - Generate a dataset inventory CSV file containing details of the dataset files (URL, size, mime-type, etc).
    - Check the alternate language versions of CSV datafiles contain the same number of columns - OD_CSV_1


Version 6.2.0 contains the following updates and additions

Web
---

    - Prefix all temporary file names with WPSS_TOOL_ for easy deletion.
    - Update Core Subject Thesaurus to July 4, 2016 version - DC Subject
    - Move supporting programs to a bin folder from the top level folder.
    - Add a PhantomJS markup server program to remain active for an analysis
      run and save the delays in starting PhantomJS for each page retrieved.
    - Change tool name to "Web and Open Data Validator" to better describe
      the purpose of the tool.
    - When merging link details from original markup and generated markup,
      use line/column information from the generated markup.
    - Change program folder and program names in Windows start menu.  Folder
      is "Web and Open Data Validator", tools are "Web Tool" and
      "Open Data Tool".

Open Data
---------

    - Check for duplicate rows in CSV file - OD_CSV_1
    - Check for duplicate columns in CSV file - OD_CSV_1
    - Remove API specific testcase identifiers
    - If an XML data file contains a schema specification using the
      xsi:schemaLocation or xsi:noNamespaceSchemaLocation attribute,
      validate the XML against the schema - OD_3
    - Use custom CSV file parser to avoid potential error in Text::CSV
      module and quoted fields with greater than 32K characters.
    - Check for BOM (Byte Order Mark) in all text files - OD_TP_PW_BOM
    - If an XML data file contains a DOCTYPE declaration, validate
      the XML against the DOCTYPE - OD_3
    - Replace the xsd-validator tool with the Xerces tool to validate
      XML against schema or a DOCTYPE.
    - Check for a DOCTYPE or schema specification in XML files - OD_3
    - Validate XML content against data patterns specified in the
      data dictionary - OD_XML_1
    - Update JSON open data description URL handling due to changes in
      the open.canada.ca site.
    - Generate a dataset inventory CSV file containing details of the
      dataset files (URL, size, mime-type, etc).
    - Check the alternate language versions of CSV datafiles contain the
      same number of columns - OD_CSV_1


Web and Open Data Validator Installer
-------------------------------------

The tool installer, WPSS_Tool.exe, does NOT include the required Perl or Python installers (as was the case for previous releases).  Perl and Python must be installed on the workstation prior to installing the WPSS_Tool.

Supported versions of Perl include
- Strawberry Perl 5.18 (32 bit) available from http://strawberry-perl.googlecode.com/files/strawberry-perl-5.18.1.1-32bit.msi

Supported versions of Python include
- Python 2.7.6 available from http://python.org/ftp/python/2.7.6/python-2.7.6.msi

The WPSS_Tool has been tested on the following platforms
- Windows 7 (32 bit), Strawberry Perl 5.18 (32 bit), Python 2.7.6

The WPSS Tool installer is available as a release in this repository
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
  - https://github.com/wet-boew/wet-boew-wpss/releases/download/4.6.0/WPSS_Tool.exe
>>>>>>> cd924f176ead1826c0dd8e811da53b9f1ee1e583
=======
  - https://github.com/wet-boew/wet-boew-wpss/releases/download/5.0.1/WPSS_Tool.exe
>>>>>>> upstream/master
=======
  - https://github.com/wet-boew/wet-boew-wpss/releases/download/5.2.0/WPSS_Tool.exe
>>>>>>> upstream/master
=======
  - https://github.com/wet-boew/wet-boew-wpss/releases/download/6.2.0/WPSS_Tool.exe
>>>>>>> upstream/master
