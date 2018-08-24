//
//  TensorIOJSONParsingTests.m
//  TensorIO_Tests
//
//  Created by Philip Dow on 8/22/18.
//  Copyright © 2018 doc.ai (http://doc.ai)
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import <XCTest/XCTest.h>

#import "TensorIO.h"

@interface TensorIOJSONParsingTests : XCTestCase

@end

@implementation TensorIOJSONParsingTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

// MARK: - Pixel Normalization

- (void)testPixelNormalizerForDictionaryParsesStandardZeroToOne {
    // it should return a valid pixel normalizer
    // it should return no error
    
    NSError *error;
    NSDictionary *dict = @{
        @"normalize": @{
            @"standard": @"[0,1]"
        }
    };
    
    TIOPixelNormalizer normalizer = TIOPixelNormalizerForDictionary(dict, &error);
    float_t epsilon = 0.01;
    
    XCTAssertNil(error);
    XCTAssertEqualWithAccuracy(normalizer(0, 0), 0.0, epsilon);
    XCTAssertEqualWithAccuracy(normalizer(0, 1), 0.0, epsilon);
    XCTAssertEqualWithAccuracy(normalizer(0, 2), 0.0, epsilon);
    XCTAssertEqualWithAccuracy(normalizer(127, 0), 0.5, epsilon);
    XCTAssertEqualWithAccuracy(normalizer(127, 1), 0.5, epsilon);
    XCTAssertEqualWithAccuracy(normalizer(127, 2), 0.5, epsilon);
    XCTAssertEqualWithAccuracy(normalizer(255, 0), 1.0, epsilon);
    XCTAssertEqualWithAccuracy(normalizer(255, 1), 1.0, epsilon);
    XCTAssertEqualWithAccuracy(normalizer(255, 2), 1.0, epsilon);
}

- (void)testPixelNormalizerForDictionaryParsesStandardNegativeOneToOne {
    // it should return a valid pixel normalizer
    // it should return no error
    
    NSError *error;
    NSDictionary *dict = @{
        @"normalize": @{
            @"standard": @"[-1,1]"
        }
    };
    
    TIOPixelNormalizer normalizer = TIOPixelNormalizerForDictionary(dict, &error);
    float_t epsilon = 0.01;
    
    XCTAssertNil(error);
    XCTAssertEqualWithAccuracy(normalizer(0, 0), -1.0, epsilon);
    XCTAssertEqualWithAccuracy(normalizer(0, 1), -1.0, epsilon);
    XCTAssertEqualWithAccuracy(normalizer(0, 2), -1.0, epsilon);
    XCTAssertEqualWithAccuracy(normalizer(127, 0), 0.0, epsilon);
    XCTAssertEqualWithAccuracy(normalizer(127, 1), 0.0, epsilon);
    XCTAssertEqualWithAccuracy(normalizer(127, 2), 0.0, epsilon);
    XCTAssertEqualWithAccuracy(normalizer(255, 0), 1.0, epsilon);
    XCTAssertEqualWithAccuracy(normalizer(255, 1), 1.0, epsilon);
    XCTAssertEqualWithAccuracy(normalizer(255, 2), 1.0, epsilon);
}

- (void)testPixelNormalizerForDictionaryReturnsError {
    // it should return a nil pixel normalizer
    // it should return an error
    
    NSError *error;
    NSDictionary *dict = @{
        @"normalize": @{
            @"standard": @"[-10, 10]"
        }
    };
    
    TIOPixelNormalizer normalizer = TIOPixelNormalizerForDictionary(dict, &error);
    
    XCTAssertNotNil(error);
    XCTAssertNil(normalizer);
}

- (void)testPixelNormalizerForDictionaryParsesScaleAndSameBiases {
    // it should return a valid pixel normalizer
    // it should return no error
    
    NSError *error;
    NSDictionary *dict = @{
        @"normalize": @{
            @"scale": @(1.0/255.0),
            @"bias": @{
                @"r": @(0),
                @"g": @(0),
                @"b": @(0)
            }
        }
    };
    
    TIOPixelNormalizer normalizer = TIOPixelNormalizerForDictionary(dict, &error);
    float_t epsilon = 0.01;
    
    XCTAssertNil(error);
    XCTAssertEqualWithAccuracy(normalizer(0, 0), 0.0, epsilon);
    XCTAssertEqualWithAccuracy(normalizer(0, 1), 0.0, epsilon);
    XCTAssertEqualWithAccuracy(normalizer(0, 2), 0.0, epsilon);
    XCTAssertEqualWithAccuracy(normalizer(127, 0), 0.5, epsilon);
    XCTAssertEqualWithAccuracy(normalizer(127, 1), 0.5, epsilon);
    XCTAssertEqualWithAccuracy(normalizer(127, 2), 0.5, epsilon);
    XCTAssertEqualWithAccuracy(normalizer(255, 0), 1.0, epsilon);
    XCTAssertEqualWithAccuracy(normalizer(255, 1), 1.0, epsilon);
    XCTAssertEqualWithAccuracy(normalizer(255, 2), 1.0, epsilon);
}

- (void)testPixelNormalizerForDictionaryParsesScaleAndDifferenceBiases {
    // it should return a valid pixel normalizer
    // it should return no error
    
    NSError *error;
    NSDictionary *dict = @{
        @"normalize": @{
            @"scale": @(1.0/255.0),
            @"bias": @{
                @"r": @(0.1),
                @"g": @(0.2),
                @"b": @(0.3)
            }
        }
    };
    
    TIOPixelNormalizer normalizer = TIOPixelNormalizerForDictionary(dict, &error);
    float_t epsilon = 0.01;
    
    XCTAssertNil(error);
    XCTAssertEqualWithAccuracy(normalizer(0, 0), 0.0+0.1, epsilon);
    XCTAssertEqualWithAccuracy(normalizer(0, 1), 0.0+0.2, epsilon);
    XCTAssertEqualWithAccuracy(normalizer(0, 2), 0.0+0.3, epsilon);
    XCTAssertEqualWithAccuracy(normalizer(127, 0), 0.5+0.1, epsilon);
    XCTAssertEqualWithAccuracy(normalizer(127, 1), 0.5+0.2, epsilon);
    XCTAssertEqualWithAccuracy(normalizer(127, 2), 0.5+0.3, epsilon);
    XCTAssertEqualWithAccuracy(normalizer(255, 0), 1.0+0.1, epsilon);
    XCTAssertEqualWithAccuracy(normalizer(255, 1), 1.0+0.2, epsilon);
    XCTAssertEqualWithAccuracy(normalizer(255, 2), 1.0+0.3, epsilon);
}

// MARK: - Pixel Denormalization

- (void)testPixelDenormalizerForDictionaryParsesStandardZeroToOne {
    // it should return a valid pixel normalizer
    // it should return no error
    
    NSError *error;
    NSDictionary *dict = @{
        @"denormalize": @{
            @"standard": @"[0,1]"
        }
    };
    
    TIOPixelDenormalizer denormalizer = TIOPixelDenormalizerForDictionary(dict, &error);
    uint8_t epsilon = 1;
    
    XCTAssertNil(error);
    XCTAssertEqualWithAccuracy(denormalizer(0.0, 0), 0, epsilon);
    XCTAssertEqualWithAccuracy(denormalizer(0.0, 1), 0, epsilon);
    XCTAssertEqualWithAccuracy(denormalizer(0.0, 2), 0, epsilon);
    XCTAssertEqualWithAccuracy(denormalizer(0.5, 0), 127, epsilon);
    XCTAssertEqualWithAccuracy(denormalizer(0.5, 1), 127, epsilon);
    XCTAssertEqualWithAccuracy(denormalizer(0.5, 2), 127, epsilon);
    XCTAssertEqualWithAccuracy(denormalizer(1.0, 0), 255, epsilon);
    XCTAssertEqualWithAccuracy(denormalizer(1.0, 1), 255, epsilon);
    XCTAssertEqualWithAccuracy(denormalizer(1.0, 2), 255, epsilon);
}

- (void)testPixelDenormalizerForDictionaryParsesStandardNegativeOneToOne {
    // it should return a valid pixel normalizer
    // it should return no error
    
    NSError *error;
    NSDictionary *dict = @{
        @"denormalize": @{
            @"standard": @"[-1,1]"
        }
    };
    
    TIOPixelDenormalizer denormalizer = TIOPixelDenormalizerForDictionary(dict, &error);
    uint8_t epsilon = 1;
    
    XCTAssertNil(error);
    XCTAssertEqualWithAccuracy(denormalizer(-1.0, 0), 0, epsilon);
    XCTAssertEqualWithAccuracy(denormalizer(-1.0, 1), 0, epsilon);
    XCTAssertEqualWithAccuracy(denormalizer(-1.0, 2), 0, epsilon);
    XCTAssertEqualWithAccuracy(denormalizer(0.0, 0), 127, epsilon);
    XCTAssertEqualWithAccuracy(denormalizer(0.0, 1), 127, epsilon);
    XCTAssertEqualWithAccuracy(denormalizer(0.0, 2), 127, epsilon);
    XCTAssertEqualWithAccuracy(denormalizer(1.0, 0), 255, epsilon);
    XCTAssertEqualWithAccuracy(denormalizer(1.0, 1), 255, epsilon);
    XCTAssertEqualWithAccuracy(denormalizer(1.0, 2), 255, epsilon);
}

- (void)testPixelDenormalizerForDictionaryReturnsError {
    // it should return a nil pixel normalizer
    // it should return an error
    
    NSError *error;
    NSDictionary *dict = @{
        @"denormalize": @{
            @"standard": @"[-10, 10]"
        }
    };
    
    TIOPixelDenormalizer denormalizer = TIOPixelDenormalizerForDictionary(dict, &error);
    
    XCTAssertNotNil(error);
    XCTAssertNil(denormalizer);
}

- (void)testPixelDenormalizerForDictionaryParsesScaleAndSameBiases {
    // it should return a valid pixel normalizer
    // it should return no error
    
    NSError *error;
    NSDictionary *dict = @{
        @"denormalize": @{
            @"scale": @(255.0),
            @"bias": @{
                @"r": @(0),
                @"g": @(0),
                @"b": @(0)
            }
        }
    };
    
    TIOPixelDenormalizer denormalizer = TIOPixelDenormalizerForDictionary(dict, &error);
    uint8_t epsilon = 1;
    
    XCTAssertNil(error);
    XCTAssertEqualWithAccuracy(denormalizer(0.0, 0), 0, epsilon);
    XCTAssertEqualWithAccuracy(denormalizer(0.0, 1), 0, epsilon);
    XCTAssertEqualWithAccuracy(denormalizer(0.0, 2), 0, epsilon);
    XCTAssertEqualWithAccuracy(denormalizer(0.5, 0), 127, epsilon);
    XCTAssertEqualWithAccuracy(denormalizer(0.5, 1), 127, epsilon);
    XCTAssertEqualWithAccuracy(denormalizer(0.5, 2), 127, epsilon);
    XCTAssertEqualWithAccuracy(denormalizer(1.0, 0), 255, epsilon);
    XCTAssertEqualWithAccuracy(denormalizer(1.0, 1), 255, epsilon);
    XCTAssertEqualWithAccuracy(denormalizer(1.0, 2), 255, epsilon);
}

- (void)testPixelDenormalizerForDictionaryParsesScaleAndDifferenceBiases {
    // it should return a valid pixel normalizer
    // it should return no error
    
    NSError *error;
    NSDictionary *dict = @{
        @"denormalize": @{
            @"scale": @(255.0),
            @"bias": @{
                @"r": @(-0.1),
                @"g": @(-0.2),
                @"b": @(-0.3)
            }
        }
    };
    
    TIOPixelDenormalizer denormalizer = TIOPixelDenormalizerForDictionary(dict, &error);
    uint8_t epsilon = 1;
    
    XCTAssertNil(error);
    XCTAssertEqualWithAccuracy(denormalizer(0.0+0.1, 0), 0, epsilon);
    XCTAssertEqualWithAccuracy(denormalizer(0.0+0.2, 1), 0, epsilon);
    XCTAssertEqualWithAccuracy(denormalizer(0.0+0.3, 2), 0, epsilon);
    XCTAssertEqualWithAccuracy(denormalizer(0.5+0.1, 0), 127, epsilon);
    XCTAssertEqualWithAccuracy(denormalizer(0.5+0.2, 1), 127, epsilon);
    XCTAssertEqualWithAccuracy(denormalizer(0.5+0.3, 2), 127, epsilon);
    XCTAssertEqualWithAccuracy(denormalizer(1.0+0.1, 0), 255, epsilon);
    XCTAssertEqualWithAccuracy(denormalizer(1.0+0.2, 1), 255, epsilon);
    XCTAssertEqualWithAccuracy(denormalizer(1.0+0.3, 2), 255, epsilon);
}

// MARK: - Quantization

-(void)testDataQuantizerForDictReturnsNil {
    TIODataQuantizer quantizer = TIODataQuantizerForDict(@{});
    XCTAssertNil(quantizer);
}

// MARK: - Dequantization

- (void)testDataDequantizerForDictParsesZeroToOne {
    // Uniformly translates a range of values from [0,255] uint8_t to [0,1] float_t
    const float epsilon = 0.01;
    TIODataDequantizer dequantizer = TIODataDequantizerForDict(@{
        @"dequantize": @{
            @"standard": @"[0,1]"
        }
    });
    XCTAssertNotNil(dequantizer);
    XCTAssert(dequantizer(255) == 1);
    XCTAssert(dequantizer(0) == 0);
    XCTAssertEqualWithAccuracy(dequantizer(127), 0.5, epsilon);
}

- (void)testDataDequantizerForDictReturnsNil {
    TIODataDequantizer dequantizer = TIODataDequantizerForDict(@{});
    XCTAssertNil(dequantizer);
}

@end
