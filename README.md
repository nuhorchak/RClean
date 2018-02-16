RClean
================
Nicholas Uhorchak
2018-02-16

<!-- Add build tab from TRAVIS CI to readme file-->
[![Build Status](https://travis-ci.org/nuhorchak/RClean.svg?branch=master)](https://travis-ci.org/nuhorchak/RClean)

Section 1 Basic Information
===========================

1.1 Name
--------

RClean

1.2 Title
---------

RClean, an interactive data cleaning tool provides users the dynamic ability to import and clean data. At its core, it provides R users functionality similar to that of Microsoft Excel with regards to preparation of a dataset for analysis.

1.3 Description
---------------

### 1.3A Features

Utilizing R to import and clean data is often a time consuming task. Without preparation of the dataset in excel or other software, R users must use scripts or command line R code for this task. The Interactive Data Cleaning tool will afford users the ability to do the following:

-   Import Data
-   Visually inspect the previously imported data
-   Select releveant data columns to retain/remove
-   Provide the ability to rename columns in the dataframe
-   Select relevant data rows to retain/remove
-   Provide the option to scale the data.
-   Provide the option to mean center the data
-   Provide the ability to impute missing numerical data
-   Provide the ability to encode nominal data to numerical data
-   Save the new data to a "cleaned" dataframe
-   Write the "clean" DF to excel document for future use

### 1.3B End users

This analytic is being developed for those users in need of hasty data cleaning or those who would otherwise not wish to spend a large amount of time writing code to prepare data for analysis. Typical users will have working knowledge of R, however prefer the point and click abilities of Microsoft Excel or other similar software.

### 1.3C Required knowledge/skills

Users must be able to navigate R studio and basic computer file structure. In addition, they should be aware of the types of data contained in the dataset to be analyzed, whether numerical or categorical, such that they are aware of the application of some functions of this analytic tool. Similarly, they should be aware of the statistica implication of imputation on a dataset and that imputation of large amounts of missing data can potentially skew analytical results.

### 1.3D Statistical methods utilized

Users that wish to utilize imputation on the dataset should have some knowledge of the methods applied to the data. If in fact, large amounts of data are missing, they should be aware that simple mean imputation might not be the best answer and advanced imputation techniques should be utilized.

### 1.3E R Packages utilized

This analytic will utilize the following existing R packages:

-   shiny
-   DT
-   shinyjS
-   shinythemes
-   markdown

1.4 End user access
-------------------

End users will use the associated R package to call this gadget

1.5 Security concerns
---------------------

None

1.6 Design constraints
----------------------

Currently, the gadget only handles DF, matrix or tibble like objects with 2 or more columns. Single vectors are not handled.

Section 2 Delivery and Schedule Information
===========================================

2.1 Feature Review
------------------

<table>
<colgroup>
<col width="14%" />
<col width="26%" />
<col width="1%" />
<col width="3%" />
<col width="17%" />
<col width="7%" />
<col width="8%" />
<col width="11%" />
<col width="1%" />
<col width="7%" />
</colgroup>
<thead>
<tr class="header">
<th align="left">Feature</th>
<th align="left">Description</th>
<th align="right">Rank</th>
<th align="left">Status</th>
<th align="left">Value to user</th>
<th align="left">Inputs</th>
<th align="left">Outputs</th>
<th align="left">Use?</th>
<th align="left">Time?</th>
<th align="left">Current or future version</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">Visual inspection of data</td>
<td align="left">This feature will open the newly imported DF so the user can look at the data</td>
<td align="right">1</td>
<td align="left">COMPLETE</td>
<td align="left">Quick and easy visual exploration of the dataset imported</td>
<td align="left">N/A</td>
<td align="left">Dataset output onto screen</td>
<td align="left">Visual exporation of data</td>
<td align="left">Yes</td>
<td align="left">Current</td>
</tr>
<tr class="even">
<td align="left">Select releveant data columns to retain/remove</td>
<td align="left">Allow the user to select what columns to either retain or remove from the current data</td>
<td align="right">2</td>
<td align="left">COMPLETE</td>
<td align="left">Easily remove unwanted variables from the dataset</td>
<td align="left">N/A</td>
<td align="left">Modified DF</td>
<td align="left">Data cleaning</td>
<td align="left">Yes</td>
<td align="left">Current</td>
</tr>
<tr class="odd">
<td align="left">Rename columns</td>
<td align="left">Allow the user to rename columns in the DF</td>
<td align="right">7</td>
<td align="left">COMPLETE</td>
<td align="left">Rename columns if necessary</td>
<td align="left">Column names if necessary</td>
<td align="left">Modified DF</td>
<td align="left">Data cleaning</td>
<td align="left">No</td>
<td align="left">Future</td>
</tr>
<tr class="even">
<td align="left">Select releveant data rows to retain/remove</td>
<td align="left">Allow the user to select what rows to either retain or remove from the current data</td>
<td align="right">3</td>
<td align="left">COMPLETE</td>
<td align="left">Easily remove unwanted rows from the dataset</td>
<td align="left">N/A</td>
<td align="left">Modified DF</td>
<td align="left">Data cleaning</td>
<td align="left">Yes</td>
<td align="left">Current</td>
</tr>
<tr class="odd">
<td align="left">Scale Data</td>
<td align="left">Allow the user to scale the data</td>
<td align="right">5</td>
<td align="left">COMPLETE</td>
<td align="left">Scale the data for future use</td>
<td align="left">N/A</td>
<td align="left">Modified DF</td>
<td align="left">Data prep</td>
<td align="left">No</td>
<td align="left">Future</td>
</tr>
<tr class="even">
<td align="left">Mean center data</td>
<td align="left">Allow the user to center the data</td>
<td align="right">6</td>
<td align="left">COMPLETE</td>
<td align="left">Mean center the data for future use</td>
<td align="left">N/A</td>
<td align="left">Modified DF</td>
<td align="left">Data prep</td>
<td align="left">No</td>
<td align="left">Future</td>
</tr>
<tr class="odd">
<td align="left">Impute missing values</td>
<td align="left">Allow the user to impute missing values</td>
<td align="right">10</td>
<td align="left">not started</td>
<td align="left">NA</td>
<td align="left">Method of imputation</td>
<td align="left">Modified DF</td>
<td align="left">Data prep</td>
<td align="left">No</td>
<td align="left">Future</td>
</tr>
<tr class="even">
<td align="left">Encode nominal to numerical</td>
<td align="left">Allow the user to create &quot;dummy&quot; variables to represent nominal data</td>
<td align="right">8</td>
<td align="left">not started</td>
<td align="left">NA</td>
<td align="left">Variables to encode</td>
<td align="left">Modified DF</td>
<td align="left">Data prep</td>
<td align="left">No</td>
<td align="left">Future</td>
</tr>
<tr class="odd">
<td align="left">Save clean data</td>
<td align="left">User can save the &quot;clean&quot; data to a new dataframe in R</td>
<td align="right">4</td>
<td align="left">COMPLETE</td>
<td align="left">Cleaned data saved for analysis</td>
<td align="left">new name for clean DF</td>
<td align="left">Clean DF</td>
<td align="left">Save cleaned DF for future use</td>
<td align="left">Yes</td>
<td align="left">Current</td>
</tr>
<tr class="even">
<td align="left">Write &quot;clean&quot; data to excel</td>
<td align="left">Allow user to write the clean data to new excel file</td>
<td align="right">9</td>
<td align="left">not started</td>
<td align="left">Clean data is saved into external file for future use</td>
<td align="left">file location</td>
<td align="left">excel document</td>
<td align="left">save file as excel doc for future use</td>
<td align="left">No</td>
<td align="left">Future</td>
</tr>
<tr class="odd">
<td align="left">Modify DF cells</td>
<td align="left">Allow users to click on a cell and change data values</td>
<td align="right">11</td>
<td align="left">not started</td>
<td align="left">single cell value modification</td>
<td align="left">N/A</td>
<td align="left">modified DF</td>
<td align="left">change cells</td>
<td align="left">No</td>
<td align="left">Future</td>
</tr>
</tbody>
</table>
