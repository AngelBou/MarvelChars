# MarvelChars App

App to see all Marvels characters in a list and the detail of a chosen character

The app uses the Marvel api (https://developer.marvel.com/docs)

This app is made to show the Viper Architecture and the unit testing, ui testing potential of this architecture.

### Features
- VIPER Architecture
- Unit Tests
- UI Tests
- Diferent environments for production, develeop, testing 
- Uses swiftLint to style swift code (https://github.com/realm/SwiftLint)
- Localization ready for other languages (currently only English)
- AccesibilyLabels of elements

### Schemes
| Name               | Environment | Api url                    | Notes                              |
| ------------------ |:-----------:| :------------------------: |-----------------------------------:|
| MarvelChars_PROD   | release  | https://gateway.marvel.com |   |
| MarvelChars        | development | http://localhost:8000      |      |
| MarvelCharsUITests | testing     | http://localhost:8000       |   |

Note: I have a testing server in http://localhost:8000 for running development and testing environments
that mirror some of the calls to the server.

To change  server url, change value of key marvelServerURL in:
- Supporting Files/Config_PROD.plist
- Supporting Files/Config_DEV.plist
- Supporting Files/Config_UITEST.plist


### Unit Testing
- Use test doubles for Viper presenter (https://en.wikipedia.org/wiki/Test_double)
- Clasic unit testing used to test MD5 function

### UI Testing
- Using native testing.
- NOTE: The test in MarvelCharsUITestsNoServer fails when test server is up and success is server is down, or return an error

In the project there is a folder for using as a test server. To run this test server there is an easy way of doing it:

In a terminal of MacOS, in marvelServerMock folder use the following command (This will run a very small http server and as python 2.7 is included in MacOs, there is no need to install anything)

$ python -m SimpleHTTPServer


### Notes 
- No frameworks.
- Not all tests are implemented. I have choosen some unit and ui tests to cover different cases


### Project Structure
```
.
+-- README.md
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
+-- MarvelCharTests     (Unit testing)
|       + -- Mock       (json files)
+-- MarvelCharUITests   (UI testing)
|       + --marvelServerMock (files not included for any target. Only to run test server)
```
