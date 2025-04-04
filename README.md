<h1 align="center" id="title">Newsy</h1>

<p id="description">This app leverages NewsAPI to retrieve a variety of news sources each offering top headlines. It utilizes Alamofire to fetch news sources and headlines from the API displaying them through a SwiftUI interface. Core Data is implemented for offline functionality: the app initially loads data from the database and subsequently checks for fresh content from the API. The API is called only when the database is empty or if the app has been open for 30 minutes.</p>

  
  
<h2>🧐 Features</h2>

Here're some of the project's best features:

*   Diverse News Sources: Access a wide range of news sources each providing top headlines.
*   Real-time Updates: Automatically fetch fresh news data every 30 minutes or when the local database is empty.
*   Offline Access: View previously loaded articles even without an internet connection thanks to Core Data integration.
*   Search Functionality: Easily search for articles by keywords.
*   Category Selection: Choose specific news categories to tailor the content to your interests.

  
  
<h2>💻 Built with</h2>

Technologies used in the project:

*   SwiftUI: For building a modern and responsive user interface.
*   Core Data: For local data storage and offline functionality.
*   Swift Concurrency: For managing asynchronous tasks and improving code readability.
*   Combine: For handling asynchronous data streams and updates.


<h2>Requirements</h2>

*   iOS 16.6+
*   Xcode 15.0+
