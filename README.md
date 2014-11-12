WPSS Validation Tool version 4.7.0
-----------------------------------

The WPSS Validation Tool provides web developers and quality assurance testers the ability to perform a number of web site and web page validation tasks at one time. The tool crawls a site to find all of the documents then analyses each document with a number of validation tools.

Version 4.7.0 contains the following updates and additions

WPSS_Tool
---------

    - Reduce the memory requirements to avoid "Out of memory" errors.
    - If no DOC type line is found in HTML markup, don't run markup validator.
    - Change CSS checks from checking the entire CSS content to checking styles in actual use.
    - Check for ARIA attributes as possible labels.
    - Don't extract links from PDF documents.
    - Clean up temporary files when program exist.
    - Check for @media diectives in CSS. When checking styles for accessibility, only check styles with no media or media = screen.
    - Check for aria-label attribute additional tags (e.g. in fieldset).
    - Don't report WCAG_2.0-H33 error for empty title attribute in link.
    - Check for empty <thead> and <tfoot> tags - WCAG_2.0-G115.
 

Reminder: The WPSS Tool DOES NOT validate HTML5 markup.


Open Data Tool
--------------

    - Check for and validate PWGSC XML data dictionary format - TP_PW_OD_XML_1
 

WPSS_Tool Installer
---------------------

The tool installer, WPSS_Tool.exe, does NOT include the required Perl or Python installers (as was the case for previous releases).  Perl and Python must be installed on the workstation prior to installing the WPSS_Tool.

Supported versions of Perl include
- Strawberry Perl 5.18 (32 bit) available from http://strawberry-perl.googlecode.com/files/strawberry-perl-5.18.1.1-32bit.msi

Supported versions of Python include
- Python 2.7.6 available from http://python.org/ftp/python/2.7.6/python-2.7.6.msi

The WPSS_Tool has been tested on the following platforms
- Windows 7 (32 bit), Strawberry Perl 5.18 (32 bit), Python 2.7.6

The WPSS Tool installer is available as a release in this repository
  - https://github.com/wet-boew/wet-boew-wpss/releases/download/4.7.0/WPSS_Tool.exe
