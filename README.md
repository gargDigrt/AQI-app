# AQI-app
An application to get Air Quality Index


### APP Architechture
For the development of this aplication, **MVVM** is being used. It has view models to handle all the business logic and coordinate between the data models and the views. This app has delegation involved in developemnt

### Server communication
This app has **Web socket server**, which is being used to get continuous updates. To communicate with the server, Apple's **Combine** framework is being used. 

### Test Case
For unit test & UI test case, Apple's XCTests is being used. 

### Dependancy Manager
For managing the dependancy, **Swift Package Manager(SPM)** is being used.

### Graph
For displaing graphs, "Charts" named library is being used.

### Idea & Implementation
First we have established communication between our app and web socket server. Then we are converting recieved data in data models and displaying them in a tabe view. On selection of any of city, we are redirecting to Detail view controller. On this page we are collecting all the updated AQI and refreshing the chart
