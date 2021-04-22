//
//  Four.swift
//  liangshuzhihe
//
//  Created by UED on 2021/4/22.
//

import Cocoa

class Four: NSObject {
    // 31. 下一个排列
    func nextPermutation(_ nums: inout [Int]) {
        func swap(nums: inout [Int], i: Int, j: Int) {
            let temp = nums[i]
            nums[i] = nums[j]
            nums[j] = temp
        }
        
        func reverse(nums: inout [Int], start: Int) {
            var left = start, right = nums.count - 1
            while left < right {
                swap(nums: &nums, i: left, j: right)
                left += 1
                right -= 1
            }
        }
        
        var i = nums.count - 2
        while i >= 0 && nums[i] >= nums[i + 1] {
            i -= 1
        }
        if i >= 0 {
            var j = nums.count - 1
            while j >= 0 && nums[i] >= nums[j] {
                j -= 1
            }
            swap(nums: &nums, i: i, j: j)
        }
        reverse(nums: &nums, start: i + 1)
    }
    
    // 32. 最长有效括号
    func longestValidParentheses(_ s: String) -> Int {
        var maxans = 0
        var stack = [Int]()
        stack.append(-1)
        for i in 0..<s.count {
            if (s as NSString).substring(with: NSRange.init(location: i, length: 1)) == "(" {
                stack.append(i)
            } else {
                stack.removeLast()
                if stack.count == 0 {
                    stack.append(i)
                } else {
                    maxans = max(maxans, i - (stack.last ?? -1))
                }
            }
        }
        return maxans
    }
}