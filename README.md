# Petitions App
The Petitions App is a simple iOS application built using Swift and UIKit framework. It allows users to browse and view petitions obtained from the We The People API of the White House. The app fetches petition data from a JSON source and presents it in a table view. Users can tap on a petition to view its details in a web view.

## Features
- Fetches and displays petitions from a JSON source
- Allows filtering of petitions based on search criteria
- Displays petition details using a web view

## Technology Stack
 The Petitions App is developed using the following tools and technologies:

- Swift: The primary programming language used to build the iOS application.
- UIKit: A framework for building user interfaces in iOS.
- WebKit: A framework that provides a web view for rendering HTML content.


## Code Structure
The project is structured as follows:

- ViewController.swift: The main view controller responsible for displaying the list of petitions.
- DetailViewController.swift: The view controller that presents the details of a selected petition.
- Petitions.swift and Petition.swift: Structs defining the data model for the petitions and individual petition respectively.



Acknowledgements
This project was made as a part of Hacking with Swift course by Paul Hudson and the data used in this app is sourced from the We The People API of the White House.

