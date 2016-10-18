# Project 1 - *Flicks*

**Flicks** is a movies app using the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: **18** hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] User can view a list of movies currently playing in theaters. Poster images load asynchronously.
- [x] User can view movie details by tapping on a cell.
- [x] User sees loading state while waiting for the API.
- [x] User sees an error message when there is a network error.
- [x] User can pull to refresh the movie list.

The following **optional** features are implemented:

- [x] Add a tab bar for **Now Playing** and **Top Rated** movies.
- [ ] Implement segmented control to switch between list view and grid view.
- [ ] Add a search bar.
- [ ] All images fade in.
- [ ] For the large poster, load the low-res image first, switch to high-res when complete.
- [ ] Customize the highlight and selection effect of the cell.
- [ ] Customize the navigation bar.

The following **additional** features are implemented:

- [ ] List anything else that you can get done to improve the app functionality!

## Video Walkthrough

Here's a walkthrough of implemented user stories:

[flickrGif](http://i.imgur.com/bZa3ejZ.gifv)
<img src='flickr.gifv' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

### Describe any challenges encountered while building the app.

Figuring out how to implement a NowPlaying and TopRated tab bar section took a considerable amount of time. I decided to reuse the main storyboard because there is very little difference between tabs.  In the app delegate, I fetched two instances of the navigation controller from the storyboard, then I created a tab bar controller and attached both nav controllers to it. This allows me to reuse and avoid recoding the main and detail movie controllers.

Creating the scrollable view in the Details View was also fairly difficult.  At first I used an autolayout approach, but because of the unknown height of the overview label, the view would end up incorrectly positioned. Instead, I now use a programmatic approach. I created a new class for the UIView that would generate the labels and keep track of the height of the view.


### Other Issues
The network error popup was implemented through the storyboard, one for each view.  In the future, I will refactor and perhaps use a separate service to programattically show the UI to avoid duplicate code.  Currently the network error view is only displayed when an api call is made; it does not check network availability (wifi/data).  Because of caching, even without a network, the app will be able to load data and the network error view will not popup.

I have not spent much time on designing and improving the general UI.  Hopefully, I will get back to it, refactor, and improve the UI.



## Acknowledgement

    Thanks to the following third party libraries and API used in this project:
    * [AFNetworking](https://github.com/AFNetworking/AFNetworking)
    * [NVActivityIndicatorView](https://github.com/ninjaprox/NVActivityIndicatorView)
    * [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)
    * [MovieDB](https://www.themoviedb.org/?language=en)

## License

    Copyright [2016] [Edwin Wong]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
