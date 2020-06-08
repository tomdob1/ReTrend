# ReTrend
Mobile Application which provides vintage shops with an online presence.

The application is designed using Flutter and has been specifically created with the design guidelines for Android mobile phones, following Google's design guideline documentation for Android applications. 

The application allows users to purchase mystery boxes of clothing from vintage stores which range in a price from low, medium and high with the prices set by the vintage store. 

The main page displays a list of vintage stores around the UK in a list view format and stores the data about each shop on Googles Firebase NoSQL database, allowing for shop information to be stored securely and in a method which is easily scalable. The user can click on a shop to view more information of the store, providing an online presence for the vintage shop with a further feature to purchase a 'mystery box' of clothing.

Each box contains mystery items which in total are worth more than the cost of the box. 

The user can fill in their payment information and billing address to complete a payment. Validation has been coded in to ensure that a purchase cannot be made without filling in the details.

A payment details page has been created to display to the user all of their order details for easy purchase management. 

A further preferences page has been created to allow users to set the type of clothing they would like in their box as well as their correct sizing. 

Finally a review feature was implemented to allow for quality control of the shops, through feedback of a 5 star rating system.

The application accomodates for the varying number and unique stock of clothes within a vintage store through the use of mystery items, meaning the store does not require to sell multiple amounts of the same clothing item, while giving users the freedom to select the type of clothing they would like to receive and encouraging sustainability. 


Coding Detail of Features 
--------------------------------


To make navigation concise and familiar to the user a bottom navigation bar was implemented as the method to navigate through the different main pages, which breaks down to further sub-pages to ensure too much information was not on each main page.

The navigation of the bottom navigation bar occurred through the 'firstscreen.dart' file, which used an integer index to identify which page the user was on. Each button on the navigation bar would update the state of the index which in-turn updates the value of the index, highlighting the relevant icon within the bar and loading the appropriate file for the page selected. Each main page was divided into separate files and selecting an icon within the navigation bar would run the relevant initial class within the specific dart file.

Navigation from the main pages to the sub-pages were done through gesture detection, using Flutters 'onTap' and 'onPressed' handle taps to initialise the 'Navigation.push' method. The 'Navigation.push' method passes a 'MaterialPageRoute' which carries through any relevant variables from one class to another class, which then creates a new scaffold to outline the new page.


Backwards navigation is implemented using a backward arrow for each sub-page. The user can simply press the back button to initialise the 'Navigation.pop' method, which takes a user back to the previous page.
Features 
The selected features were required to solve the outlined problems Retrend outlined within the introduction of this document. This section will cover how the features were developed and what technologies they utilise.


DATA STORAGE THROUGH THE FIRESTORE NOSQL DATABASE
--------------------------------------------------

For the application to be able to cope with the predicted high demand of a number of vintage stores, the application needs to be scalable to easily adjust to the demand. Therefore, data storage was necessary through a cloud-based database to ensure data is managed correctly and is secure.

To implement this Google's cloud-based database known as Firebase was used, specifically their Firestore system which provides database management, data storage and data authentication. To implement this a database was set-up on the cloud-servers with a variety of tables known as 'collections'. The appropriate plugins and dependencies were imported into the application, to allow the application to read and write data from the database securely. 

The main method to obtain data from the database is using an asynchronus snapshot to run a streambuilder within the scaffold of the application. This feature runs through a selected collection within the database and populates the application with information from the collection. For example, within the '_StorePageState' class, a streambuilder is used to take information from the 'shop' collection (table which stores shop information) and populate it into a separate list tile for each store.

By using a cloud-based database, the application will be able to facilitate a large number of stores to have an online presence using the Retrend application.



STORE INFORMATION/PURCHASING
-----------------------------
The store feature is the first feature which the user is presented with when the application loads and is all run through the storepage.dart file. This feature works throughout multiple pages, giving the user freedom to select the store and box type of their choice. 

This feature was developed to first interact with the database using a streambuilder, to populate shop information into separate tiles of a list view. Using a listview in conjunction with a streambuilder made compiling the list occur dynamically, by iterating through each document within the shop collection of the database and implementing gesture detection into every tile. The data stored within the shop ranges from the shop name, location, description, individual box type costs, average score and path file for images within the assets folder. 

Once the user selects a specific tile the gesture detection is enabled and the user is navigated to the 'Shop Information' page where they can view low-level information on the shop, providing an online presence for the store. 

Using buttons and further 'navigation.push' methods, the user has the option to move to the next page which runs the stateful BuyBoxScreen class. This class builds a widget which creates a new scaffold to give the user a selection between three types of mystery boxes, ranging from gold, silver and bronze. To allow stores to have freedom over profits, the costs are set by the store. The pricing of the boxes is dynamically pulled from the Firestore document relevant to the selected store.

After a user has selected a box a further navigation.push method runs to start the PaymentScreen stateful class, running the form used to obtain delivery information of the user and summarising the purchase. Validation was input into the form to ensure that all information is input correctly, this works by running an if statement once the 'Submit' button is pressed to check if all text fields are filled, if not a relevant error message will appear. The user ends the purchasing feature by completing their order, where they are directed to the 'Completed Order' page where a confirmation of their order is displayed.  When the user selects the 'Submit' button to complete their order, a void function is run which adds a new document of the customers' orders into the Firestore database. This information is then presented using a list view, incrementing through each value within the document and displaying it as a list. By completing this feature, the user is able to quickly make a purchase, making the vintage store more accessible to the user (P3) and in-turn allowing customers to easily purchase re-used clothing.




FAVOURITE SHOPS
--------------------
To allow users to have a page which is customised to display their favourite shops, an actionable icon was input into the app bar of the store information page. This provides the user an option to favourite the shop when reading about the specific shop.

For the feature to properly work, gesture detection was enabled to run an if statement once the icon is pressed. The if statement checks the favourite variable which is a Boolean data type and if its current state is set to 'false' (indicating the shop has not been favourited), the if statement will set the state to 'true' and vice versa. Dependent on the state of the Boolean a specific void function is run, either 'updateRecordFalse' or 'updateRecordTrue', which will write to the relevant document within the shop collection of the Firestore database. The 'updateRecordFalse' function will update the document to identify the shop is no longer favourited and the 'updateRecordTrue' function will update the database to indicate the shop has been favourited. Once the state of the Boolean variable has been changed, this will feedback to the user by changing the icon to a red background colour if the Boolean is true (shop has been favourited), or from red to black to indicate that the shop is no longer a favourite.

When the user is on the 'Favourites' page, this will initialise the 'favouritespage.dart' file. This file runs the 'FavouritePage' class which calls a new scaffold containing a streambuilder. This streambuilder will run a query displaying a list of all the shops which have a favourites value equal to 'true', displaying to the user all their favourite shops.

Allowing users to customise their own page by tailoring their favourite vintage stores in one page, will allow users to easily purchase clothes from vintage stores (P2) and receive the items no matter where they are in the country (P4).


SET PREFERENCES AND SIZES OF ITEMS
----------------------------------

This feature was implemented to allow users to set their desired sizing and preferences of clothing within a mystery box.

The functionality of the feature occurs within the 'Preferences' page using drop-down boxes as a form of input. The user has the option to select from a number of options for each field, which was compiled using a list of strings. A separate string for each dropdown box was created with no active value initially. Once the user has selected an item from the dropdown box, the string with no value will be set to the value of the user selection. Once the user has selected all of their sizes and preferences, they can select the 'Save' button which uses gesture detection to pass information to the 'UpdatePreferences' function. This function simply writes to the 'preferences' collection within the Firestore database updating all the values within the document.

To make this feature more intuitive further functionality was added to read the current values from the 'preferences' collection and display them within the dropdown boxes. Allowing users to see the currently stored preferences and sizes stored for the user, this was done by using a future builder to obtain data from the database and writing it as the current value within the drop down box.

This feature allows users to input their sizes and preferences, meaning searching for the right item of clothing within a vintage shop is no longer a problem.


ORDER HISTORY/DETAILS 
----------------------
A feature which was essential for the business to implement was an order history/order details section, meaning users have all of their orders in one place without having to physically organise their documents as you would have to with a physical receipt.

To implement this feature, individual order information had to be stored on the Firestore database. Orders contain a variety of information ranging from delivery address, store name, cost, sizes as well as preferences, meaning data from multiple collections within the database had to be merged to create an order for a customer. To implement this a void function 'createRecord' is run as soon as the user has submitted their order, this runs a 'firestore.instance' from each collection where data is required from (preferences and shops). Each value required is stored into a relevant string variable along with the current time and date which is obtained using the DateTime.now() class. Once all the relevant information has been collected, it is added to the orders collection as a seperate document and an auto generated document ID to identify the order with. This Document ID is also used as the order number for customers to uniquely identify their order if required.

Once all of the information for an order has been stored within the database, it is presented on a brand new 'Completed Order' page. As there were challenges obtaining the unique document ID from the database an alternative method was utilised using time. This method obtained the current time and subtracted the time by 10 seconds, storing its value within the 'nowmin1' variable. This variable was used within the where clause to display any orders which had a time value larger than the current time minus 10 seconds. As this query is ran as soon as the new order is updated to the database, the only document which will populate is the users document. As a user will not be able to make more than one order at a time, this method will suffice although improvements will need to be made to this query in the future.

Once the user is on the 'Orders' Page they will be able to view a list of all of their previous orders at a high level, detailing their order number, time, box type and shop the box was purchased at. If they want to see more order information, the user simply selects the 'Order Details' button to view all of their order information in full. 

After criticism that the 'Order Details' page was too bland, the page was adjusted to display images relevant to the order. This worked by having having image path files implemented into the list view, which is then populated by the database. Dependent on the information populated by the user will change what images appear for the user.

By successfully implementing this feature users will be able to query any issues they have with their order by accessing an automatically organised order page, containing all their previous orders.



REVIEW AN ORDER
----------------
To ensure vintage stores provide a good service to customers, a review system was put in-place within the 'Orders' page.

To access the feature users simply press the 'Review Order' button of a previous order, where they are directed to the 'Review Order' Page. Within this page the users are presented with five star icons and a text box, where they are prompted to input a score out of five (selecting the stars) and submit a review within the multiple line text field.

This feature uses gesture detection for each icon to identify which star was selected (star 1 - star 5) and five separate boolean variables for each star. Every time an icon is pressed the onPressed method will change the valuables from false to true or vice versa. To provide the appropriate feedback to the user, the star which was selected would change from black to red to indicate that the star had been selected with an updated text displaying the score out of 5. Once the user has entered in their review score and description, they are able to submit the score, navigating them to the 'Submitted Review' page. During this process a void function called 'submitReview' is run which compares all five star booleans, checking to see which variable has a true value and providing a score out of five based on this information. which is then uploaded into the reviews collection as a separate document.

By providing this feature, vintage stores will be able to obtain an online presence at a cheaper running cost than a devoted website as Retrend will regulate reviews of orders under 3 stars, to ensure that all customers are happy.

