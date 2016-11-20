![newly](https://cloud.githubusercontent.com/assets/2684979/20461326/7720577c-af20-11e6-9bd0-3bddef893e10.png)


[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/Newly.svg)](https://img.shields.io/cocoapods/v/Newly.svg)
[![Platform](https://img.shields.io/cocoapods/p/Newly.svg?style=flat)](http://cocoadocs.org/docsets/Newly)

`Newly` is a drop in solution to add Twitter/Facebook/Linkedin style, new updates/tweets/posts available button. It can be used to notify user about new content availability and can other actions can be triggers using its delegate method.

## Requirements

- iOS 10.0+
- Xcode 8.0+
- Swift 3.0+

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 1.1.0+ is required to build Newly 0.2.0.

To integrate Newly into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'Newly'
end
```

Then, run the following command:

```bash
$ pod install
```


## Usage

### Showing Newly

```swift
import Newly

let newly = Newly()

newly.showUpdate(message: "↑ New Tweets")
```
![ezgif com-resize](https://cloud.githubusercontent.com/assets/2684979/20461445/a411dee6-af24-11e6-89da-5a67796819d6.gif)



### Hiding Newly

Use this if you want to manually hide `Newly`. By default `Newly` will hide on touch.
 
```swift
newly.hideUpdate()
```


### On Click Updates

You can use `Newly` delegate to get its on click update.

You can set delegate in your `ViewDidLoad` method.

```swift
newly.delegate = self
```

And then add extension for `NewlyDelegate`

```swift
extension ViewController:NewlyDelegate{
    
    func newlyDidTapped() {
        
        // Your custom code to trigger other actions once Newly is touched.
    }
}

```


### Appearance Customization 

You can customize appearance of `Newly` using following properties.



```swift
newly.backgroundColor = UIColor(colorLiteralRed: 0, green: 153.0/255.0, blue: 229.0/255.0, alpha: 1.0)
```
This will set the background colour for `Newly`.


```swift
newly.textColor = UIColor.white
```
This will set the text colour for `Newly`.


```swift
newly.heightOffset = 78.0
```
This will set the height from top of the screen at which `Newly` will be displayed.



```swift
newly.animationInterval = 1.0
```
This is will the animation time interval to show and hide `Newly`.


```swift
newly.hideOnTouch = true
```
Whether `Newly` should auto hide on touch.


```swift
newly.isUpdateVisible = false
```
Whether `Newly` is currenly visible.



