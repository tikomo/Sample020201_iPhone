//
//  ViewController.m
//  Sample010201
//
//  Created by tikomo on 2014/02/02.
//  Copyright (c) 2014年 tikomo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end





@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    

    // データを集合として扱えるセット
    //
    // データを集合として扱うなんてあまり見ないコードだな〜
    //
    
    // NSSet Class, NSMutableSet Class
    NSArray* color1 = @[@"blue", @"red", @"yellow", @"white", @"navy"];
    NSArray* color2 = @[@"green", @"black", @"aqua", @"white", @"yellow"];
    NSSet* colorSet1 = [NSSet setWithArray:color1];
    NSSet* colorSet2 = [NSSet setWithArray:color2];
    
    // 和集合 A - 合わせたもの - [A unionSet: B]
    NSMutableSet* allColors = [NSMutableSet setWithCapacity:1];
    [allColors unionSet:colorSet1];
    [allColors unionSet:colorSet2];
    
    NSLog(@"%@", allColors);
    
    NSArray* colorsArray = [allColors allObjects]; // セットを配列にする
    
    for(int i = 0; i < colorsArray.count; i++){
        
        NSString* str = colorsArray[i];
        NSLog(@"%d - %@", i, str);
    }
    
    // 積集合 - 重なった値 - [A intersectSet: B]
    NSMutableSet* commonColors = [NSMutableSet setWithArray:color1];
    [commonColors intersectSet:colorSet2];
    
    NSLog(@"%@", commonColors);

    // 以下のように記述しても
    NSMutableSet* tmpSets = [NSMutableSet setWithCapacity:1];
    [tmpSets unionSet:colorSet1];
    [tmpSets intersectSet:colorSet2];
    
    NSLog(@"%@", tmpSets);
    
    
    // 集合差 - 除いた値 - [A minusSet: B]
    // Aの集合からBの集合の値を除いたあたい...みたいな感じ
    NSMutableSet* minusColors = [NSMutableSet setWithArray:color1];
    [minusColors minusSet:colorSet2];
    
    NSLog(@"%@", minusColors);
    

    [self test1]; // こういう書き方も慣れないな〜
    [self test2];
    [self test3];
    [self test4];
    
    
    
}

- (void)test1 {
    NSLog(@"%@", @"----- test1");

    // 集合Aの中に集合Bが含まれるかどうか
    // いままで使ったことないな〜

    NSSet* set1 = [NSSet setWithArray:@[@"blue", @"red", @"white", @"yellow"]];
    NSSet* set2 = [NSSet setWithArray:@[@"blue", @"white"]];
    NSSet* set3 = [NSSet setWithArray:@[@"pink", @"white"]];

    NSLog(@"set1にset2が含まれるか？ %@", ([set2 isSubsetOfSet:set1] == YES ? @"YES":@"NO")); // YES
    NSLog(@"set1にset3が含まれるか？ %@", ([set3 isSubsetOfSet:set1] == YES ? @"YES":@"NO")); // NO
    
    
}

- (void) test2{
    NSLog(@"%@", @"----- test2");

    // フィルタリング
    // NSMutableArray同様NSSetでもフィルタリングを利用します。
    
    NSSet* sourceSet = [NSSet setWithArray:@[@"one", @"two", @"three", @"four", @"five"]];
    NSPredicate* predicate1 = [NSPredicate predicateWithFormat:@"%K beginswith %@", @"self", @"t"]; // ”T" 始まり
    NSSet* filterSet = [sourceSet filteredSetUsingPredicate:predicate1];
    
    NSLog(@"%@", filterSet);
}

- (void) test3 {
    NSLog(@"%@", @"----- test3");
    // 順番が保持されるオーダーセット
    
    // まずは、順番が保持されないオーダーセット
    NSArray* nums = @[@"one", @"two", @"three", @"four", @"five"];
    NSMutableSet *numSet = [NSMutableSet setWithArray:nums];
    
    // 値を追加する
    [numSet addObject:@"six"];
    NSLog(@"numSet = %@", numSet);
    
    // 順番が保持されるオーダーセット
    NSMutableOrderedSet *numOderSet = [NSMutableOrderedSet orderedSetWithArray:nums];
    
    [numOderSet addObject:@"six"];
    NSLog(@"numOderSet = %@", numOderSet);
    
    // オーダーセットから順番で取り出す
    NSLog(@"numOderSet[0] = %@", numOderSet[0]);
    
    // 順番に取り出す
    for(int i = 0; i < numOderSet.count; i++) {
        NSLog(@"numOderSet[%d] = %@", i, numOderSet[i]);
    }
    
}



- (void) test4 {
    NSLog(@"%@", @"----- test4");
    
    // オーダーセットの値をソートする
    NSComparisonResult (^comparator)(id , id) =^ (id obj1, id obj2) {
        int v1 = [obj1 intValue];
        int v2 = [obj2 intValue];
        
        if (v1 < v2){
            return (NSComparisonResult) NSOrderedAscending;
        } else if (v1 > v2){
            return (NSComparisonResult) NSOrderedDescending;
        } else {
            return (NSComparisonResult) NSOrderedSame;
        }
    };
    
    NSArray *nums = @[@8, @7, @2, @5, @10];
    
    NSMutableOrderedSet *numOderSet = [NSMutableOrderedSet orderedSetWithArray:nums];
    
    // cmparatorを使ってソートする
    NSArray *sortedArray = [numOderSet sortedArrayUsingComparator:comparator];
    
    NSLog(@"sortedArray = %@", sortedArray);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
