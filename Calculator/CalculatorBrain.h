//
//  CalculatorBrain.h
//  Calculator
//
//  Created by dev1 on 4/19/13.
//  Copyright (c) 2013 Asynchrony. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject
- (void)pushOperand:(double)operand;
- (double)performOperation:(NSString *)operation;

@property (nonatomic, readonly) id program;

+ (double)runProgram:(id)program;
+ (NSString *)descriptionOfProgram:(id)program;

@end
