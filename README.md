# MarvelChars App

App to see all Marvels characters in a list and the detail of a chosen character
The app uses the Marvel api (https://developer.marvel.com/docs)
This app is made to show the Viper Architecture and the unit testing, ui testing potential of this architecture.

### Features
- VIPER Architecture
- Unit Tests
- UI Tests
- Mock data
- Diferent environments for production, develeop, testing 
- Uses swiftLint to style swift code (https://github.com/realm/SwiftLint)
- Localization ready for other languages (currently only English)
- AccesibilyLabels of elements

### Schemes
| Name               | Environment | Api Url                    | Notes                              |
| ------------------ |:-----------:| :------------------------: |-----------------------------------:|
| MarvelChars_PROD   | production  | https://gateway.marvel.com | Build phase doesn't run swiftlin   |
| MarvelChars        | development | http://localhost:8000      | Build phase runs swiftlint         |
| MarvelCharsUITests | testing     | http://localhost:8000      | Build phase doesn't run swiftlin   |
| SWiftLint          | development | http://localhost:8000      | Build phase runs swiftlint         |

### Unit Testing
- Use test doubles for Viper presenter (https://en.wikipedia.org/wiki/Test_double)
- Clasic unit testing used to test MD5 function

### UI Testing
- Using native testing.
- App configuration through environment variables
- Each test can choose to run again real server (development server or production server) or against a mocked json response
- Each test can Mock network errors from services or fake json responses (some json files included)
- Each test can choose the initial scene (one of the two). In a future development it can be used to test serveral use cases (flows) that require a different start scene. 


### Notes 
- No frameworks needed.
- Not all tests are implemented. I have choosen the unit and ui tests that show how to cover all different cases


### Project Structure
```
.
+-- swiftlint.yml
+-- MarvelChars
|   ...
|   +-- Scenes
|       +-- CharList
|       +-- CharDetail
|   +-- Models
|   +-- Utils           (Utilities and extensions)
|   +-- NetWorkManager  
|       + -- Services
+-- Supporting Files    (localization)
+-- Mock                (json files)
+-- MarvelCharTests     (Unit testing)
+-- MarvelCharUITests   (UI testing)
```
