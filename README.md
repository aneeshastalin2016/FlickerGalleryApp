FLICKR GALLERY APP
This project is a Roku channel that shows images from the Flickr API in a multi-row layout similar to what see on Netflix or YouTube.

Main Components
main.brs
Entry point of the app. It initializes the SceneGraph screen and loads AppScene.

AppScene (XML + BRS)
Acts as the main container. It manages layout, navigation, focus, and connects data from API tasks to the UI.

CategoryRow
Represents one horizontal row (a category). It uses MarkupGrid to display images.

PosterCard
Displays each image thumbnail. It also handles focus behavior with a zoom effect.

FlickrFeedTask
Fetches images for all categories using Flickr APIs.

FlickrDetailTask
Fetches detailed metadata when a user selects an image.

Config.brs
Stores API keys, category definitions, and parameters.

Technologies
Used Roku SceneGraph to build a smooth and responsive UI, 
Handled all API calls using Task nodes so the app doesn’t freeze while loading data.
Chosen MarkupGrid since it makes horizontal scrolling simple and allows  to reuse components for displaying images efficiently.
Code is organized by separating the UI, logic, API handling, and configuration into different parts-easy to understand and maintain.
Added zoom effect when an item is selected to give it a more modern, OTT-style look and feel.

The app also doesn’t support pagination, so each row displays a fixed number of images.

Future implementation
If I had more time to work on this project, I would focus on improving both performance and user experience.
I’d also enhance the animations between rows to make navigation feel more polished.
Implement loading spinner
Utils.brs
Contains helper functions like URL creation and JSON parsing.
While the app currently lacks caching, pagination, and advanced error handling, it demonstrates strong fundamentals in SceneGraph architecture, API integration, and focus-based navigation, with clear opportunities for future enhancements.
