#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface Settings : UIViewController
{
    IBOutlet UISlider *fontSizeSlider;
    IBOutlet UILabel *example1, *example2;
	IBOutlet UISwitch *showImageSwitch;
	IBOutlet UITableViewCell *fontSettings, *imageSettings, *inputExplain, *aboutPage;
}

- (IBAction)onFontSizeSliderChange;
- (IBAction)onShowImageSwitchChange;
@end
