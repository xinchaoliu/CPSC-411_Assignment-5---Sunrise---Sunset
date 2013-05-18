/*------------------------------------------------------------------------------
----------------------------------Xinchao Liu-----------------------------------
--------------------------------Sunrise & Sunset--------------------------------
------------------------------------------------------------------------------*/

/*  What is it?
      This is an iPhone application calculates and displays the time when the 
      sun sets and rises at the location selected by the user through the GPS
      receiver or from a list of locations. The application uses libnova library
      to compute the time and uses a city database for coordinate info        */

/*  How to use it?
      - Two way to use:
            1. Use location info received from GPS to see your local sunrise and
               sunset time. To do that, simply run the app and press the first
               button. A detail view will show up. After a second, the local
               city name, and sun time with timezone will display in the screen.
               There is also a current time & date shown at the bottom.
            
            2. Choose a city from the database to see the sun time for that 
               city. At the first page, press the second button, the view will
               then change to a stateTableView. User can select the state from
               all the states. Then all cities in that state will show up. User
               can scroll up and down to find a city to check, also user can 
               use the searchBar at the top page. Input keyword the related 
               results will show in searchResultTableView. Select one city then
               the deatil view shows. 
      
/*  Features Completed:
      - Receive GPS info from device
      - Use libnova library to compute the sun time
      - No Internet connection requeired
      - A current time watch for user to compare the different timezone.
      - Select all cities from the U.S for sun time, include a search feature */
      
/*  Features not Completed:
      - All features considered have been implemented.                        */
      
/*  Bugs:
      - There are no known bugs.                                              */
      
/*  External Dependancies:
      - No external dependancies. 
      - Database file: cities.sqlite
      - libnova v0.13.0: libnova.sourceforge.net                              */
      
/*  About the Author:
      Xinchao Liu
      Leo_Liu@csu.fullerton.edu                                               */
