# Delishoz
Finding a recipe online often means jumping between multiple websites to gather ingredients, written instructions, and video tutorials. I built this application to make that process simpler by bringing everything together into a single mobile experience.

The application allows users to search for recipes using keywords, browse matching results, save favorite recipes for later, and view both written and video cooking instructions. Each recipe includes a complete ingredient list and step-by-step preparation guidance.

## Screenshots

![Page1](./Github_Assets/page1.jpg)
![Page2](./Github_Assets/page2.jpg)
![Page3](./Github_Assets/page3.jpg)
![Page4](./Github_Assets/page4.jpg)
![Page5](./Github_Assets/page5.jpg)
![Page6](./Github_Assets/page6.jpg)
![Page7](./Github_Assets/page7.jpg)
![Page8](./Github_Assets/page8.jpg)
![Page9](./Github_Assets/page9.jpg)

## Features 

- Search recipes by keyword
- View complete ingredient lists
- Access written cooking instructions
- Watch video recipe tutorials
- Save and manage favorite recipes
- Mobile-friendly user interface

## Technologies

- Flutter
- Dart
- REST API
- Git/GitHub

## Architecture
The application follows a client-side architecture where user search requests are sent to a recipe API.
The returned JSON data is then parsed and displayed within the Flutter UI.

## Challenges

- Parsing nested JSON responses
- Managing asynchronous API requests
- Building responsive UI layouts and coming up with a creative "error page" for a good UX

## Future Improvements

- Meal planning
- User accounts
- User account stories, posts, and other social media-like features for a recipe-centered user feed
- Offline caching
