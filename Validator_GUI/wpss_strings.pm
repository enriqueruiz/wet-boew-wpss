<<<<<<< HEAD
#***********************************************************************
#
# Name: wpss_strings.pm
#
# $Revision: 6415 $
# $URL: svn://10.36.20.226/trunk/Web_Checks/Validator_GUI/Tools/wpss_strings.pm $
# $Date: 2013-10-30 15:37:58 -0400 (Wed, 30 Oct 2013) $
#
# Description:
#
#   This module contains functions to provide text strings for labels
# and messages for the WPSS Tool.  It provides them in the language
# specified.
#
# Public functions:
#     Set_String_Table_Language
#     String_Value
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

package wpss_strings;

use strict;

#***********************************************************************
#
# Export package globals
#
#***********************************************************************
BEGIN {
    use Exporter   ();
    use vars qw($VERSION @ISA @EXPORT);

    @ISA     = qw(Exporter);
    @EXPORT  = qw(Set_String_Table_Language
                  String_Value);
    $VERSION = "1.0";
}

my %string_table_en = (
    "Crawled URL report header",	"The following is a list of crawled URLs from your site.

Site:
",
    "Validation report header",	"The following is a list of web documents from your site that contain validation errors.

Site:
",
    "Metadata report header",	"The following is a list of web documents from your site that contain Metadata Check errors.

Site:
",
    "ACC report header", "The following is a list of web documents from your site that contain Accessibility Check errors.

Site:
",
   "CLF report header", "The following is a list of web documents from your site that contain CLF Check errors.

Site:
",
   "Interop report header", "The following is a list of web documents from your site that contain Interoperability Check errors.

Site:
",
    "Link report header", "The following is a list of web documents from your site that contain Link Check violations.

Site:
",
    "Department report header", "The following is a list of web documents from your site that contain Department Check violations.

Site:
",
    "Document Features report header", "The following is a list of web documents from your site that contain document features.

Site:
",
    "Document List report header",	"The following is a sorted list of web documents from your site.

Site:
",
    "Open Data report header", "The following is a list of documents that contain Open Data Check violations.

",
    "Image report header",	"The following is a list of images from your site.",
    "Headings report header", "The following is a report of headings within documents from your site.",
    "Entry page",	"Entry page ",
    "rewritten to",		" rewritten to ",
    "Analysis terminated",	"Analysis terminated",
    "Analysis completed",	"Analysis completed at (hh:mm:ss yyyy/mm/dd) ",
    "Analysis started",		"Analysis started at (hh:mm:ss yyyy/mm/dd) ",
    "Crawled URLs",		"Crawled URLs",
    "Validation",		"Validation",
    "Metadata",			"Metadata",
    "Open Data",    "Open Data",
    "Document List",		"Document List",
    "Link Check Profile",		"Link Check Profile",
    "Metadata Profile",		"Metadata Profile",
    "PDF Property Profile",	"PDF Property Profile",
    "ACC Testcase Profile",	"ACC Testcase Profile",
    "CLF Testcase Profile",	"CLF Testcase Profile",
    "Interop Testcase Profile",	"Interoperability Testcase Profile",
    "Open Data Testcase Profile", "Open Data Testcase Profile",
    "Department Check Testcase Profile",	"Department Check Testcase Profile",
    "ACC",  			"ACC",
    "CLF",        "CLF",
    "INT",        "Interop",
    "Link", 			"Link",
    "Department", 			"Department",
    "Document Features",		"Document Features",
    "Document Features Profile",	"Document Features Profile",
    "pass", 			"pass",
    "fail", 			"fail",
    "Failed to get url",  	"Failed to get url ",
    "error is", 		",error is ",
    "List of URLs with Document Feature",  "List of URLs with Document Feature: ",
    "Line", 			"Line: ",
    "Column", 			"Column: ",
    "Source line", 			"Source line: ",
    "date checked", 			"date checked ",
    "Error",	 			"Error: ",
    "Testcase",				"Testcase: ",
    "failed",				"failed",
    "warning",				"warning",
    "Metadata Tag",			"Metadata Tag",
    "Property",				"Property",
    "Link at", 				"Link at ",
    "href", 				"href ",
    "Crawl stopped after", 		"Crawl stopped after ",
    "HTML url",				"HTML url ",
    "PDF url",				"PDF url ",
    "HTML Title",			"HTML Title ",
    "PDF Title",			"PDF Title ",
    "DC Title",				"dc.title   ",
    "Title",				"Title ",
    "Documents Checked",		"Documents Checked: ",
    "Documents with errors",		"Documents with errors: ",
    "2 spaces",				"  ",
    "4 spaces",				"    ",
    "Content violations",               "Content violations",
    "Results summary table",            "Results summary table",
    "instances",                        "instances",
    "help",                             "help",
    "Image/lang/alt/title Report",      "Image/lang/alt/title Report",
    "Headings Report Title",            "Headings Report",
    "robots.txt handling",              "robots.txt handling",
    "Respect robots.txt",               "Respect robots.txt",
    "Ignore robots.txt",                "Ignore robots.txt",
    "401 handling",                     "401 status handling",
    "Prompt for credentials",           "Prompt for credentials",
    "Ignore",                           "Ignore",
    "HTTP Error",                       "HTTP Error",
    "Malformed URL",                    "Malformed URL",
    "Analysis Aborted",                 "**** Analysis Aborted ****",
    "Not reviewed",                     "**** Not reviewed ****",
    );

my %string_table_fr = (
    "Crawled URL report header",	"Ce qui suit est une liste de URL explor�s de votre site.

Site:
",
    "Validation report header",	"Ce qui suit est une liste de documents Web de votre site qui contient des erreurs de validation.

Site:
",
    "Metadata report header",	"Ce qui suit est une liste de documents Web de votre site qui contient des erreurs de m�tadonn�es.

Site:
",
    "ACC report header", "Ce qui suit est une liste de documents Web de votre site qui contient des erreurs d'accessibilit�.

Site:
",
    "CLF report header", "Ce qui suit est une liste de documents Web de votre site qui contient des erreurs NSI.

Site:
",
    "Interop report header", "Ce qui suit est une liste de documents Web de votre site qui contient des erreurs Interoperability.

Site:
",
    "Link report header", "Ce qui suit est une liste de documents Web de votre site qui contient des erreurs de liens.

Site:
",
    "Department report header", "Ce qui suit est une liste de documents Web de votre site qui contient des erreurs de department.

Site:
",
    "Document Features report header", " Ce qui suit est une liste de documents Web de votre site qui contient des fonctions.

Site:
",
    "Document List report header",	"Ce qui suit est une liste tri�e des documents Web de votre site. 

Site :
",
    "Open Data report header", "Ce qui suit est une liste de documents qui contiennent des violations de donn�es ouvertes.

",
    "Image report header",	"Ce qui suit est une liste d'images tri�e de votre site.",
    "Headings report header", "Ce qui suit est un rapport des En-t�tes dans les documents de votre site",
    "Entry page",		"Page d'entr�e ",
    "rewritten to",		"r��crit pour ",
    "Analysis terminated",	"Analyse a termin�",
    "Analysis completed",	"Analyse complet�e le (hh:mm:ss aaaa/mm/dd) ",
    "Analysis started",		"Analyse commenc�e le (hh:mm:ss aaaa/mm/dd) ",
    "Crawled URLs",		"URL explor�s",
    "Validation",		"Validation",
    "Metadata",			"M�tadonn�es",
    "Open Data",    "Donn�es Ouvertes",
    "Document List",		"Liste des documents",
    "Link Check Profile",		"Profil de v�rifier des liens",
    "Metadata Profile",		"Profil de m�tadonn�es",
    "PDF Property Profile",	"Profil de propri�t� de PDF",
    "ACC Testcase Profile",	"Profil des cas de test de ACC",
    "CLF Testcase Profile",	"Profil des cas de test de NSI",
    "Interop Testcase Profile",	"Profil des cas de test de Interoperability",
    "Open Data Testcase Profile",  "Profil des cas de test de Donn�es Ouvertes",
    "Department Check Testcase Profile",	"Profil des cas de test de department ",
    "Yes",			"Oui",
    "No",			"Non",
    "Report testcases that pass","Rapporter les cas de test qui passent",
    "ACC",  			"ACC",
    "CLF",        "NSI",
    "INT",        "Interop",
    "Link", 			"Lien",
    "Content",  		"Contenu",
    "Document Features",		"Fonctions des documents",
    "Document Features Profile",	"Profil des fonctions des documents",
    "pass", 			"succ�s",
    "fail", 			"�chec",
    "Failed to get url",  	"Impossible d'obtenir le url ",
    "error is", 		",l'erreur est ",
    "List of URLs with Document Feature",  "Liste des URL avec des fonctions du document: ",
    "Line", 			"la ligne : ",
    "Column", 			"Colonne : ",
    "Source line", 			"Ligne de la source",
    "date checked", 			"date v�rifi�e ",
    "Error", 			"Erreur : ",
    "Testcase",   "Cas de test : ",
    "failed", 			"�chouer ",
    "warning",				"avertissement",
    "Metadata Tag", "balise de m�tadonn�es",
    "Property", "Propri�t�",
    "Link at", "Lien � ",
    "href", "href ",
    "Crawl stopped after", "L'exploration s'est arr�t� apr�s ",
    "HTML url",				"URL de HTML ",
    "PDF url",				"URL de PDF ",
    "HTML Title",			"Titre de HTML ",
    "PDF Title",			"Titre de PDF ",
    "DC Title",				"dc.title   ",
    "Title",				"Titre",
    "Documents Checked",		"Document �valu�: ",
    "Documents with errors",		"Documents avec des erreurs: ",
    "2 spaces",				"  ",
    "4 spaces",				"    ",
    "Content violations",               "Erreurs de contenu",
    "Results summary table",            "Tableau r�capitulatif des r�sultats",
    "instances",                        "instances",
    "help",                             "aide",
    "Image/lang/alt/title Report",      "Rapport des image/lang/alt/title",
    "Headings Report Title",            "Rapport des En-t�tes",
    "robots.txt handling",              "Manutention du robots.txt",
    "Respect robots.txt",               "Respectez robots.txt",
    "Ignore robots.txt",                "Ignorer robots.txt",
    "401 handling",                     "Manutention de code 401",
    "Prompt for credentials",           "Demander des informations d'identification",
    "Ignore",                           "Ignorer",
    "HTTP Error",                       "Erreur HTTP",
    "Malformed URL",                    "URL incorrecte",
    "Analysis Aborted",	                "**** Analyse abandonn� ****",
    "Not reviewed",                     "**** Non r�vis� ****",
);

#
# Default language is English
#
my ($string_table) = \%string_table_en;

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

#**********************************************************************
#
# Name: Set_String_Table_Language
#
# Parameters: lang - language
#
# Description:
#
#   This function sets the string table to use for string translations
# to the specified language.
#
#**********************************************************************
sub Set_String_Table_Language {
    my ($lang) = @_;

    #
    # Do we want French ?
    #
    if ( $lang =~ /fra/i ) {
        $string_table = \%string_table_fr;
    }
    else {
        $string_table = \%string_table_en;
    }
}


#***********************************************************************
#
# Mainline
#
#***********************************************************************

#
# Return true to indicate we loaded successfully
#
return 1;

=======
#***********************************************************************
#
# Name: wpss_strings.pm
#
# $Revision: 6680 $
# $URL: svn://10.36.20.226/trunk/Web_Checks/Validator_GUI/Tools/wpss_strings.pm $
# $Date: 2014-06-16 11:17:11 -0400 (Mon, 16 Jun 2014) $
#
# Description:
#
#   This module contains functions to provide text strings for labels
# and messages for the WPSS Tool.  It provides them in the language
# specified.
#
# Public functions:
#     Set_String_Table_Language
#     String_Value
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

package wpss_strings;

use strict;

#***********************************************************************
#
# Export package globals
#
#***********************************************************************
BEGIN {
    use Exporter   ();
    use vars qw($VERSION @ISA @EXPORT);

    @ISA     = qw(Exporter);
    @EXPORT  = qw(Set_String_Table_Language
                  String_Value);
    $VERSION = "1.0";
}

my %string_table_en = (
    "Crawled URL report header",	"The following is a list of crawled URLs from your site.

Site:
",
    "Validation report header",	"The following is a list of web documents from your site that contain validation errors.

Site:
",
    "Metadata report header",	"The following is a list of web documents from your site that contain Metadata Check errors.

Site:
",
    "ACC report header", "The following is a list of web documents from your site that contain Accessibility Check errors.

Site:
",
   "CLF report header", "The following is a list of web documents from your site that contain CLF Check errors.

Site:
",
   "Interop report header", "The following is a list of web documents from your site that contain Interoperability Check errors.

Site:
",
    "Link report header", "The following is a list of web documents from your site that contain Link Check violations.

Site:
",
    "Department report header", "The following is a list of web documents from your site that contain Department Check violations.

Site:
",
    "Document Features report header", "The following is a list of web documents from your site that contain document features.

Site:
",
    "Document List report header",	"The following is a sorted list of web documents from your site.

Site:
",
    "Open Data report header", "The following is a list of documents that contain Open Data Check violations.

",
    "Image report header",	"The following is a list of images from your site.",
    "Headings report header", "The following is a report of headings within documents from your site.",
    "Entry page",	"Entry page ",
    "rewritten to",		" rewritten to ",
    "Analysis terminated",	"Analysis terminated",
    "Analysis completed",	"Analysis completed at (hh:mm:ss yyyy/mm/dd) ",
    "Analysis started",		"Analysis started at (hh:mm:ss yyyy/mm/dd) ",
    "Crawled URLs",		"Crawled URLs",
    "Validation",		"Validation",
    "Metadata",			"Metadata",
    "Open Data",    "Open Data",
    "Document List",		"Document List",
    "Link Check Profile",		"Link Check Profile",
    "Metadata Profile",		"Metadata Profile",
    "PDF Property Profile",	"PDF Property Profile",
    "ACC Testcase Profile",	"ACC Testcase Profile",
    "CLF Testcase Profile",	"CLF Testcase Profile",
    "Web Analytics Testcase Profile",	"Web Analytics Testcase Profile",
    "Interop Testcase Profile",	"Interoperability Testcase Profile",
    "Open Data Testcase Profile", "Open Data Testcase Profile",
    "Department Check Testcase Profile",	"Department Check Testcase Profile",
    "ACC",  			"ACC",
    "CLF",        "CLF",
    "INT",        "Interop",
    "Link", 			"Link",
    "Department", 			"Department",
    "Document Features",		"Document Features",
    "Document Features Profile",	"Document Features Profile",
    "pass", 			"pass",
    "fail", 			"fail",
    "Failed to get url",  	"Failed to get url ",
    "error is", 		",error is ",
    "List of URLs with Document Feature",  "List of URLs with Document Feature: ",
    "Line", 			"Line: ",
    "Column", 			"Column: ",
    "Source line", 			"Source line: ",
    "date checked", 			"date checked ",
    "Error",	 			"Error: ",
    "Testcase",				"Testcase: ",
    "failed",				"failed",
    "warning",				"warning",
    "Metadata Tag",			"Metadata Tag",
    "Property",				"Property",
    "Link at", 				"Link at ",
    "href", 				"href ",
    "Crawl stopped after", 		"Crawl stopped after ",
    "HTML url",				"HTML url ",
    "PDF url",				"PDF url ",
    "HTML Title",			"HTML Title ",
    "PDF Title",			"PDF Title ",
    "DC Title",				"dc.title   ",
    "Title",				"Title ",
    "Documents Checked",		"Documents Checked: ",
    "Documents with errors",		"Documents with errors: ",
    "2 spaces",				"  ",
    "4 spaces",				"    ",
    "Content violations",               "Content violations",
    "Results summary table",            "Results summary table",
    "instances",                        "instances",
    "help",                             "help",
    "Image/lang/alt/title Report",      "Image/lang/alt/title Report",
    "Headings Report Title",            "Headings Report",
    "robots.txt handling",              "robots.txt handling",
    "Respect robots.txt",               "Respect robots.txt",
    "Ignore robots.txt",                "Ignore robots.txt",
    "401 handling",                     "401 status handling",
    "Prompt for credentials",           "Prompt for credentials",
    "Ignore",                           "Ignore",
    "HTTP Error",                       "HTTP Error",
    "Malformed URL",                    "Malformed URL",
    "Analysis Aborted",                 "**** Analysis Aborted ****",
    "Not reviewed",                     "**** Not reviewed ****",
    "Runtime Error Analysis Aborted",   "**** Runtime Error Analysis Aborted ****",
    );

my %string_table_fr = (
    "Crawled URL report header",	"Ce qui suit est une liste de URL explor�s de votre site.

Site:
",
    "Validation report header",	"Ce qui suit est une liste de documents Web de votre site qui contient des erreurs de validation.

Site:
",
    "Metadata report header",	"Ce qui suit est une liste de documents Web de votre site qui contient des erreurs de m�tadonn�es.

Site:
",
    "ACC report header", "Ce qui suit est une liste de documents Web de votre site qui contient des erreurs d'accessibilit�.

Site:
",
    "CLF report header", "Ce qui suit est une liste de documents Web de votre site qui contient des erreurs NSI.

Site:
",
    "Interop report header", "Ce qui suit est une liste de documents Web de votre site qui contient des erreurs Interoperability.

Site:
",
    "Link report header", "Ce qui suit est une liste de documents Web de votre site qui contient des erreurs de liens.

Site:
",
    "Department report header", "Ce qui suit est une liste de documents Web de votre site qui contient des erreurs de department.

Site:
",
    "Document Features report header", " Ce qui suit est une liste de documents Web de votre site qui contient des fonctions.

Site:
",
    "Document List report header",	"Ce qui suit est une liste tri�e des documents Web de votre site. 

Site :
",
    "Open Data report header", "Ce qui suit est une liste de documents qui contiennent des violations de donn�es ouvertes.

",
    "Image report header",	"Ce qui suit est une liste d'images tri�e de votre site.",
    "Headings report header", "Ce qui suit est un rapport des En-t�tes dans les documents de votre site",
    "Entry page",		"Page d'entr�e ",
    "rewritten to",		"r��crit pour ",
    "Analysis terminated",	"Analyse a termin�",
    "Analysis completed",	"Analyse complet�e le (hh:mm:ss aaaa/mm/dd) ",
    "Analysis started",		"Analyse commenc�e le (hh:mm:ss aaaa/mm/dd) ",
    "Crawled URLs",		"URL explor�s",
    "Validation",		"Validation",
    "Metadata",			"M�tadonn�es",
    "Open Data",    "Donn�es Ouvertes",
    "Document List",		"Liste des documents",
    "Link Check Profile",		"Profil de v�rifier des liens",
    "Metadata Profile",		"Profil de m�tadonn�es",
    "PDF Property Profile",	"Profil de propri�t� de PDF",
    "ACC Testcase Profile",	"Profil des cas de test de ACC",
    "CLF Testcase Profile",	"Profil des cas de test de NSI",
    "Web Analytics Testcase Profile",	"Profil des cas de test de Web analytique",
    "Interop Testcase Profile",	"Profil des cas de test de Interoperability",
    "Open Data Testcase Profile",  "Profil des cas de test de Donn�es Ouvertes",
    "Department Check Testcase Profile",	"Profil des cas de test de department ",
    "Yes",			"Oui",
    "No",			"Non",
    "Report testcases that pass","Rapporter les cas de test qui passent",
    "ACC",  			"ACC",
    "CLF",        "NSI",
    "INT",        "Interop",
    "Link", 			"Lien",
    "Content",  		"Contenu",
    "Document Features",		"Fonctions des documents",
    "Document Features Profile",	"Profil des fonctions des documents",
    "pass", 			"succ�s",
    "fail", 			"�chec",
    "Failed to get url",  	"Impossible d'obtenir le url ",
    "error is", 		",l'erreur est ",
    "List of URLs with Document Feature",  "Liste des URL avec des fonctions du document: ",
    "Line", 			"la ligne : ",
    "Column", 			"Colonne : ",
    "Source line", 			"Ligne de la source",
    "date checked", 			"date v�rifi�e ",
    "Error", 			"Erreur : ",
    "Testcase",   "Cas de test : ",
    "failed", 			"�chouer ",
    "warning",				"avertissement",
    "Metadata Tag", "balise de m�tadonn�es",
    "Property", "Propri�t�",
    "Link at", "Lien � ",
    "href", "href ",
    "Crawl stopped after", "L'exploration s'est arr�t� apr�s ",
    "HTML url",				"URL de HTML ",
    "PDF url",				"URL de PDF ",
    "HTML Title",			"Titre de HTML ",
    "PDF Title",			"Titre de PDF ",
    "DC Title",				"dc.title   ",
    "Title",				"Titre",
    "Documents Checked",		"Document �valu�: ",
    "Documents with errors",		"Documents avec des erreurs: ",
    "2 spaces",				"  ",
    "4 spaces",				"    ",
    "Content violations",               "Erreurs de contenu",
    "Results summary table",            "Tableau r�capitulatif des r�sultats",
    "instances",                        "instances",
    "help",                             "aide",
    "Image/lang/alt/title Report",      "Rapport des image/lang/alt/title",
    "Headings Report Title",            "Rapport des En-t�tes",
    "robots.txt handling",              "Manutention du robots.txt",
    "Respect robots.txt",               "Respectez robots.txt",
    "Ignore robots.txt",                "Ignorer robots.txt",
    "401 handling",                     "Manutention de code 401",
    "Prompt for credentials",           "Demander des informations d'identification",
    "Ignore",                           "Ignorer",
    "HTTP Error",                       "Erreur HTTP",
    "Malformed URL",                    "URL incorrecte",
    "Analysis Aborted",	                "**** Analyse abandonn� ****",
    "Not reviewed",                     "**** Non r�vis� ****",
    "Runtime Error Analysis Aborted",   "**** Erreur D'Ex�cution Analyse abandonn� ****",
);

#
# Default language is English
#
my ($string_table) = \%string_table_en;

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

#**********************************************************************
#
# Name: Set_String_Table_Language
#
# Parameters: lang - language
#
# Description:
#
#   This function sets the string table to use for string translations
# to the specified language.
#
#**********************************************************************
sub Set_String_Table_Language {
    my ($lang) = @_;

    #
    # Do we want French ?
    #
    if ( $lang =~ /fra/i ) {
        $string_table = \%string_table_fr;
    }
    else {
        $string_table = \%string_table_en;
    }
}


#***********************************************************************
#
# Mainline
#
#***********************************************************************

#
# Return true to indicate we loaded successfully
#
return 1;

>>>>>>> cd924f176ead1826c0dd8e811da53b9f1ee1e583
