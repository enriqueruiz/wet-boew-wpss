<<<<<<< HEAD
#***********************************************************************
#
# Name:   tqa_testcases.pm
#
# $Revision: 6331 $
# $URL: svn://10.36.20.226/trunk/Web_Checks/TQA_Check/Tools/tqa_testcases.pm $
# $Date: 2013-07-09 13:57:13 -0400 (Tue, 09 Jul 2013) $
#
# Description:
#
#   This file contains routines that handle TQA testcase descriptions.
#
# Public functions:
#     TQA_Testcase_Language
#     TQA_Testcase_Debug
#     TQA_Testcase_Description
#     TQA_Testcase_Groups
#     TQA_Testcase_Group_Count
#     TQA_Testcase_Read_URL_Help_File
#     TQA_Testcase_URL
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

package tqa_testcases;

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
    @EXPORT  = qw(TQA_Testcase_Language
                  TQA_Testcase_Debug
                  TQA_Testcase_Description
                  TQA_Testcase_Groups
                  TQA_Testcase_Group_Count
                  TQA_Testcase_Read_URL_Help_File
                  TQA_Testcase_URL
                  );
    $VERSION = "1.0";
}

#***********************************************************************
#
# File Local variable declarations
#
#***********************************************************************

my ($debug) = 0;

#
# String tables for testcase ID to testcase descriptions
#
my (%testcase_description_en) = (
#
# WCAG 2.0
#
# C12: Using percent for font sizes 
#      Failures of this technique are reported under technique G142
# C13: Using named font sizes
#      Failures of this technique are reported under technique G142
# C14: Using em units for font sizes
#      Failures of this technique are reported under technique G142
#
"WCAG_2.0-C28", "1.4.4 C28: Specifying the size of text containers using em units",
"WCAG_2.0-F3", "1.1.1 F3: Failure of Success Criterion 1.1.1 due to using CSS to include images that convey important information",
"WCAG_2.0-F4", "2.2.2 F4: Failure of Success Criterion 2.2.2 due to using text-decoration:blink without a mechanism to stop it in less than five seconds",
"WCAG_2.0-F16", "2.2.2 F16: Failure of Success Criterion 2.2.2 due to including scrolling content where movement is not essential to the activity without also including a mechanism to pause and restart the content",
"WCAG_2.0-F17", "1.3.1, 4.1.1 F17: Failure of Success Criterion 1.3.1 and 4.1.1 due to insufficient information in DOM to determine one-to-one relationships (e.g. between labels with same id) in HTML",
"WCAG_2.0-F25", "2.4.2 F25: Failure of Success Criterion 2.4.2 due to the title of a Web page not identifying the contents",
"WCAG_2.0-F30", "1.1.1, 1.2.1 F30: Failure of Success Criterion 1.1.1 and 1.2.1 due to using text alternatives that are not alternatives",
"WCAG_2.0-F32", "1.3.2 F32: Failure of Success Criterion 1.3.2 due to using white space characters to control spacing within a word",
"WCAG_2.0-F38", "1.1.1 F38: Failure of Success Criterion 1.1.1 due to omitting the alt-attribute for non-text content used for decorative purposes only in HTML",
"WCAG_2.0-F39", "1.1.1 F39: Failure of Success Criterion 1.1.1 due to providing a text alternative that is not null (e.g., alt='spacer' or alt='image') for images that should be ignored by assistive technology",
"WCAG_2.0-F40", "2.2.1, 2.2.4 F40: Failure of Success Criterion 2.2.1 and 2.2.4 due to using meta redirect with a time limit",
"WCAG_2.0-F41", "2.2.1, 2.2.4, 3.2.5 F41: Failure of Success Criterion 2.2.1, 2.2.4 and 3.2.5 due to using meta refresh with a time limit",
"WCAG_2.0-F42", "1.3.1, 2.1.1 F42: Failure of Success Criterion 1.3.1 and 2.1.1 due to using scripting events to emulate links in a way that is not programmatically determinable",
"WCAG_2.0-F43", "1.3.1 F43: Failure of Success Criterion 1.3.1 due to using structural markup in a way that does not represent relationships in the content",
"WCAG_2.0-F47", "2.2.2 F47: Failure of Success Criterion 2.2.2 due to using the blink element",
"WCAG_2.0-F54", "2.1.1 F54: Failure of Success Criterion 2.1.1 due to using only pointing-device-specific event handlers (including gesture) for a function",
"WCAG_2.0-F55", "2.1.1, 2.4.7, 3.2.1 F55: Failure of Success Criteria 2.1.1, 2.4.7, and 3.2.1 due to using script to remove focus when focus is received",
"WCAG_2.0-F58", "2.2.1 F58: Failure of Success Criterion 2.2.1 due to using server-side techniques to automatically redirect pages after a time-out",
#
# F62: Failure of Success Criterion 1.3.1 and 4.1.1 due to insufficient
#      information in DOM to determine specific relationships in XML
#      Failures of this technique are reported under technique F77
#
"WCAG_2.0-F65", "1.1.1 F65: Failure of Success Criterion 1.1.1 due to omitting the alt attribute on img elements, area elements, and input elements of type \"image\"",
"WCAG_2.0-F66", "3.2.3 F66: Failure of Success Criterion 3.2.3 due to presenting navigation links in a different relative order on different pages",
"WCAG_2.0-F68", "1.3.1, 4.1.2 F68: Failure of Success Criterion 1.3.1 and 4.1.2 due to the association of label and user interface controls not being programmatically determinable",
"WCAG_2.0-F70", "4.1.1 F70: Failure of Success Criterion 4.1.1 due to incorrect use of start and end tags or attribute markup",
"WCAG_2.0-F77", "4.1.1 F77: Failure of Success Criterion 4.1.1 due to duplicate values of type ID",
#
# F80: Failure of Success Criterion 1.4.4 when text-based form controls 
#      do not resize when visually rendered text is resized up to 200%
#      Failures of this technique are reported under technique C28
#
# F86: Failure of Success Criterion 4.1.2 due to not providing names for 
#      each part of a multi-part form field, such as a US telephone number
#      Failures of this technique are reported under technique H44
#
"WCAG_2.0-F87", "1.3.1 F87: Failure of Success Criterion 1.3.1 due to inserting non-decorative content by using :before and :after pseudo-elements and the 'content' property in CSS",
"WCAG_2.0-F89", "2.4.4, 2.4.9, 4.1.2 F89: Failure of Success Criteria 2.4.4, 2.4.9 and 4.1.2 due to using null alt on an image where the image is the only content in a link",
#
# G4: Allowing the content to be paused and restarted from where it was paused
#     Failures of this technique are reported under techniques F16
#
"WCAG_2.0-G18", "1.4.3 G18: Ensuring that a contrast ratio of at least 4.5:1 exists between text (and images of text) and background behind the text",
"WCAG_2.0-G19", "2.3.1 G19: Ensuring that no component of the content flashes more than three times in any 1-second period",
#
# G80: Providing a submit button to initiate a change of context
#      Failures of this technique are reported under technique H32
#
#
# G88: Providing descriptive titles for Web pages
#      Failures of this technique are reported under technique H25, PDF18
#
# G90: Providing keyboard-triggered event handlers
#      Failures of this technique are reported under technique SCR20
#
#"WCAG_2.0-G94", "1.1.1 G94: Providing short text alternative for non-text content that serves the same purpose and presents the same information as the non-text content",
"WCAG_2.0-G115", "1.3.1 G115: Using semantic elements to mark up structure",
"WCAG_2.0-G125", "2.4.5 G125: Providing links to navigate to related Web pages",
"WCAG_2.0-G130", "2.4.6 G130: Providing descriptive headings",
"WCAG_2.0-G134", "4.1.1 G134: Validating Web pages",
#
# Advisory technique
#
#"WCAG_2.0-G141", "1.3.1 G141: Organizing a page using headings",
#
"WCAG_2.0-G142", "1.4.4 G142: Using a technology that has commonly-available user agents that support zoom",
"WCAG_2.0-G145", "1.4.3 G145: Ensuring that a contrast ratio of at least 3:1 exists between text (and images of text) and background behind the text",
"WCAG_2.0-G152", "2.2.2 G152: Setting animated gif images to stop blinking after n cycles (within 5 seconds)",
#
# G162: Positioning labels to maximize predictability of relationships
#       Failures of this technique are reported under technique H44
#
# G192: Fully conforming to specifications
#      Failures of this technique are reported under technique G143
#
"WCAG_2.0-G197", "3.2.4 G197: Using labels, names, and text alternatives consistently for content that has the same functionality",
"WCAG_2.0-H2", "1.1.1 H2: Combining adjacent image and text links for the same resource",
"WCAG_2.0-H24", "1.1.1, 2.4.4 H24: Providing text alternatives for the area elements of image maps",
"WCAG_2.0-H25", "2.4.2 H25: Providing a title using the title element",
"WCAG_2.0-H27", "1.1.1 H27: Providing text and non-text alternatives for object",
"WCAG_2.0-H30", "1.1.1, 2.4.4 H30: Providing link text that describes the purpose of a link for anchor elements",
"WCAG_2.0-H32", "3.2.2 H32: Providing submit buttons",
"WCAG_2.0-H33", "2.4.4 H33: Supplementing link text with the title attribute",
"WCAG_2.0-H35", "1.1.1 H35: Providing text alternatives on applet elements",
"WCAG_2.0-H36", "1.1.1 H36: Using alt attributes on images used as submit buttons",
#"WCAG_2.0-H37", "1.1.1 H37: Using alt attributes on img elements",
"WCAG_2.0-H39", "1.3.1 H39: Using caption elements to associate data table captions with data tables",
"WCAG_2.0-H42", "1.3.1 H42: Using h1-h6 to identify headings",
"WCAG_2.0-H43", "1.3.1 H43: Using id and headers attributes to associate data cells with header cells in data tables",
"WCAG_2.0-H44", "1.1.1, 1.3.1, 3.3.2, 4.1.2 H44: Using label elements to associate text labels with form controls",
"WCAG_2.0-H45", "1.1.1 H45: Using longdesc",
"WCAG_2.0-H46", "1.1.1 H46: Using noembed with embed",
"WCAG_2.0-H48", "1.3.1 H48: Using ol, ul and dl for lists or groups of links",
"WCAG_2.0-H51", "1.3.1 H51: Using table markup to present tabular information",
"WCAG_2.0-H53", "1.1.1, 1.2.3 H53: Using the body of the object element",
"WCAG_2.0-H57", "3.1.1 H57: Using language attributes on the html element",
"WCAG_2.0-H58", "3.1.2 H58: Using language attributes to identify changes in the human language",
"WCAG_2.0-H64", "2.4.1, 4.1.2 H64: Using the title attribute of the frame and iframe elements",
"WCAG_2.0-H65", "1.3.1, 3.3.2, 4.1.2 H65: Using the title attribute to identify form controls when the label element cannot be used",
"WCAG_2.0-H67", "1.1.1 H67: Using null alt text and no title attribute on img elements for images that AT should ignore",
"WCAG_2.0-H71", "1.3.1, 3.3.2 H71: Providing a description for groups of form controls using fieldset and legend elements",
"WCAG_2.0-H73", "1.3.1 H73: Using the summary attribute of the table element to give an overview of data tables",
"WCAG_2.0-H74", "4.1.1 H74: Ensuring that opening and closing tags are used according to specification",
#
# H75: Ensuring that Web pages are well-formed
#      Failures of this technique are reported under technique G143
#
"WCAG_2.0-H88", "4.1.1, 4.1.2 H88: Using HTML according to spec",
"WCAG_2.0-H91", "2.1.1, 4.1.2 H91: Using HTML form controls and links",
#
# H93: Ensuring that id attributes are unique on a Web page
#      Failures of this technique are reported under technique F77
#
"WCAG_2.0-H94", "4.1.1 H94: Ensuring that elements do not contain duplicate attributes",
"WCAG_2.0-PDF1", "1.1.1 PDF1: Applying text alternatives to images with the Alt entry in PDF documents",
"WCAG_2.0-PDF2", "2.4.5 PDF2: Creating bookmarks in PDF documents",
"WCAG_2.0-PDF6", "1.3.1 PDF6: Using table elements for table markup in PDF Documents",
"WCAG_2.0-PDF12", "1.3.1, 4.1.2 PDF12: Providing name, role, value information for form fields in PDF documents",
"WCAG_2.0-PDF16", "3.1.1 PDF16: Setting the default language using the /Lang entry in the document catalog of a PDF document",
"WCAG_2.0-PDF18", "2.4.2 PDF18: Specifying the document title using the Title entry in the document information dictionary of a PDF document",
"WCAG_2.0-SC3.1.1", "3.1.1 SC3.1.1: Language of Page",
#
# SCR2: Using redundant keyboard and mouse event handlers
#       Failures of this technique are reported under technique SCR20
#
"WCAG_2.0-SCR20", "2.1.1 SCR20: Using both keyboard and other device-specific functions",
"WCAG_2.0-SCR21", "1.3.1 SCR21: Using functions of the Document Object Model (DOM) to add content to a page",
);

my (%testcase_description_fr) = (
#
# WCAG 2.0
#  Text taken from http://www.braillenet.org/accessibilite/comprendre-wcag20/CAT20110222/Overview.html
#
# C12: Using percent for font sizes 
#      Failures of this technique are reported under technique G142
# C13: Using named font sizes
#      Failures of this technique are reported under technique G142
# C14: Using em units for font sizes
#      Failures of this technique are reported under technique G142
#
"WCAG_2.0-C28", "1.4.4 C28: Sp�cifier la taille des conteneurs de texte en utilisant des unit�s em",
"WCAG_2.0-F3", "1.1.1 F3: �chec du crit�re de succ�s 1.1.1 consistant � utiliser les CSS pour inclure une image qui v�hicule une information importante",
"WCAG_2.0-F4", "2.2.2 F4: �chec du crit�re de succ�s 2.2.2 consistant � utiliser text-decoration:blink sans m�canisme pour l'arr�ter en moins de 5 secondes",
"WCAG_2.0-F16", "2.2.2 F16: �chec du crit�re de succ�s 2.2.2 consistant � inclure un contenu d�filant lorsque le mouvement n'est pas essentiel � l'activit� sans inclure aussi un m�canisme pour mettre ce contenu en pause et pour le red�marrer",
"WCAG_2.0-F17", "1.3.1, 4.1.1 F17: �chec du crit�re de succ�s 1.3.1 et 4.1.1 li� � l'insuffisance d'information dans le DOM pour d�terminer des relations univoques en HTML (par exemple entre les �tiquettes ayant un m�me id)",
"WCAG_2.0-F25", "2.4.2 F25: �chec du crit�re de succ�s 2.4.2 survenant quand le titre de la page Web n'identifie pas son contenu",
"WCAG_2.0-F30", "1.1.1, 1.2.1 F30: �chec du crit�re de succ�s 1.1.1 et 1.2.1 consistant � utiliser un �quivalent textuel qui n'est pas �quivalent (par exemple nom de fichier ou texte par d�faut)",
"WCAG_2.0-F32", "1.3.2 F32: �chec du crit�re de succ�s 1.3.2 consistant � utiliser des caract�res blancs pour contr�ler l'espacement � l'int�rieur d'un mot",
"WCAG_2.0-F38", "1.1.1 F38: �chec du crit�re de succ�s 1.1.1 consistant � omettre l'attribut alt pour un contenu non textuel utilis� de fa�on d�corative, seulement en HTML",
"WCAG_2.0-F39", "1.1.1 F39: �chec du crit�re de succ�s 1.1.1 consistant � fournir un �quivalent textuel non vide (par exemple alt='espaceur' ou alt='image') pour des images qui doivent �tre ignor�es par les technologies d'assistance",
"WCAG_2.0-F40", "2.2.1, 2.2.4 F40: �chec du crit�re de succ�s 2.2.1 et 2.2.4 consistant � utiliser une redirection meta avec un d�lai",
"WCAG_2.0-F41", "2.2.1, 2.2.4, 3.2.5 F41: �chec du crit�re de succ�s 2.2.1, 2.2.4 et 3.2.5 consistant � utiliser meta refresh avec un d�lai",
"WCAG_2.0-F42", "1.3.1, 2.1.1 F42: �chec du crit�re de succ�s 1.3.1 et 2.1.1 consistant � utiliser des �v�nements de scripts pour �muler des liens d'une mani�re qui n'est pas d�terminable par un programme informatique",
"WCAG_2.0-F43", "1.3.1 F43: �chec du crit�re de succ�s 1.3.1 consistant � utiliser un balisage structurel d'une fa�on qui ne repr�sente pas les relations � l'int�rieur du contenu",
"WCAG_2.0-F47", "2.2.2 F47: �chec du crit�re de succ�s 2.2.2 consistant � utiliser l'�l�ment 'blink'",
"WCAG_2.0-F54", "2.1.1 F54: �chec du crit�re de succ�s 2.1.1 consistant � utiliser seulement des �v�nements au pointeur (y compris par geste) pour une fonction",
"WCAG_2.0-F55", "2.1.1, 2.4.7, 3.2.1 F55: �chec du crit�re de succ�s 2.1.1, 2.4.7 et 3.2.1 consistant � utiliser un script pour enlever le focus lorsque le focus est re�u",
"WCAG_2.0-F58", "2.2.1 F58: �chec du crit�re de succ�s 2.2.2 consistant � utiliser une technique c�t� serveur pour automatiquement rediriger la page apr�s un arr�t",
#
# F62: Failure of Success Criterion 1.3.1 and 4.1.1 due to insufficient
#      information in DOM to determine specific relationships in XML
#      Failures of this technique are reported under technique F77
#
"WCAG_2.0-F65", "1.1.1 F65: �chec du crit�re de succ�s 1.1.1 consistant � omettre l'attribut 'alt' sur les �l�ments <img>, <area> et <input> de type 'image'",
"WCAG_2.0-F66", "3.2.3 F66: �chec du crit�re de succ�s 3.2.3 consistant � pr�senter les liens de navigation dans un ordre relatif diff�rent sur diff�rentes pages",
"WCAG_2.0-F68", "1.3.1, 4.1.2 F68: �chec du crit�re de succ�s 1.3.1 et 4.1.2 li� au fait que l'association entre l'�tiquette et le composant d'interface utilisateur n'est pas d�terminable par programmation",
"WCAG_2.0-F70", "4.1.1 F70: �chec du crit�re de succ�s 4.1.1 li� � l'ouverture et � la fermeture incorrecte des balises et des attributs",
"WCAG_2.0-F77", "4.1.1 F77: �chec du crit�re de succ�s 4.1.1 li� � la duplication des valeurs de type ID",
#
# F80: Failure of Success Criterion 1.4.4 when text-based form controls
#      do not resize when visually rendered text is resized up to 200%
#      Failures of this technique are reported under technique C28
#
# F86: Failure of Success Criterion 4.1.2 due to not providing names for 
#      each part of a multi-part form field, such as a US telephone number
#      Failures of this technique are reported under technique H44
#
"WCAG_2.0-F87", "1.3.1 F87: �chec du crit�re de succ�s 1.3.1 consistant � utiliser les pseudo-�l�ments :before et :after et la propri�t� content en CSS",
"WCAG_2.0-F89", "2.4.4, 2.4.9, 4.1.2 F89: �chec du crit�re de succ�s 2.4.4, 2.4.9 et 4.1.2 consistant � utiliser un attribut alt vide pour une image qui est le seul contenu d'un lien",
#
# G4: Allowing the content to be paused and restarted from where it was paused
#     Failures of this technique are reported under techniques F16
#
"WCAG_2.0-G18", "1.4.3 G18: S'assurer qu'un rapport de contraste d'au moins 4,5 pour 1 existe entre le texte (et le texte sous forme d'image) et l'arri�re-plan du texte",
"WCAG_2.0-G19", "2.3.1 G19: S'assurer qu'aucun composant du contenu ne flashe plus de 3 fois dans une m�me p�riode d'une seconde",
#
# G80: Providing a submit button to initiate a change of context
#      Failures of this technique are reported under technique H32
#
#
# G88: Providing descriptive titles for Web pages
#      Failures of this technique are reported under technique H25, PDF18
#
# G90: Providing keyboard-triggered event handlers
#      Failures of this technique are reported under technique SCR20
#
#"WCAG_2.0-G94", "1.1.1 G94: Fournir un court �quivalent textuel pour un contenu non textuel qui a la m�me fonction et pr�sente la m�me information que le contenu non textuel",
"WCAG_2.0-G115", "1.3.1 G115: Utiliser les �l�ments s�mantiques pour baliser la structure",
"WCAG_2.0-G125", "2.4.5 G125: Fournir des liens de navigation vers les pages Web reli�es",
"WCAG_2.0-G130", "2.4.6 G130: Fournir des en-t�tes de section descriptifs",
"WCAG_2.0-G134", "4.1.1 G134: Valider les pages Web",
#
# Advisory technique
#
#"WCAG_2.0-G141", "1.3.1 G141: Organiser une page en utilisant les en-t�tes de section",
#
"WCAG_2.0-G142", "1.4.4 G142: Gr�ce � une technologie qui a des agents utilisateurs couramment disponibles � l'appui de zoom",
"WCAG_2.0-G145", "1.4.3 G145: S'assurer qu'un rapport de contraste d'au moins 3 pour 1 existe entre le texte (et le texte sous forme d'image) et l'arri�re-plan du texte",
"WCAG_2.0-G152", "2.2.2 G152: Configurer les gifs anim�s pour qu'ils s'arr�tent de clignoter apr�s n cycles (pendant 5 secondes)",
#
# G162: Positioning labels to maximize predictability of relationships
#       Failures of this technique are reported under technique H44
#
# G192: Fully conforming to specifications
#      Failures of this technique are reported under technique G143
#
"WCAG_2.0-G197", "3.2.4 G197: Utiliser les �tiquettes, les noms et les �quivalents textuels de fa�on coh�rente pour des contenus ayant la m�me fonctionnalit�",
"WCAG_2.0-H2", "1.1.1 H2: Combiner en un m�me lien une image et un intitul� de lien pour la m�me ressource",
"WCAG_2.0-H24", "1.1.1, 2.4.4 H24: Fournir un �quivalent textuel pour l'�l�ment area d'une image � zones cliquables",
"WCAG_2.0-H25", "2.4.2 H25: H25 : Donner un titre � l'aide de l'�l�ment <title>",
"WCAG_2.0-H27", "1.1.1 H27: Fournir un �quivalent textuel et non textuel pour un objet",
"WCAG_2.0-H30", "1.1.1, 2.4.4 H30: Fournir un intitul� de lien qui d�crit la fonction du lien pour un �l�ment <anchor>",
"WCAG_2.0-H32", "3.2.2 H32: Fournir un bouton 'submit'",
"WCAG_2.0-H33", "2.4.4 H33: Compl�ter l'intitul� du lien � l'aide de l'attribut title",
"WCAG_2.0-H35", "1.1.1 H35: Fournir un �quivalent textuel pour l'�l�ment <applet>",
"WCAG_2.0-H36", "1.1.1 H36: Utiliser un attribut alt sur une image utilis�e comme bouton soumettre",
#"WCAG_2.0-H37", "1.1.1 H37: Utilisation des attributs 'alt' avec les �l�ments <img>",
"WCAG_2.0-H39", "1.3.1 H39: Utiliser l'�l�ment 'caption' pour associer un titre de tableau avec les donn�es du tableau",
"WCAG_2.0-H42", "1.3.1 H42: Utiliser h1-h6 pour identifier les en-t�tes de section",
"WCAG_2.0-H43", "1.3.1 H43: Utiliser les attributs 'id' et 'headers' pour associer les cellules de donn�es avec les cellules d'en-t�tes dans les tableaux de donn�es",
"WCAG_2.0-H44", "1.1.1, 1.3.1, 3.3.2, 4.1.2 H44: Utiliser l'�l�ment <label> pour associer les �tiquettes avec les champs de formulaire",
"WCAG_2.0-H45", "1.1.1 H45: Utiliser 'longdesc'",
"WCAG_2.0-H46", "1.1.1 H46: Utiliser <noembed> avec <embed>",
"WCAG_2.0-H48", "1.3.1 H48: Utiliser ol, ul et dl pour les listes",
"WCAG_2.0-H51", "1.3.1 H51: Utiliser le balisage des tableaux pour pr�senter l'information tabulaire",
"WCAG_2.0-H53", "1.1.1, 1.2.3 H53: Utiliser le corps de l'�l�ment <object>",
"WCAG_2.0-H57", "3.1.1 H57: Utiliser les attributs de langue dans l'�l�ment <html>",
"WCAG_2.0-H58", "3.1.2 H58: Utiliser les attributs de langue pour identifier les changements de langue",
"WCAG_2.0-H64", "2.4.1, 4.1.2 H64: Utiliser l'attribut 'title' des �l�ments <frame> et <iframe>",
"WCAG_2.0-H65", "1.3.1, 3.3.2, 4.1.2 H65: Utiliser l'attribut 'title' pour identifier un champ de formulaire quand l'�l�ment <label> ne peut pas �tre utilis�",
"WCAG_2.0-H67", "1.1.1 H67: Utiliser un attribut alt vide sans attribut title sur un �l�ment img pour les images qui doivent �tre ignor�es par les technologies d'assistance",
"WCAG_2.0-H71", "1.3.1, 3.3.2 H71: Fournir une description des groupes de champs � l'aide des �l�ments <fieldset> et <legend>",
"WCAG_2.0-H73", "1.3.1 H73: Utiliser l'attribut 'summary' de l'�l�ment <table> pour donner un aper�u d'un tableau de donn�es",
"WCAG_2.0-H74", "4.1.1 H74: S'assurer que les balises d'ouverture et de fermeture sont utilis�es conform�ment aux sp�cifications",
#
# H75: Ensuring that Web pages are well-formed
#      Failures of this technique are reported under technique G143
#
"WCAG_2.0-H88", "4.1.1, 4.1.2 H88: Utiliser HTML conform�ment aux sp�cifications",
"WCAG_2.0-H91", "2.1.1, 4.1.2 H91: Utiliser des �l�ments de formulaire et des liens HTML",
#
# H93: Ensuring that id attributes are unique on a Web page
#      Failures of this technique are reported under technique F77
#
"WCAG_2.0-H94", "4.1.1 H94: S'assurer que les �l�ments ne contiennent pas d'attributs dupliqu�s",
"WCAG_2.0-PDF1", "1.1.1 PDF1�: Application d��quivalents textuels aux images au moyen de l�entr�e Alt dans les documents PDF",
"WCAG_2.0-PDF2", "2.4.5 PDF2�: Cr�ation de signets dans les documents PDF",
"WCAG_2.0-PDF6", "1.3.1 PDF6�: Utilisation d��l�ments de table pour le balisage des tables dans les documents PDF",
"WCAG_2.0-PDF12", "1.3.1, 4.1.2 PDF12�: Fourni le nom, le r�le, la valeur des renseignements des champs de formulaire des documents PDF",
"WCAG_2.0-PDF16", "3.1.1 PDF16�: R�gle la langue par d�faut au moyen de l�entr�e /Lang dans le catalogue de document d�un document PDF",
"WCAG_2.0-PDF18", "2.4.2 PDF18�: Pr�cise le titre du document au moyen de l�entr�e du dictionnaire d�informations du document d�un document PDF",
"WCAG_2.0-SC3.1.1", "3.1.1 SC3.1.1: Langue de la page",
#
# SCR2: Using redundant keyboard and mouse event handlers
#       Failures of this technique are reported under technique SCR20
#
"WCAG_2.0-SCR20", "2.1.1 SCR20: Utiliser � la fois des fonctions au clavier et sp�cifiques � d'autres p�riph�riques",
"WCAG_2.0-SCR21", "1.3.1 SCR21: Utiliser les fonctions du mod�le objet de document (DOM) pour ajouter du contenu � la page",
);

#
# Default messages to English
#
my ($testcase_description_table) = \%testcase_description_en;

#
# Create table of testcase id and the list of test groups.
# This is a mapping of technique to success criterion for WCAG 2.0
#
my (%testcase_groups_table) = (
"WCAG_2.0-C28", "1.4.4",
"WCAG_2.0-F3", "1.1.1",
"WCAG_2.0-F4", "2.2.2",
"WCAG_2.0-F16", "2.2.2",
"WCAG_2.0-F17", "1.3.1, 4.1.1",
"WCAG_2.0-F25", "2.4.2",
"WCAG_2.0-F30", "1.1.1, 1.2.1",
"WCAG_2.0-F32", "1.3.2",
"WCAG_2.0-F38", "1.1.1",
"WCAG_2.0-F39", "1.1.1",
"WCAG_2.0-F40", "2.2.1, 2.2.4",
"WCAG_2.0-F41", "2.2.1, 2.2.4, 3.2.5",
"WCAG_2.0-F42", "1.3.1, 2.1.1",
"WCAG_2.0-F43", "1.3.1",
"WCAG_2.0-F47", "2.2.2",
"WCAG_2.0-F54", "2.1.1",
"WCAG_2.0-F55", "2.1.1, 2.4.7, 3.2.1",
"WCAG_2.0-F58", "2.2.1",
"WCAG_2.0-F65", "1.1.1",
"WCAG_2.0-F66", "3.2.3",
"WCAG_2.0-F68", "1.3.1, 4.1.2",
"WCAG_2.0-F70", "4.1.1",
"WCAG_2.0-F77", "4.1.1",
"WCAG_2.0-F87", "1.3.1",
"WCAG_2.0-F89", "2.4.4, 4.1.2",
"WCAG_2.0-G18", "1.4.3",
"WCAG_2.0-G19", "2.3.1",
#"WCAG_2.0-G94", "1.1.1",
"WCAG_2.0-G115", "1.3.1",
"WCAG_2.0-G125", "2.4.5",
"WCAG_2.0-G130", "2.4.6",
"WCAG_2.0-G134", "4.1.1",
"WCAG_2.0-G142", "1.4.4",
"WCAG_2.0-G145", "1.4.3",
"WCAG_2.0-G152", "2.2.2",
"WCAG_2.0-G197", "3.2.4",
"WCAG_2.0-H2", "1.1.1",
"WCAG_2.0-H24", "1.1.1, 2.4.4",
"WCAG_2.0-H25", "2.4.2",
"WCAG_2.0-H27", "1.1.1",
"WCAG_2.0-H30", "1.1.1, 2.4.4",
"WCAG_2.0-H32", "3.2.2",
"WCAG_2.0-H33", "2.4.4",
"WCAG_2.0-H35", "1.1.1",
"WCAG_2.0-H36", "1.1.1",
"WCAG_2.0-H39", "1.3.1",
"WCAG_2.0-H42", "1.3.1",
"WCAG_2.0-H43", "1.3.1",
"WCAG_2.0-H44", "1.1.1, 1.3.1, 3.3.2, 4.1.2",
"WCAG_2.0-H45", "1.1.1",
"WCAG_2.0-H46", "1.1.1",
"WCAG_2.0-H48", "1.3.1",
"WCAG_2.0-H53", "1.1.1, 1.2.3",
"WCAG_2.0-H57", "3.1.1",
"WCAG_2.0-H58", "3.1.2",
"WCAG_2.0-H64", "2.4.1, 4.1.2",
"WCAG_2.0-H65", "1.3.1, 3.3.2, 4.1.2",
"WCAG_2.0-H67", "1.1.1",
"WCAG_2.0-H71", "1.3.1, 3.3.2",
"WCAG_2.0-H73", "1.3.1",
"WCAG_2.0-H74", "4.1.1",
"WCAG_2.0-H88", "4.1.1, 4.1.2",
"WCAG_2.0-H91", "2.1.1, 4.1.2",
"WCAG_2.0-H94", "4.1.1",
"WCAG_2.0-PDF1", "1.1.1",
"WCAG_2.0-PDF2", "2.4.5",
"WCAG_2.0-PDF2", "1.3.1",
"WCAG_2.0-PDF12", "1.3.1, 4.1.2",
"WCAG_2.0-PDF16", "3.1.1",
"WCAG_2.0-PDF18", "2.4.2",
"WCAG_2.0-SC3.1.1", "3.1.1",
"WCAG_2.0-SCR20", "2.1.1",
"WCAG_2.0-SCR21", "1.3.1",
);

#
# Table of number of testcase groups for testcase profile types
#
my (%testcase_group_counts) = (
"WCAG_2.0", 38,
);

#
# Create reverse table, indexed by description
#
my (%reverse_testcase_description_en) = reverse %testcase_description_en;
my (%reverse_testcase_description_fr) = reverse %testcase_description_fr;
my ($reverse_testcase_description_table) = \%reverse_testcase_description_en;

#
#******************************************************************
#
# String table for testcase help URLs
#
#******************************************************************
#

my (%testcase_url_en, %testcase_url_fr);

#
# Default URLs to English
#
my ($url_table) = \%testcase_url_en;

#***********************************************************************
#
# Name: TQA_Testcase_Debug
#
# Parameters: this_debug - debug flag
#
# Description:
#
#   This function sets the package global debug flag.
#
#***********************************************************************
sub TQA_Testcase_Debug {
    my ($this_debug) = @_;

    #
    # Copy debug value to global variable
    #
    $debug = $this_debug;
}

#**********************************************************************
#
# Name: TQA_Testcase_Language
#
# Parameters: language
#
# Description:
#
#   This function sets the language of testcase description messages.
#
#***********************************************************************
sub TQA_Testcase_Language {
    my ($language) = @_;


    #
    # Check for French language
    #
    if ( $language =~ /^fr/i ) {
        print "TQA_Testcase_Language, language = French\n" if $debug;
        $testcase_description_table = \%testcase_description_fr;
        $reverse_testcase_description_table = \%reverse_testcase_description_fr;
        $url_table = \%testcase_url_fr;
    }
    else {
        #
        # Default language is English
        #
        print "TQA_Testcase_Language, language = English\n" if $debug;
        $testcase_description_table = \%testcase_description_en;
        $reverse_testcase_description_table = \%reverse_testcase_description_en;
        $url_table = \%testcase_url_en;
    }
}

#**********************************************************************
#
# Name: TQA_Testcase_Description
#
# Parameters: key - testcase id
#
# Description:
#
#   This function returns the value in the testcase description 
# table for the specified key.  If there is no entry in the table an error
# string is returned.
#
#**********************************************************************
sub TQA_Testcase_Description {
    my ($key) = @_;

    #
    # Do we have a testcase description table entry for this key ?
    #
    if ( defined($$testcase_description_table{$key}) ) {
        #
        # return value
        #
        return ($$testcase_description_table{$key});
    }
    else {
        #
        # No testcase description table entry, either we are missing
        # a string or we have a typo in the key name.
        #
        return ("*** No string for $key ***");
    }
}

#**********************************************************************
#
# Name: TQA_Testcase_Groups
#
# Parameters: key - testcase id
#
# Description:
#
#   This function returns the value in the testcase group
# table for the specified key.  If there is no entry in the table an 
# empty string is returned.
#
#**********************************************************************
sub TQA_Testcase_Groups {
    my ($key) = @_;

    #
    # Do we have a testcase group entry for this key ?
    #
    if ( defined($testcase_groups_table{$key}) ) {
        #
        # return value
        #
        return($testcase_groups_table{$key});
    }
    else {
        #
        # No testcase group table entry, return empty string.
        #
        return("");
    }
}

#**********************************************************************
#
# Name: TQA_Testcase_Group_Count
#
# Parameters: key - group type
#
# Description:
#
#   This function returns the value in the testcase group count
# table for the specified key.  If there is no entry in the table an
# empty string is returned.
#
#**********************************************************************
sub TQA_Testcase_Group_Count {
    my ($key) = @_;

    #
    # Do we have a testcase group count entry for this key ?
    #
    if ( defined($testcase_group_counts{$key}) ) {
        #
        # return value
        #
        return($testcase_group_counts{$key});
    }
    else {
        #
        # No testcase group count table entry, return empty string.
        #
        return("");
    }
}

#**********************************************************************
#
# Name: TQA_Testcase_URL
#
# Parameters: key - testcase id
#
# Description:
#
#   This function returns the value in the testcase URL 
# table for the specified key.
#
#**********************************************************************
sub TQA_Testcase_URL {
    my ($key) = @_;

    #
    # Do we have a string table entry for this key ?
    #
    print "TQA_Testcase_URL, key = $key\n" if $debug;
    if ( defined($$url_table{$key}) ) {
        #
        # return value
        #
        print "value = " . $$url_table{$key} . "\n" if $debug;
        return ($$url_table{$key});
    }
    #
    # Was the testcase description provided rather than the testcase
    # identifier ?
    #
    elsif ( defined($$reverse_testcase_description_table{$key}) ) {
        #
        # return value
        #
        $key = $$reverse_testcase_description_table{$key};
        print "value = " . $$url_table{$key} . "\n" if $debug;
        return ($$url_table{$key});
    }
    else {
        #
        # No string table entry, either we are missing a string or
        # we have a typo in the key name.
        #
        return;
    }
}

#**********************************************************************
#
# Name: TQA_Testcase_Read_URL_Help_File
#
# Parameters: filename - path to help file
#
# Description:
#
#   This function reads a testcase help file.  The file contains
# a list of testcases and the URL of a help page or standard that
# relates to the testcase.  A language field allows for English & French
# URLs for the testcase.
#
#**********************************************************************
sub TQA_Testcase_Read_URL_Help_File {
    my ($filename) = @_;

    my (@fields, $tcid, $lang, $url);

    #
    # Clear out any existing testcase/url information
    #
    %testcase_url_en = ();
    %testcase_url_fr = ();

    #
    # Check to see that the help file exists
    #
    if ( !-f "$filename" ) {
        print "Error: Missing URL help file\n" if $debug;
        print " --> $filename\n" if $debug;
        return;
    }

    #
    # Open configuration file at specified path
    #
    print "TQA_Testcase_Read_URL_Help_File Openning file $filename\n" if $debug;
    if ( ! open(HELP_FILE, "$filename") ) {
        print "Failed to open file\n" if $debug;
        return;
    }

    #
    # Read file looking for testcase, language and URL
    #
    while (<HELP_FILE>) {
        #
        # Ignore comment and blank lines.
        #
        chop;
        if ( /^#/ ) {
            next;
        }
        elsif ( /^$/ ) {
            next;
        }

        #
        # Split the line into fields.
        #
        @fields = split(/\s+/, $_, 3);

        #
        # Did we get 3 fields ?
        #
        if ( @fields == 3 ) {
            $tcid = $fields[0];
            $lang = $fields[1];
            $url  = $fields[2];
            print "Add Testcase/URL mapping $tcid, $lang, $url\n" if $debug;

            #
            # Do we have an English URL ?
            #
            if ( $lang =~ /eng/i ) {
                $testcase_url_en{$tcid} = $url;
                $reverse_testcase_description_en{$url} = $tcid;
            }
            #
            # Do we have a French URL ?
            #
            elsif ( $lang =~ /fra/i ) {
                $testcase_url_fr{$tcid} = $url;
                $reverse_testcase_description_fr{$url} = $tcid;
            }
            else {
                print "Unknown language $lang\n" if $debug;
            }
        }
        else {
            print "Line does not contain 3 fields, ignored: \"$_\"\n" if $debug;
        }
    }
    
    #
    # Close configuration file
    #
    close(HELP_FILE);
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
# Name:   tqa_testcases.pm
#
# $Revision: 6874 $
# $URL: svn://10.36.20.226/trunk/Web_Checks/TQA_Check/Tools/tqa_testcases.pm $
# $Date: 2014-12-03 16:06:09 -0500 (Wed, 03 Dec 2014) $
#
# Description:
#
#   This file contains routines that handle TQA testcase descriptions.
#
# Public functions:
#     TQA_Testcase_Language
#     TQA_Testcase_Debug
#     TQA_Testcase_Description
#     TQA_Testcase_Groups
#     TQA_Testcase_Group_Count
#     TQA_Testcase_Read_URL_Help_File
#     TQA_Testcase_URL
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

package tqa_testcases;

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
    @EXPORT  = qw(TQA_Testcase_Language
                  TQA_Testcase_Debug
                  TQA_Testcase_Description
                  TQA_Testcase_Groups
                  TQA_Testcase_Group_Count
                  TQA_Testcase_Read_URL_Help_File
                  TQA_Testcase_URL
                  );
    $VERSION = "1.0";
}

#***********************************************************************
#
# File Local variable declarations
#
#***********************************************************************

my ($debug) = 0;

#
# String tables for testcase ID to testcase descriptions
#
my (%testcase_description_en) = (
#
# WCAG 2.0
#
"WCAG_2.0-ARIA1", "2.4.2, 2.4.4, 3.3.2 ARIA1: Using the aria-describedby property to provide a descriptive label for user interface controls",
"WCAG_2.0-ARIA2", "3.3.2, 3.3.3 ARIA2: Identifying a required field with the aria-required property",
"WCAG_2.0-ARIA6", "1.1.1 ARIA6: Using aria-label to provide labels for objects",
"WCAG_2.0-ARIA7", "2.4.4 ARIA7: Using aria-labelledby for link purpose",
"WCAG_2.0-ARIA8", "2.4.4 ARIA8: Using aria-label for link purpose",
"WCAG_2.0-ARIA9", "1.1.1, 3.3.2 ARIA9: Using aria-labelledby to concatenate a label from several text nodes",
"WCAG_2.0-ARIA10", "1.1.1 ARIA10: Using aria-labelledby to provide a text alternative for non-text content",
"WCAG_2.0-ARIA12", "1.3.1 ARIA12: Using role=heading to identify headings",
"WCAG_2.0-ARIA13", "1.3.1 ARIA13: Using aria-labelledby to name regions and landmarks",
"WCAG_2.0-ARIA15", "1.1.1 ARIA15: Using aria-describedby to provide descriptions of images",
"WCAG_2.0-ARIA16", "1.3.1, 4.1.2 ARIA16: Using aria-labelledby to provide a name for user interface controls",
"WCAG_2.0-ARIA17", "1.3.1, 3.3.2 ARIA17: Using grouping roles to identify related form controls",
"WCAG_2.0-ARIA18", "3.3.1, 3.3.3 ARIA18: Using aria-alertdialog to Identify Errors",
# C12: Using percent for font sizes 
#      Failures of this technique are reported under technique G142
# C13: Using named font sizes
#      Failures of this technique are reported under technique G142
# C14: Using em units for font sizes
#      Failures of this technique are reported under technique G142
#
"WCAG_2.0-C28", "1.4.4 C28: Specifying the size of text containers using em units",
"WCAG_2.0-F2", "1.3.1 F2: Failure of Success Criterion 1.3.1 due to using changes in text presentation to convey information without using the appropriate markup or text",
"WCAG_2.0-F3", "1.1.1 F3: Failure of Success Criterion 1.1.1 due to using CSS to include images that convey important information",
"WCAG_2.0-F4", "2.2.2 F4: Failure of Success Criterion 2.2.2 due to using text-decoration:blink without a mechanism to stop it in less than five seconds",
"WCAG_2.0-F8", "1.2.2 F8: Failure of Success Criterion 1.2.2 due to captions omitting some dialogue or important sound effects",
"WCAG_2.0-F16", "2.2.2 F16: Failure of Success Criterion 2.2.2 due to including scrolling content where movement is not essential to the activity without also including a mechanism to pause and restart the content",
"WCAG_2.0-F17", "1.3.1, 4.1.1 F17: Failure of Success Criterion 1.3.1 and 4.1.1 due to insufficient information in DOM to determine one-to-one relationships (e.g. between labels with same id) in HTML",
"WCAG_2.0-F25", "2.4.2 F25: Failure of Success Criterion 2.4.2 due to the title of a Web page not identifying the contents",
"WCAG_2.0-F30", "1.1.1, 1.2.1 F30: Failure of Success Criterion 1.1.1 and 1.2.1 due to using text alternatives that are not alternatives",
"WCAG_2.0-F32", "1.3.2 F32: Failure of Success Criterion 1.3.2 due to using white space characters to control spacing within a word",
"WCAG_2.0-F38", "1.1.1 F38: Failure of Success Criterion 1.1.1 due to omitting the alt-attribute for non-text content used for decorative purposes only in HTML",
"WCAG_2.0-F39", "1.1.1 F39: Failure of Success Criterion 1.1.1 due to providing a text alternative that is not null (e.g., alt='spacer' or alt='image') for images that should be ignored by assistive technology",
"WCAG_2.0-F40", "2.2.1, 2.2.4 F40: Failure of Success Criterion 2.2.1 and 2.2.4 due to using meta redirect with a time limit",
"WCAG_2.0-F41", "2.2.1, 2.2.4, 3.2.5 F41: Failure of Success Criterion 2.2.1, 2.2.4 and 3.2.5 due to using meta refresh with a time limit",
"WCAG_2.0-F42", "1.3.1, 2.1.1 F42: Failure of Success Criterion 1.3.1 and 2.1.1 due to using scripting events to emulate links in a way that is not programmatically determinable",
"WCAG_2.0-F43", "1.3.1 F43: Failure of Success Criterion 1.3.1 due to using structural markup in a way that does not represent relationships in the content",
"WCAG_2.0-F47", "2.2.2 F47: Failure of Success Criterion 2.2.2 due to using the blink element",
"WCAG_2.0-F54", "2.1.1 F54: Failure of Success Criterion 2.1.1 due to using only pointing-device-specific event handlers (including gesture) for a function",
"WCAG_2.0-F55", "2.1.1, 2.4.7, 3.2.1 F55: Failure of Success Criteria 2.1.1, 2.4.7, and 3.2.1 due to using script to remove focus when focus is received",
"WCAG_2.0-F58", "2.2.1 F58: Failure of Success Criterion 2.2.1 due to using server-side techniques to automatically redirect pages after a time-out",
#
# F62: Failure of Success Criterion 1.3.1 and 4.1.1 due to insufficient
#      information in DOM to determine specific relationships in XML
#      Failures of this technique are reported under technique F77
#
"WCAG_2.0-F65", "1.1.1 F65: Failure of Success Criterion 1.1.1 due to omitting the alt attribute on img elements, area elements, and input elements of type \"image\"",
"WCAG_2.0-F66", "3.2.3 F66: Failure of Success Criterion 3.2.3 due to presenting navigation links in a different relative order on different pages",
"WCAG_2.0-F68", "1.3.1, 4.1.2 F68: Failure of Success Criterion 1.3.1 and 4.1.2 due to the association of label and user interface controls not being programmatically determinable",
"WCAG_2.0-F70", "4.1.1 F70: Failure of Success Criterion 4.1.1 due to incorrect use of start and end tags or attribute markup",
"WCAG_2.0-F77", "4.1.1 F77: Failure of Success Criterion 4.1.1 due to duplicate values of type ID",
#
# F80: Failure of Success Criterion 1.4.4 when text-based form controls 
#      do not resize when visually rendered text is resized up to 200%
#      Failures of this technique are reported under technique C28
#
# F86: Failure of Success Criterion 4.1.2 due to not providing names for 
#      each part of a multi-part form field, such as a US telephone number
#      Failures of this technique are reported under technique H44
#
"WCAG_2.0-F87", "1.3.1 F87: Failure of Success Criterion 1.3.1 due to inserting non-decorative content by using :before and :after pseudo-elements and the 'content' property in CSS",
"WCAG_2.0-F89", "2.4.4, 2.4.9, 4.1.2 F89: Failure of Success Criteria 2.4.4, 2.4.9 and 4.1.2 due to using null alt on an image where the image is the only content in a link",
"WCAG_2.0-F92", "1.3.1 F92: Failure of Success Criterion 1.3.1 due to the use of role presentation on content which conveys semantic information",
#
# G4: Allowing the content to be paused and restarted from where it was paused
#     Failures of this technique are reported under techniques F16
#
# G11: Creating content that blinks for less than 5 seconds
#      Failures of this technique are reported under techniques F4
#      for blink decoration and F47 for <blink> tag.
#
"WCAG_2.0-G18", "1.4.3 G18: Ensuring that a contrast ratio of at least 4.5:1 exists between text (and images of text) and background behind the text",
"WCAG_2.0-G19", "2.3.1 G19: Ensuring that no component of the content flashes more than three times in any 1-second period",
#
# G80: Providing a submit button to initiate a change of context
#      Failures of this technique are reported under technique H32
#
"WCAG_2.0-G87", "1.2.2 G87: Providing closed captions",
#
# G88: Providing descriptive titles for Web pages
#      Failures of this technique are reported under technique H25, PDF18
#
# G90: Providing keyboard-triggered event handlers
#      Failures of this technique are reported under technique SCR20
#
#"WCAG_2.0-G94", "1.1.1 G94: Providing short text alternative for non-text content that serves the same purpose and presents the same information as the non-text content",
"WCAG_2.0-G115", "1.3.1 G115: Using semantic elements to mark up structure",
"WCAG_2.0-G125", "2.4.5 G125: Providing links to navigate to related Web pages",
"WCAG_2.0-G130", "2.4.6 G130: Providing descriptive headings",
"WCAG_2.0-G131", "2.4.6, 3.3.2 G131: Providing descriptive labels",
"WCAG_2.0-G134", "4.1.1 G134: Validating Web pages",
#
# Advisory technique
#
#"WCAG_2.0-G141", "1.3.1 G141: Organizing a page using headings",
#
"WCAG_2.0-G142", "1.4.4 G142: Using a technology that has commonly-available user agents that support zoom",
"WCAG_2.0-G145", "1.4.3 G145: Ensuring that a contrast ratio of at least 3:1 exists between text (and images of text) and background behind the text",
"WCAG_2.0-G152", "2.2.2 G152: Setting animated gif images to stop blinking after n cycles (within 5 seconds)",
#
# G162: Positioning labels to maximize predictability of relationships
#       Failures of this technique are reported under technique H44
#
# G192: Fully conforming to specifications
#      Failures of this technique are reported under technique G143
#
"WCAG_2.0-G197", "3.2.4 G197: Using labels, names, and text alternatives consistently for content that has the same functionality",
"WCAG_2.0-H2", "1.1.1 H2: Combining adjacent image and text links for the same resource",
"WCAG_2.0-H24", "1.1.1, 2.4.4 H24: Providing text alternatives for the area elements of image maps",
"WCAG_2.0-H25", "2.4.2 H25: Providing a title using the title element",
"WCAG_2.0-H27", "1.1.1 H27: Providing text and non-text alternatives for object",
"WCAG_2.0-H30", "1.1.1, 2.4.4 H30: Providing link text that describes the purpose of a link for anchor elements",
"WCAG_2.0-H32", "3.2.2 H32: Providing submit buttons",
"WCAG_2.0-H33", "2.4.4 H33: Supplementing link text with the title attribute",
"WCAG_2.0-H35", "1.1.1 H35: Providing text alternatives on applet elements",
"WCAG_2.0-H36", "1.1.1 H36: Using alt attributes on images used as submit buttons",
#"WCAG_2.0-H37", "1.1.1 H37: Using alt attributes on img elements",
"WCAG_2.0-H39", "1.3.1 H39: Using caption elements to associate data table captions with data tables",
"WCAG_2.0-H42", "1.3.1 H42: Using h1-h6 to identify headings",
"WCAG_2.0-H43", "1.3.1 H43: Using id and headers attributes to associate data cells with header cells in data tables",
"WCAG_2.0-H44", "1.1.1, 1.3.1, 3.3.2, 4.1.2 H44: Using label elements to associate text labels with form controls",
"WCAG_2.0-H45", "1.1.1 H45: Using longdesc",
"WCAG_2.0-H46", "1.1.1 H46: Using noembed with embed",
"WCAG_2.0-H48", "1.3.1 H48: Using ol, ul and dl for lists or groups of links",
"WCAG_2.0-H51", "1.3.1 H51: Using table markup to present tabular information",
"WCAG_2.0-H53", "1.1.1, 1.2.3 H53: Using the body of the object element",
"WCAG_2.0-H57", "3.1.1 H57: Using language attributes on the html element",
"WCAG_2.0-H58", "3.1.2 H58: Using language attributes to identify changes in the human language",
"WCAG_2.0-H64", "2.4.1, 4.1.2 H64: Using the title attribute of the frame and iframe elements",
"WCAG_2.0-H65", "1.3.1, 3.3.2, 4.1.2 H65: Using the title attribute to identify form controls when the label element cannot be used",
"WCAG_2.0-H67", "1.1.1 H67: Using null alt text and no title attribute on img elements for images that AT should ignore",
"WCAG_2.0-H71", "1.3.1, 3.3.2 H71: Providing a description for groups of form controls using fieldset and legend elements",
"WCAG_2.0-H73", "1.3.1 H73: Using the summary attribute of the table element to give an overview of data tables",
"WCAG_2.0-H74", "4.1.1 H74: Ensuring that opening and closing tags are used according to specification",
#
# H75: Ensuring that Web pages are well-formed
#      Failures of this technique are reported under technique G143
#
"WCAG_2.0-H88", "4.1.1, 4.1.2 H88: Using HTML according to spec",
"WCAG_2.0-H91", "2.1.1, 4.1.2 H91: Using HTML form controls and links",
#
# H93: Ensuring that id attributes are unique on a Web page
#      Failures of this technique are reported under technique F77
#
"WCAG_2.0-H94", "4.1.1 H94: Ensuring that elements do not contain duplicate attributes",
"WCAG_2.0-PDF1", "1.1.1 PDF1: Applying text alternatives to images with the Alt entry in PDF documents",
"WCAG_2.0-PDF2", "2.4.5 PDF2: Creating bookmarks in PDF documents",
"WCAG_2.0-PDF6", "1.3.1 PDF6: Using table elements for table markup in PDF Documents",
"WCAG_2.0-PDF12", "1.3.1, 4.1.2 PDF12: Providing name, role, value information for form fields in PDF documents",
"WCAG_2.0-PDF16", "3.1.1 PDF16: Setting the default language using the /Lang entry in the document catalog of a PDF document",
"WCAG_2.0-PDF18", "2.4.2 PDF18: Specifying the document title using the Title entry in the document information dictionary of a PDF document",
"WCAG_2.0-SC3.1.1", "3.1.1 SC3.1.1: Language of Page",
#
# SCR2: Using redundant keyboard and mouse event handlers
#       Failures of this technique are reported under technique SCR20
#
"WCAG_2.0-SCR20", "2.1.1 SCR20: Using both keyboard and other device-specific functions",
"WCAG_2.0-SCR21", "1.3.1 SCR21: Using functions of the Document Object Model (DOM) to add content to a page",
);

my (%testcase_description_fr) = (
#
# WCAG 2.0
#  Text taken from http://www.braillenet.org/accessibilite/comprendre-wcag20/CAT20110222/Overview.html
#
"WCAG_2.0-ARIA1", "2.4.2, 2.4.4, 3.3.2 ARIA1: Using the aria-describedby property to provide a descriptive label for user interface controls",
"WCAG_2.0-ARIA2", "3.3.2, 3.3.3 ARIA2: Identifying a required field with the aria-required property",
"WCAG_2.0-ARIA6", "1.1.1 ARIA6: Using aria-label to provide labels for objects",
"WCAG_2.0-ARIA7", "2.4.4 ARIA7: Using aria-labelledby for link purpose",
"WCAG_2.0-ARIA8", "2.4.4 ARIA8: Using aria-label for link purpose",
"WCAG_2.0-ARIA9", "1.1.1, 3.3.2 ARIA9: Using aria-labelledby to concatenate a label from several text nodes",
"WCAG_2.0-ARIA10", "1.1.1 ARIA10: Using aria-labelledby to provide a text alternative for non-text content",
"WCAG_2.0-ARIA12", "1.3.1 ARIA12: Using role=heading to identify headings",
"WCAG_2.0-ARIA13", "1.3.1 ARIA13: Using aria-labelledby to name regions and landmarks",
"WCAG_2.0-ARIA15", "1.1.1 ARIA15: Using aria-describedby to provide descriptions of images",
"WCAG_2.0-ARIA16", "1.3.1, 4.1.2 ARIA16: Using aria-labelledby to provide a name for user interface controls",
"WCAG_2.0-ARIA17", "1.3.1, 3.3.2 ARIA17: Using grouping roles to identify related form controls",
"WCAG_2.0-ARIA18", "3.3.1, 3.3.3 ARIA18: Using aria-alertdialog to Identify Errors",
# C12: Using percent for font sizes 
#      Failures of this technique are reported under technique G142
# C13: Using named font sizes
#      Failures of this technique are reported under technique G142
# C14: Using em units for font sizes
#      Failures of this technique are reported under technique G142
#
"WCAG_2.0-C28", "1.4.4 C28: Sp�cifier la taille des conteneurs de texte en utilisant des unit�s em",
"WCAG_2.0-F2", "1.3.1 F2 : �chec du crit�re de succ�s 1.3.1 consistant � utiliser les changements dans la pr�sentation du texte pour v�hiculer de l'information sans utiliser le balisage ou le texte appropri�",
"WCAG_2.0-F3", "1.1.1 F3: �chec du crit�re de succ�s 1.1.1 consistant � utiliser les CSS pour inclure une image qui v�hicule une information importante",
"WCAG_2.0-F4", "2.2.2 F4: �chec du crit�re de succ�s 2.2.2 consistant � utiliser text-decoration:blink sans m�canisme pour l'arr�ter en moins de 5 secondes",
"WCAG_2.0-F8", "1.2.2 F8: �chec du crit�re de succ�s 1.2.2 consistant � omettre certains dialogues ou effets sonores importants dans les sous-titres",
"WCAG_2.0-F16", "2.2.2 F16: �chec du crit�re de succ�s 2.2.2 consistant � inclure un contenu d�filant lorsque le mouvement n'est pas essentiel � l'activit� sans inclure aussi un m�canisme pour mettre ce contenu en pause et pour le red�marrer",
"WCAG_2.0-F17", "1.3.1, 4.1.1 F17: �chec du crit�re de succ�s 1.3.1 et 4.1.1 li� � l'insuffisance d'information dans le DOM pour d�terminer des relations univoques en HTML (par exemple entre les �tiquettes ayant un m�me id)",
"WCAG_2.0-F25", "2.4.2 F25: �chec du crit�re de succ�s 2.4.2 survenant quand le titre de la page Web n'identifie pas son contenu",
"WCAG_2.0-F30", "1.1.1, 1.2.1 F30: �chec du crit�re de succ�s 1.1.1 et 1.2.1 consistant � utiliser un �quivalent textuel qui n'est pas �quivalent (par exemple nom de fichier ou texte par d�faut)",
"WCAG_2.0-F32", "1.3.2 F32: �chec du crit�re de succ�s 1.3.2 consistant � utiliser des caract�res blancs pour contr�ler l'espacement � l'int�rieur d'un mot",
"WCAG_2.0-F38", "1.1.1 F38: �chec du crit�re de succ�s 1.1.1 consistant � omettre l'attribut alt pour un contenu non textuel utilis� de fa�on d�corative, seulement en HTML",
"WCAG_2.0-F39", "1.1.1 F39: �chec du crit�re de succ�s 1.1.1 consistant � fournir un �quivalent textuel non vide (par exemple alt='espaceur' ou alt='image') pour des images qui doivent �tre ignor�es par les technologies d'assistance",
"WCAG_2.0-F40", "2.2.1, 2.2.4 F40: �chec du crit�re de succ�s 2.2.1 et 2.2.4 consistant � utiliser une redirection meta avec un d�lai",
"WCAG_2.0-F41", "2.2.1, 2.2.4, 3.2.5 F41: �chec du crit�re de succ�s 2.2.1, 2.2.4 et 3.2.5 consistant � utiliser meta refresh avec un d�lai",
"WCAG_2.0-F42", "1.3.1, 2.1.1 F42: �chec du crit�re de succ�s 1.3.1 et 2.1.1 consistant � utiliser des �v�nements de scripts pour �muler des liens d'une mani�re qui n'est pas d�terminable par un programme informatique",
"WCAG_2.0-F43", "1.3.1 F43: �chec du crit�re de succ�s 1.3.1 consistant � utiliser un balisage structurel d'une fa�on qui ne repr�sente pas les relations � l'int�rieur du contenu",
"WCAG_2.0-F47", "2.2.2 F47: �chec du crit�re de succ�s 2.2.2 consistant � utiliser l'�l�ment 'blink'",
"WCAG_2.0-F54", "2.1.1 F54: �chec du crit�re de succ�s 2.1.1 consistant � utiliser seulement des �v�nements au pointeur (y compris par geste) pour une fonction",
"WCAG_2.0-F55", "2.1.1, 2.4.7, 3.2.1 F55: �chec du crit�re de succ�s 2.1.1, 2.4.7 et 3.2.1 consistant � utiliser un script pour enlever le focus lorsque le focus est re�u",
"WCAG_2.0-F58", "2.2.1 F58: �chec du crit�re de succ�s 2.2.2 consistant � utiliser une technique c�t� serveur pour automatiquement rediriger la page apr�s un arr�t",
#
# F62: Failure of Success Criterion 1.3.1 and 4.1.1 due to insufficient
#      information in DOM to determine specific relationships in XML
#      Failures of this technique are reported under technique F77
#
"WCAG_2.0-F65", "1.1.1 F65: �chec du crit�re de succ�s 1.1.1 consistant � omettre l'attribut 'alt' sur les �l�ments <img>, <area> et <input> de type 'image'",
"WCAG_2.0-F66", "3.2.3 F66: �chec du crit�re de succ�s 3.2.3 consistant � pr�senter les liens de navigation dans un ordre relatif diff�rent sur diff�rentes pages",
"WCAG_2.0-F68", "1.3.1, 4.1.2 F68: �chec du crit�re de succ�s 1.3.1 et 4.1.2 li� au fait que l'association entre l'�tiquette et le composant d'interface utilisateur n'est pas d�terminable par programmation",
"WCAG_2.0-F70", "4.1.1 F70: �chec du crit�re de succ�s 4.1.1 li� � l'ouverture et � la fermeture incorrecte des balises et des attributs",
"WCAG_2.0-F77", "4.1.1 F77: �chec du crit�re de succ�s 4.1.1 li� � la duplication des valeurs de type ID",
#
# F80: Failure of Success Criterion 1.4.4 when text-based form controls
#      do not resize when visually rendered text is resized up to 200%
#      Failures of this technique are reported under technique C28
#
# F86: Failure of Success Criterion 4.1.2 due to not providing names for 
#      each part of a multi-part form field, such as a US telephone number
#      Failures of this technique are reported under technique H44
#
"WCAG_2.0-F87", "1.3.1 F87: �chec du crit�re de succ�s 1.3.1 consistant � utiliser les pseudo-�l�ments :before et :after et la propri�t� content en CSS",
"WCAG_2.0-F89", "2.4.4, 2.4.9, 4.1.2 F89: �chec du crit�re de succ�s 2.4.4, 2.4.9 et 4.1.2 consistant � utiliser un attribut alt vide pour une image qui est le seul contenu d'un lien",
"WCAG_2.0-F92", "1.3.1 F92: Failure of Success Criterion 1.3.1 due to the use of role presentation on content which conveys semantic information",
#
# G4: Allowing the content to be paused and restarted from where it was paused
#     Failures of this technique are reported under techniques F16
#
# G11: Creating content that blinks for less than 5 seconds
#      Failures of this technique are reported under techniques F4
#      for blink decoration and F47 for <blink> tag.
#
"WCAG_2.0-G18", "1.4.3 G18: S'assurer qu'un rapport de contraste d'au moins 4,5 pour 1 existe entre le texte (et le texte sous forme d'image) et l'arri�re-plan du texte",
"WCAG_2.0-G19", "2.3.1 G19: S'assurer qu'aucun composant du contenu ne flashe plus de 3 fois dans une m�me p�riode d'une seconde",
#
# G80: Providing a submit button to initiate a change of context
#      Failures of this technique are reported under technique H32
#
"WCAG_2.0-G87", "1.2.2 G87 : Fournir des sous-titres ferm�s (� la demande)",
#
# G88: Providing descriptive titles for Web pages
#      Failures of this technique are reported under technique H25, PDF18
#
# G90: Providing keyboard-triggered event handlers
#      Failures of this technique are reported under technique SCR20
#
#"WCAG_2.0-G94", "1.1.1 G94: Fournir un court �quivalent textuel pour un contenu non textuel qui a la m�me fonction et pr�sente la m�me information que le contenu non textuel",
"WCAG_2.0-G115", "1.3.1 G115: Utiliser les �l�ments s�mantiques pour baliser la structure",
"WCAG_2.0-G125", "2.4.5 G125: Fournir des liens de navigation vers les pages Web reli�es",
"WCAG_2.0-G130", "2.4.6 G130: Fournir des en-t�tes de section descriptifs",
"WCAG_2.0-G131", "2.4.6, 3.3.2 G131: Fournir des �tiquettes descriptives",
"WCAG_2.0-G134", "4.1.1 G134: Valider les pages Web",
#
# Advisory technique
#
#"WCAG_2.0-G141", "1.3.1 G141: Organiser une page en utilisant les en-t�tes de section",
#
"WCAG_2.0-G142", "1.4.4 G142: Gr�ce � une technologie qui a des agents utilisateurs couramment disponibles � l'appui de zoom",
"WCAG_2.0-G145", "1.4.3 G145: S'assurer qu'un rapport de contraste d'au moins 3 pour 1 existe entre le texte (et le texte sous forme d'image) et l'arri�re-plan du texte",
"WCAG_2.0-G152", "2.2.2 G152: Configurer les gifs anim�s pour qu'ils s'arr�tent de clignoter apr�s n cycles (pendant 5 secondes)",
#
# G162: Positioning labels to maximize predictability of relationships
#       Failures of this technique are reported under technique H44
#
# G192: Fully conforming to specifications
#      Failures of this technique are reported under technique G143
#
"WCAG_2.0-G197", "3.2.4 G197: Utiliser les �tiquettes, les noms et les �quivalents textuels de fa�on coh�rente pour des contenus ayant la m�me fonctionnalit�",
"WCAG_2.0-H2", "1.1.1 H2: Combiner en un m�me lien une image et un intitul� de lien pour la m�me ressource",
"WCAG_2.0-H24", "1.1.1, 2.4.4 H24: Fournir un �quivalent textuel pour l'�l�ment area d'une image � zones cliquables",
"WCAG_2.0-H25", "2.4.2 H25: H25 : Donner un titre � l'aide de l'�l�ment <title>",
"WCAG_2.0-H27", "1.1.1 H27: Fournir un �quivalent textuel et non textuel pour un objet",
"WCAG_2.0-H30", "1.1.1, 2.4.4 H30: Fournir un intitul� de lien qui d�crit la fonction du lien pour un �l�ment <anchor>",
"WCAG_2.0-H32", "3.2.2 H32: Fournir un bouton 'submit'",
"WCAG_2.0-H33", "2.4.4 H33: Compl�ter l'intitul� du lien � l'aide de l'attribut title",
"WCAG_2.0-H35", "1.1.1 H35: Fournir un �quivalent textuel pour l'�l�ment <applet>",
"WCAG_2.0-H36", "1.1.1 H36: Utiliser un attribut alt sur une image utilis�e comme bouton soumettre",
#"WCAG_2.0-H37", "1.1.1 H37: Utilisation des attributs 'alt' avec les �l�ments <img>",
"WCAG_2.0-H39", "1.3.1 H39: Utiliser l'�l�ment 'caption' pour associer un titre de tableau avec les donn�es du tableau",
"WCAG_2.0-H42", "1.3.1 H42: Utiliser h1-h6 pour identifier les en-t�tes de section",
"WCAG_2.0-H43", "1.3.1 H43: Utiliser les attributs 'id' et 'headers' pour associer les cellules de donn�es avec les cellules d'en-t�tes dans les tableaux de donn�es",
"WCAG_2.0-H44", "1.1.1, 1.3.1, 3.3.2, 4.1.2 H44: Utiliser l'�l�ment <label> pour associer les �tiquettes avec les champs de formulaire",
"WCAG_2.0-H45", "1.1.1 H45: Utiliser 'longdesc'",
"WCAG_2.0-H46", "1.1.1 H46: Utiliser <noembed> avec <embed>",
"WCAG_2.0-H48", "1.3.1 H48: Utiliser ol, ul et dl pour les listes",
"WCAG_2.0-H51", "1.3.1 H51: Utiliser le balisage des tableaux pour pr�senter l'information tabulaire",
"WCAG_2.0-H53", "1.1.1, 1.2.3 H53: Utiliser le corps de l'�l�ment <object>",
"WCAG_2.0-H57", "3.1.1 H57: Utiliser les attributs de langue dans l'�l�ment <html>",
"WCAG_2.0-H58", "3.1.2 H58: Utiliser les attributs de langue pour identifier les changements de langue",
"WCAG_2.0-H64", "2.4.1, 4.1.2 H64: Utiliser l'attribut 'title' des �l�ments <frame> et <iframe>",
"WCAG_2.0-H65", "1.3.1, 3.3.2, 4.1.2 H65: Utiliser l'attribut 'title' pour identifier un champ de formulaire quand l'�l�ment <label> ne peut pas �tre utilis�",
"WCAG_2.0-H67", "1.1.1 H67: Utiliser un attribut alt vide sans attribut title sur un �l�ment img pour les images qui doivent �tre ignor�es par les technologies d'assistance",
"WCAG_2.0-H71", "1.3.1, 3.3.2 H71: Fournir une description des groupes de champs � l'aide des �l�ments <fieldset> et <legend>",
"WCAG_2.0-H73", "1.3.1 H73: Utiliser l'attribut 'summary' de l'�l�ment <table> pour donner un aper�u d'un tableau de donn�es",
"WCAG_2.0-H74", "4.1.1 H74: S'assurer que les balises d'ouverture et de fermeture sont utilis�es conform�ment aux sp�cifications",
#
# H75: Ensuring that Web pages are well-formed
#      Failures of this technique are reported under technique G143
#
"WCAG_2.0-H88", "4.1.1, 4.1.2 H88: Utiliser HTML conform�ment aux sp�cifications",
"WCAG_2.0-H91", "2.1.1, 4.1.2 H91: Utiliser des �l�ments de formulaire et des liens HTML",
#
# H93: Ensuring that id attributes are unique on a Web page
#      Failures of this technique are reported under technique F77
#
"WCAG_2.0-H94", "4.1.1 H94: S'assurer que les �l�ments ne contiennent pas d'attributs dupliqu�s",
"WCAG_2.0-PDF1", "1.1.1 PDF1�: Application d��quivalents textuels aux images au moyen de l�entr�e Alt dans les documents PDF",
"WCAG_2.0-PDF2", "2.4.5 PDF2�: Cr�ation de signets dans les documents PDF",
"WCAG_2.0-PDF6", "1.3.1 PDF6�: Utilisation d��l�ments de table pour le balisage des tables dans les documents PDF",
"WCAG_2.0-PDF12", "1.3.1, 4.1.2 PDF12�: Fourni le nom, le r�le, la valeur des renseignements des champs de formulaire des documents PDF",
"WCAG_2.0-PDF16", "3.1.1 PDF16�: R�gle la langue par d�faut au moyen de l�entr�e /Lang dans le catalogue de document d�un document PDF",
"WCAG_2.0-PDF18", "2.4.2 PDF18�: Pr�cise le titre du document au moyen de l�entr�e du dictionnaire d�informations du document d�un document PDF",
"WCAG_2.0-SC3.1.1", "3.1.1 SC3.1.1: Langue de la page",
#
# SCR2: Using redundant keyboard and mouse event handlers
#       Failures of this technique are reported under technique SCR20
#
"WCAG_2.0-SCR20", "2.1.1 SCR20: Utiliser � la fois des fonctions au clavier et sp�cifiques � d'autres p�riph�riques",
"WCAG_2.0-SCR21", "1.3.1 SCR21: Utiliser les fonctions du mod�le objet de document (DOM) pour ajouter du contenu � la page",
);

#
# Default messages to English
#
my ($testcase_description_table) = \%testcase_description_en;

#
# Create table of testcase id and the list of test groups.
# This is a mapping of technique to success criterion for WCAG 2.0
#
my (%testcase_groups_table) = (
"WCAG_2.0-ARIA1", "2.4.2, 2.4.4, 3.3.2",
"WCAG_2.0-ARIA2", "3.3.2, 3.3.3",
"WCAG_2.0-ARIA6", "1.1.1",
"WCAG_2.0-ARIA7", "2.4.4",
"WCAG_2.0-ARIA8", "2.4.4",
"WCAG_2.0-ARIA9", "1.1.1, 3.3.2",
"WCAG_2.0-ARIA10", "1.1.1",
"WCAG_2.0-ARIA12", "1.3.1",
"WCAG_2.0-ARIA13", "1.3.1",
"WCAG_2.0-ARIA15", "1.1.1",
"WCAG_2.0-ARIA16", "1.3.1, 4.1.2",
"WCAG_2.0-ARIA17", "1.3.1, 3.3.2",
"WCAG_2.0-ARIA18", "3.3.1, 3.3.3",
"WCAG_2.0-C28", "1.4.4",
"WCAG_2.0-F2", "1.3.1",
"WCAG_2.0-F3", "1.1.1",
"WCAG_2.0-F4", "2.2.2",
"WCAG_2.0-F8", "1.2.2",
"WCAG_2.0-F16", "2.2.2",
"WCAG_2.0-F17", "1.3.1, 4.1.1",
"WCAG_2.0-F25", "2.4.2",
"WCAG_2.0-F30", "1.1.1, 1.2.1",
"WCAG_2.0-F32", "1.3.2",
"WCAG_2.0-F38", "1.1.1",
"WCAG_2.0-F39", "1.1.1",
"WCAG_2.0-F40", "2.2.1, 2.2.4",
"WCAG_2.0-F41", "2.2.1, 2.2.4, 3.2.5",
"WCAG_2.0-F42", "1.3.1, 2.1.1",
"WCAG_2.0-F43", "1.3.1",
"WCAG_2.0-F47", "2.2.2",
"WCAG_2.0-F54", "2.1.1",
"WCAG_2.0-F55", "2.1.1, 2.4.7, 3.2.1",
"WCAG_2.0-F58", "2.2.1",
"WCAG_2.0-F65", "1.1.1",
"WCAG_2.0-F66", "3.2.3",
"WCAG_2.0-F68", "1.3.1, 4.1.2",
"WCAG_2.0-F70", "4.1.1",
"WCAG_2.0-F77", "4.1.1",
"WCAG_2.0-F87", "1.3.1",
"WCAG_2.0-F89", "2.4.4, 4.1.2",
"WCAG_2.0-F92", "1.3.1",
"WCAG_2.0-G18", "1.4.3",
"WCAG_2.0-G19", "2.3.1",
"WCAG_2.0-G87", "1.2.2",
#"WCAG_2.0-G94", "1.1.1",
"WCAG_2.0-G115", "1.3.1",
"WCAG_2.0-G125", "2.4.5",
"WCAG_2.0-G130", "2.4.6",
"WCAG_2.0-G131", "2.4.6, 3.3.2",
"WCAG_2.0-G134", "4.1.1",
"WCAG_2.0-G142", "1.4.4",
"WCAG_2.0-G145", "1.4.3",
"WCAG_2.0-G152", "2.2.2",
"WCAG_2.0-G197", "3.2.4",
"WCAG_2.0-H2", "1.1.1",
"WCAG_2.0-H24", "1.1.1, 2.4.4",
"WCAG_2.0-H25", "2.4.2",
"WCAG_2.0-H27", "1.1.1",
"WCAG_2.0-H30", "1.1.1, 2.4.4",
"WCAG_2.0-H32", "3.2.2",
"WCAG_2.0-H33", "2.4.4",
"WCAG_2.0-H35", "1.1.1",
"WCAG_2.0-H36", "1.1.1",
"WCAG_2.0-H39", "1.3.1",
"WCAG_2.0-H42", "1.3.1",
"WCAG_2.0-H43", "1.3.1",
"WCAG_2.0-H44", "1.1.1, 1.3.1, 3.3.2, 4.1.2",
"WCAG_2.0-H45", "1.1.1",
"WCAG_2.0-H46", "1.1.1",
"WCAG_2.0-H48", "1.3.1",
"WCAG_2.0-H53", "1.1.1, 1.2.3",
"WCAG_2.0-H57", "3.1.1",
"WCAG_2.0-H58", "3.1.2",
"WCAG_2.0-H64", "2.4.1, 4.1.2",
"WCAG_2.0-H65", "1.3.1, 3.3.2, 4.1.2",
"WCAG_2.0-H67", "1.1.1",
"WCAG_2.0-H71", "1.3.1, 3.3.2",
"WCAG_2.0-H73", "1.3.1",
"WCAG_2.0-H74", "4.1.1",
"WCAG_2.0-H88", "4.1.1, 4.1.2",
"WCAG_2.0-H91", "2.1.1, 4.1.2",
"WCAG_2.0-H94", "4.1.1",
"WCAG_2.0-PDF1", "1.1.1",
"WCAG_2.0-PDF2", "2.4.5",
"WCAG_2.0-PDF2", "1.3.1",
"WCAG_2.0-PDF12", "1.3.1, 4.1.2",
"WCAG_2.0-PDF16", "3.1.1",
"WCAG_2.0-PDF18", "2.4.2",
"WCAG_2.0-SC3.1.1", "3.1.1",
"WCAG_2.0-SCR20", "2.1.1",
"WCAG_2.0-SCR21", "1.3.1",
);

#
# Table of number of testcase groups for testcase profile types
#
my (%testcase_group_counts) = (
"WCAG_2.0", 38,
);

#
# Create reverse table, indexed by description
#
my (%reverse_testcase_description_en) = reverse %testcase_description_en;
my (%reverse_testcase_description_fr) = reverse %testcase_description_fr;
my ($reverse_testcase_description_table) = \%reverse_testcase_description_en;

#
#******************************************************************
#
# String table for testcase help URLs
#
#******************************************************************
#

my (%testcase_url_en, %testcase_url_fr);

#
# Default URLs to English
#
my ($url_table) = \%testcase_url_en;

#***********************************************************************
#
# Name: TQA_Testcase_Debug
#
# Parameters: this_debug - debug flag
#
# Description:
#
#   This function sets the package global debug flag.
#
#***********************************************************************
sub TQA_Testcase_Debug {
    my ($this_debug) = @_;

    #
    # Copy debug value to global variable
    #
    $debug = $this_debug;
}

#**********************************************************************
#
# Name: TQA_Testcase_Language
#
# Parameters: language
#
# Description:
#
#   This function sets the language of testcase description messages.
#
#***********************************************************************
sub TQA_Testcase_Language {
    my ($language) = @_;


    #
    # Check for French language
    #
    if ( $language =~ /^fr/i ) {
        print "TQA_Testcase_Language, language = French\n" if $debug;
        $testcase_description_table = \%testcase_description_fr;
        $reverse_testcase_description_table = \%reverse_testcase_description_fr;
        $url_table = \%testcase_url_fr;
    }
    else {
        #
        # Default language is English
        #
        print "TQA_Testcase_Language, language = English\n" if $debug;
        $testcase_description_table = \%testcase_description_en;
        $reverse_testcase_description_table = \%reverse_testcase_description_en;
        $url_table = \%testcase_url_en;
    }
}

#**********************************************************************
#
# Name: TQA_Testcase_Description
#
# Parameters: key - testcase id
#
# Description:
#
#   This function returns the value in the testcase description 
# table for the specified key.  If there is no entry in the table an error
# string is returned.
#
#**********************************************************************
sub TQA_Testcase_Description {
    my ($key) = @_;

    #
    # Do we have a testcase description table entry for this key ?
    #
    if ( defined($$testcase_description_table{$key}) ) {
        #
        # return value
        #
        return ($$testcase_description_table{$key});
    }
    else {
        #
        # No testcase description table entry, either we are missing
        # a string or we have a typo in the key name.
        #
        return ("*** No string for $key ***");
    }
}

#**********************************************************************
#
# Name: TQA_Testcase_Groups
#
# Parameters: key - testcase id
#
# Description:
#
#   This function returns the value in the testcase group
# table for the specified key.  If there is no entry in the table an 
# empty string is returned.
#
#**********************************************************************
sub TQA_Testcase_Groups {
    my ($key) = @_;

    #
    # Do we have a testcase group entry for this key ?
    #
    if ( defined($testcase_groups_table{$key}) ) {
        #
        # return value
        #
        return($testcase_groups_table{$key});
    }
    else {
        #
        # No testcase group table entry, return empty string.
        #
        return("");
    }
}

#**********************************************************************
#
# Name: TQA_Testcase_Group_Count
#
# Parameters: key - group type
#
# Description:
#
#   This function returns the value in the testcase group count
# table for the specified key.  If there is no entry in the table an
# empty string is returned.
#
#**********************************************************************
sub TQA_Testcase_Group_Count {
    my ($key) = @_;

    #
    # Do we have a testcase group count entry for this key ?
    #
    if ( defined($testcase_group_counts{$key}) ) {
        #
        # return value
        #
        return($testcase_group_counts{$key});
    }
    else {
        #
        # No testcase group count table entry, return empty string.
        #
        return("");
    }
}

#**********************************************************************
#
# Name: TQA_Testcase_URL
#
# Parameters: key - testcase id
#
# Description:
#
#   This function returns the value in the testcase URL 
# table for the specified key.
#
#**********************************************************************
sub TQA_Testcase_URL {
    my ($key) = @_;

    #
    # Do we have a string table entry for this key ?
    #
    print "TQA_Testcase_URL, key = $key\n" if $debug;
    if ( defined($$url_table{$key}) ) {
        #
        # return value
        #
        print "value = " . $$url_table{$key} . "\n" if $debug;
        return ($$url_table{$key});
    }
    #
    # Was the testcase description provided rather than the testcase
    # identifier ?
    #
    elsif ( defined($$reverse_testcase_description_table{$key}) ) {
        #
        # return value
        #
        $key = $$reverse_testcase_description_table{$key};
        print "value = " . $$url_table{$key} . "\n" if $debug;
        return ($$url_table{$key});
    }
    else {
        #
        # No string table entry, either we are missing a string or
        # we have a typo in the key name.
        #
        return;
    }
}

#**********************************************************************
#
# Name: TQA_Testcase_Read_URL_Help_File
#
# Parameters: filename - path to help file
#
# Description:
#
#   This function reads a testcase help file.  The file contains
# a list of testcases and the URL of a help page or standard that
# relates to the testcase.  A language field allows for English & French
# URLs for the testcase.
#
#**********************************************************************
sub TQA_Testcase_Read_URL_Help_File {
    my ($filename) = @_;

    my (@fields, $tcid, $lang, $url);

    #
    # Clear out any existing testcase/url information
    #
    %testcase_url_en = ();
    %testcase_url_fr = ();

    #
    # Check to see that the help file exists
    #
    if ( !-f "$filename" ) {
        print "Error: Missing URL help file\n" if $debug;
        print " --> $filename\n" if $debug;
        return;
    }

    #
    # Open configuration file at specified path
    #
    print "TQA_Testcase_Read_URL_Help_File Openning file $filename\n" if $debug;
    if ( ! open(HELP_FILE, "$filename") ) {
        print "Failed to open file\n" if $debug;
        return;
    }

    #
    # Read file looking for testcase, language and URL
    #
    while (<HELP_FILE>) {
        #
        # Ignore comment and blank lines.
        #
        chop;
        if ( /^#/ ) {
            next;
        }
        elsif ( /^$/ ) {
            next;
        }

        #
        # Split the line into fields.
        #
        @fields = split(/\s+/, $_, 3);

        #
        # Did we get 3 fields ?
        #
        if ( @fields == 3 ) {
            $tcid = $fields[0];
            $lang = $fields[1];
            $url  = $fields[2];
            print "Add Testcase/URL mapping $tcid, $lang, $url\n" if $debug;

            #
            # Do we have an English URL ?
            #
            if ( $lang =~ /eng/i ) {
                $testcase_url_en{$tcid} = $url;
                $reverse_testcase_description_en{$url} = $tcid;
            }
            #
            # Do we have a French URL ?
            #
            elsif ( $lang =~ /fra/i ) {
                $testcase_url_fr{$tcid} = $url;
                $reverse_testcase_description_fr{$url} = $tcid;
            }
            else {
                print "Unknown language $lang\n" if $debug;
            }
        }
        else {
            print "Line does not contain 3 fields, ignored: \"$_\"\n" if $debug;
        }
    }
    
    #
    # Close configuration file
    #
    close(HELP_FILE);
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
