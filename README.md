# SQL_Scripts
 Just random SQL script I have built that solve random promblems

# Single Google Address Lookup
 Takes part or all of an address and returns the google results. This is great for address validation or finding
 information like longitude and latitude. This is meant to be used with a program or application and then stored in SQL. 

 ***Before you use***
 You must get an api key from google and update line 40, more information is provided here: 
 https://developers.google.com/maps/documentation/embed/get-api-key 
 
 ***Problems*** 
 This only return the first address in the xml response if you have multiple addresses returned in your xml response. At
 times this causes an issue because it will return the wrong result.
 If you are using a free key from google there is a max limit per day. At the time this script was written that was 1500 a day. Please 
 see google documentation updated information.
