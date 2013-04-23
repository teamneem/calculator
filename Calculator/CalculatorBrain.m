//
//  CalculatorBrain.m
//  Calculator
//
//  Created by dev1 on 4/19/13.
//  Copyright (c) 2013 Asynchrony. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *programStack;
@end

@implementation CalculatorBrain

@synthesize programStack = _programStack;

- (NSMutableArray *)programStack
{
    if (_programStack == nil) _programStack = [[NSMutableArray alloc] init];
    return _programStack;
}

- (void)pushOperand:(double)operand
{
    [self.programStack addObject:[NSNumber numberWithDouble:operand]];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"stack = %@", self.programStack];
}


- (double)performOperation:(NSString *)operation;
{
    [self.programStack addObject:operation];
    return [CalculatorBrain runProgram:self.program];
}

- (id)program
{
    return [self.programStack copy]; //returns immutable array
}

+ (NSString *)descriptionOfProgram:(id)program
{
    return @"Implement this in assignment 2";
}

+ (double)popOperandOffStack:(NSMutableArray *)stack
{
    double result = 0;
    
    id topOfStack = [stack lastObject];
    if (topOfStack) [stack removeLastObject];
    
    if ([topOfStack isKindOfClass:[NSNumber class]]) {
        result = [topOfStack doubleValue];
    }
    
    else if ([topOfStack isKindOfClass:[NSString class]]) {
        NSString *operation = topOfStack;
        if ([operation isEqualToString:@"+"]) {
            result = [self popOperandOffStack:stack] + [self popOperandOffStack:stack];
        }
        else if ([@"*" isEqualToString:operation]) {
            result = [self popOperandOffStack:stack] * [self popOperandOffStack:stack];
        }
        
        else if ([@"/" isEqualToString:operation]) {
            double divisor = [self popOperandOffStack:stack];
            
            if (divisor != 0) {
                result = [self popOperandOffStack:stack] / divisor;
            }
            else {
                result = 0;
            }
        }
        else if ([@"-" isEqualToString:operation]) {
            result = -[self popOperandOffStack:stack] + [self popOperandOffStack:stack];
        }
    }
    
    return result;
}

+ (double)runProgram:(id)program
{
    NSMutableArray *stack;
    if ([program isKindOfClass:[NSArray class]]) {
        stack = [program mutableCopy];
    }
    
    return [self popOperandOffStack:stack];
}

@end
