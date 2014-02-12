//
//  TextStatsViewController.m
//  Attributor
//
//  Created by MIMO on 15/01/14.
//  Copyright (c) 2014 MIMO. All rights reserved.
//

#import "TextStatsViewController.h"

@interface TextStatsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *colorfulCharactersLabel;
@property (weak, nonatomic) IBOutlet UILabel *outlinedCharacteresLabel;

@end

@implementation TextStatsViewController

- (void)setTextToAnalyze:(NSAttributedString *)textToAnalyze {

    _textToAnalyze = textToAnalyze;
    [self updateUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateUI];
}


- (NSAttributedString *)charactersWithAttribute:(NSString *)attributeName {
    
    NSMutableAttributedString *characters = [[NSMutableAttributedString alloc] init];
    
    int index = 0;
    while (index < [self.textToAnalyze length]) {
        NSRange range;
        id value = [self.textToAnalyze attribute:attributeName atIndex:index effectiveRange:&range];
        if (value) {
            [characters appendAttributedString:[self.textToAnalyze attributedSubstringFromRange:range]];
            index = range.location + range.length;
        } else {
            index++;
        }
    }
    return characters;
}

- (void)updateUI {
    
    self.colorfulCharactersLabel.text = [NSString stringWithFormat:@"%d colorful characters",[[self charactersWithAttribute:NSForegroundColorAttributeName] length]];
    self.outlinedCharacteresLabel.text = [NSString stringWithFormat:@"%d outlined characters",[[self charactersWithAttribute:NSStrokeWidthAttributeName] length]];

}

@end
