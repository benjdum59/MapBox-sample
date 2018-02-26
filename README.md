# MapBox-sample
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/c886d07eec7d4461a107dcadb050d257)](https://www.codacy.com/app/benjdum59/MapBox-sample?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=benjdum59/MapBox-sample&amp;utm_campaign=Badge_Grade)
https://travis-ci.org/benjdum59/MapBox-sample.svg?branch=develop

## Subject
### Introduction
This project is an introduction to MapBox. It is divided into 6 steps. At the end of each step, a git tag is made and named "ETAPE X" where X is the step number.

The project must be a Swift project and there is no limit to use external libraries.

The application must be compatible with at least iOS 9 and iPhone 5 SE

### Step 1
Use the Mapbox SDK to show a map centered on user's current location and show the location with a pin.

### Step 2
Put a field at the top to enter an address. Implement an autocomplete feature in order to select the address. As soon as the address is selected, center the map on the address and put a pin on it.

### Step 3
Add the ability to select another address by moving the map. When you move the map, the current pin must stay in the center of the map. This pin is used to choose the new address. The field added in previous step must have the new address with the following fields: 

 - Street number
 - Street name
 - Postal code
 - Town

### Step 4
Save the addresses when user has selected an address or moved the map. Keep only the two last addresses. They will be visible on the top of the result of the autocomplete address field. This list must persist even if the application has been stopped and relaunched.

### Step 5
Add an abstract layer in order to change the map provider (Google Maps, Apple Plan, Nokia Here, etc..)

### Step 6 
Add Unit Tests (code coverage: ~5-10%)

## Installation / Run
Open xcworkspace file to run the application. If you want to add new pods, you can do a pod install before opening workspace.

## Notes
### Step1
 - Using MapView in storyboard make it crash, so the view is added programmatically

### Step2
 - Use of MapBoxGeocoder library for address autocompletion
 - Use of a dedicated ViewController in charge of searching addresses
 - Creation of Address model
 - Creation of an Address Service

### Step 3
- Use the MGLMapViewDelegate methods. shouldChangeFrom method is used to move the pin during the scroll and regionDidChangeWith method is called at the end of scroll to get the address of the current center
- Add an extension of Address to format the address in the searchBar as desired. If we can't format as desired (empty string), we use the printableAddress get from the API
- Add a UIImageView (image is a pin) in the center of mapViewContainer. It helps user to see the center of the map. As moving the current pin is not really fluent, we may want to remove it since at the end of the scoll, pin view (from MapBox) and pin image (from UIImageView) have the same frame (imageView is in front of pin view from MapBox)
- Make some fix on UISearchBar from MapViewController (removing clear button and cursor)
- When an address is in UISearchBar from MapViewController, and the user click on the search, the current string is sent to the SearchAddressViewController to pre-fill its search bar (and we search the addresses).

### Step4
- Make some refacto: creation of a DataManager and an address Business Logical Layer
- Persist the data into the UserDefaults since it is an easy way to persist/retrieve data for small volume and non critical data
- The tableView in the SearchAdressViewController has 1 or 2 sections, depending on the value of the search history (if no history, only 1 section). For the history section, the addresses are shown in reverse order.

### Step5
- I don't know if pins have to be removed when another address is selected. So I decided to keep them (they were removed before this step)
- For the map, I created a map container which is initialized with a MapProtocol. MapBoxImplementation implements this protocol
- Add dependency injection for service and storage

### Step6
 - UT on utils and model
 - UT on BLL with mocking service and storage. The aim is to check that methods in mocked service and storage are called in BLL
 - UIT that checks :
	 - We are on MapViewController
	 - We are on SearchAddressViewController with no search result (searchBar textfield is empty)
	 - Checks the tableView when we have results (writing "a" in the searchbar should always have results)
	 - Minor fixes
