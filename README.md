# MapBox-sample
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

