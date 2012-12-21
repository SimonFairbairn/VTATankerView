# VTATankerView

Quickly and easily add arbitrary views to a sliding pop up.

**Grab a tanker**  
`self.imageTanker = [VTATankerView newTanker];`

**Get 'er shipshape**  
`self.imageTanker.shouldStretchContent = NO;`  
`self.imageTanker.shouldDarkenScreen = YES;`

**Load 'er up**  
`self.imageTanker.content = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bug-boy"]];`  
`[self.view addSubview:self.imageTanker];`

**Set Sail**  
`[self.imageTanker show];`


### Swipe Option

You can switch on a swipe mode, which automatically adds a little grabber image to the view and allows the user to pull it up or down manually.

Simply set `self.imageTanker.shouldRespondToSwipe = YES` and it takes care of the rest.

I've included a grabber image, but you can use your own (just make sure it's called "grabber.png" and that it's no more than 20px high).

![Swipe view][3]


### Usage

Just need to include the `VTATankerView.h` and `VTATankerView.m` files in your project, then include the `VTATankerView.h` in your viewController.

Check out the sample project for more details.

### License

MIT License.

### Screenshots

![Picker view][1]

![Image View][2]

[1]: http://simonfairbairn.github.com/images/picker-view.png
[2]: http://simonfairbairn.github.com/images/image-view.png
[2]: http://simonfairbairn.github.com/images/swipe-view.png