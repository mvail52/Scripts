# SQL_Scripts
 Just random SQL script I have built that solve random promblems

# Single Google Address Lookup
 Takes part or all of an address and returns the google results. This is great for address validation or finding
 information like longitude and latitude. This is meant to be used with a program or application and then stored in SQL. 

 ***Before you use***
 You must get an api key from google and update line 40, more information is provided here: 
 https://developers.google.com/maps/documentation/embed/get-api-key 
 
 ***Problems*** 
 This only returns the first address in the xml response if you have multiple addresses returned in your xml response. At
 times this causes an issue because it will return the wrong result.
 If you are using a free key from google there is a max limit per day. At the time this script was written that was 1500 a day. Please 
 see google documentation updated information.

# Multiple Google Address Lookup
 Takes multiple addresses and looks them up using googles api returning a xml, then inserting that into sql. This was used to update 
 multiple tables in a database to validate and add information like Longitude and Latitude. I have found that it returns about 90% accuracy
 depending on the amount of data you must validate the address

 ***Before you use***
 Note like the Single Google Address Lookup script you must have a get an api key. Confirm that your table that you are using with has a 
 unique column to use while looping.

 ***Problems*** 
 This script has all the same problem as Single Google Address Lookup. Additionally, some address may return Null because it did not wait for
 the XML response. You can either add a variable to run it again or add a wait to help prevent this. 