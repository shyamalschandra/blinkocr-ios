//
//  PPOcrScanResult.h
//  PhotoPayFramework
//
//  Created by Jura on 18/09/14.
//  Copyright (c) 2014 MicroBlink Ltd. All rights reserved.
//

#import "PPTemplatingRecognizerResult.h"
#import "PPOcrLayout.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * Result of scanning with OCR Recognizer
 *
 * For each parser group, the result contains one Ocr Layout, and one or more parsed results.
 */
PP_CLASS_AVAILABLE_IOS(6.0) @interface PPOcrRecognizerResult : PPTemplatingRecognizerResult

@end

NS_ASSUME_NONNULL_END