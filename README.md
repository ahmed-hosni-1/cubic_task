# Cubic Task

This Flutter app implements a registration form and integrates with Google Maps to calculate the distance from the user's location to the nearest branch. It supports multiple languages (English and Arabic) and allows users to log in via social media accounts to bypass the registration form.

## Features

### 1. **Registration Form**:
- **Name**: A text field with validation to ensure it only contains alphabetic characters.
- **E-mail**: A text field for email input with validation for proper email format.
- **Phone Number**: A numeric text field with validation for valid phone number format.
- **Favorite Branch**: A dropdown populated with branch data fetched from the API.

### 2. **Language Toggle**:
- A toggle button allows users to switch between English and Arabic. This dynamically changes the form labels, placeholders, and instructions.

### 3. **Google Map Integration**:
- The app uses the `google_maps_flutter` package to display a map with a pin marking the nearest branch.
- The user’s current location is accessed, and the app calculates the distance to the nearest branch using the `geolocator` package.
- A popup on the map pin shows the Estimated Time of Arrival (ETA), distance, and branch name.

### 4. **Social Media Login**:
- Users can bypass the registration form and log in using social media accounts like  Google, or Apple.

### 5. **Form Submission Success**:
- Upon successful form submission, a success message is displayed to the user.

## Technologies Used:
- **Flutter**: For building the mobile app.
- **Google Maps API**: To integrate map functionality and show locations.
- **Geolocator**: To calculate the distance from the user's location to the branch.
- **HTTP**: For API calls to fetch branch data.

## Getting Started

To get started with the project, clone the repository and follow the instructions below:

1. Clone the repository:
   ```bash
   git clone https://github.com/ahmed-hosni-1/cubic_task.git
   cd cubic_task
