![newly 2](https://cloud.githubusercontent.com/assets/2684979/20462091/9357647c-af38-11e6-992f-07b9c263bb59.png)


[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/Newly.svg)](https://img.shields.io/cocoapods/v/Newly.svg)
[![Platform](https://img.shields.io/cocoapods/p/Newly.svg?style=flat)](http://cocoadocs.org/docsets/Newly)
<a href="https://developer.apple.com/swift"><img src="https://img.shields.io/badge/swift3-compatible-4BC51D.svg?style=flat" alt="Swift 3 compatible" /></a>
<a href="https://raw.githubusercontent.com/xmartlabs/Eureka/master/LICENSE"><img src="http://img.shields.io/badge/license-MIT-blue.svg?style=flat" alt="License: MIT" /></a>

`Newly` is a drop in solution to add Twitter/Facebook/Linkedin style, new updates/tweets/posts available button. It can be used to notify user about new content availability and can other actions can be triggers using its delegate method.

- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)


## Check this library on other platforms:
<a href="https://github.com/Auto-Droid/Newly">
<img src="https://github.com/ramotion/navigation-stack/raw/master/Android_Java@2x.png" width="178" height="81"></a>

- Contributed by [Sourabh Karkal](https://github.com/Auto-Droid)
 

## Requirements

- iOS 9.0+
- Xcode 8.0+
- Swift 3.0+

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 1.1.0+ is required to build Newly.

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
![ezgif com-resize-2](https://cloud.githubusercontent.com/assets/2684979/20624689/567c125a-b334-11e6-99a7-3f851f46d05d.gif)


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



