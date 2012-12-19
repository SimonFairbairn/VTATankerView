# VTATankerView

Quickly and easily add arbitrary views to a sliding pop up.

**Grab a tanker**  
`self.imageTanker = [VTATankerView newTanker];`

**Get 'er shipshape**  
`self.imageTanker.shouldStretchContent = NO;`  
`self.imageTanker.shouldDarkenScreen = YES;`

**Load 'er up**  
`self.imageTanker.content = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bug-boy"]];`

**Set Sail**  
`[self.view addSubview:self.imageTanker];`

### Screenshots

![Picker view][1]

![Image View][2]

[1]: http://simonfairbairn.github.com/images/picker-view.png
[2]: http://simonfairbairn.github.com/images/image-view.png