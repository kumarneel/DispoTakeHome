# Clarification Questions


1. Inside the TenorAPIClient you ask to implement the `gitInfo`. I saw there is a struct for Git Info. Are you asking for me to create another Combine URL session to load the more specific data for each gif? [Link to line of code](https://github.com/kumarneel/DispoTakeHome/blob/1fe5fb4a0360158d4befba98508cdcbbafbbb7b9/iOS-Take-Home-template/Dispo%20Take%20Home/Util/TenorAPIClient.swift#L14)


2. I was trying to maintain consistancy with the MVVM structure of the application and I am new to Combine/React Programming. For displaying the featured gifs and calling the `api.featuredGifs` request from `TenorAPIClient` I didn't know if I was over complicating it and you wanted me to add to the `MainViewModel.swift` or simply check to see if the loaded gifs array is empty and then display/load the featured gifs inside of `loadResults` in `MainViewController.swift`. [link to code](https://github.com/kumarneel/DispoTakeHome/blob/1fe5fb4a0360158d4befba98508cdcbbafbbb7b9/iOS-Take-Home-template/Dispo%20Take%20Home/Main/MainViewModel.swift#L20)

Other notes, SnapKit is really easy to use, I am just new to Combine with using the Publishers and Subscribers. It is my first time with this framework. 





# Dispo iOS Take Home

Create an iOS app with two views, `MainViewController` and `DetailViewController`. The `MainViewController` contains a list of GIFs from the [Tenor API](https://tenor.com/gifapi/documentation).

When there is no query, the view should display the featured gifs. When there is a query, it should display the search results from the API.

Tapping on a cell should push the `DetailViewController`. When the `DetailViewController` loads, it should request more information from the API like share count, tags, and background color, and display it. This data must be requested from `DetailViewController`, not passed from the previous view controller.

As much as possible, stick to the Combine ViewModel structure implemented in the `MainViewController`. The `DetailViewController` should use a similar system for loading additional information from the API.

You shouldn't need to use any additional dependencies.

And while not required, feel free to add additional flourishes or features!

## Setup

Get an API key [here](https://tenor.com/developer/keyregistration) and put it into `Constants.swift`

## Evaluation

### What you will be evaluated on

- Functionality - can you translate the requirements into working code
- Following modern best practices
- Usage of Combine
- Usage of SnapKit for laying out views

### What you will not be evaluated on

- Testing
- Styling of views outside of functionality

## Submission Instructions

Create a private GitHub repository and invite `malonehedges` and `regynald` and respond to the email sent from `m@dispo.fun` when ready.

![Main View](assets/main-view.png)

![Detail View](assets/detail-view.png)
