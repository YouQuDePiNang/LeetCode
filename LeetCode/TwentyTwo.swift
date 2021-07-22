//
//  TwentyTwo.swift
//  LeetCode
//
//  Created by UED on 2021/7/21.
//

import Foundation

class TwentyTwo {
    // 220. 存在重复元素 II
    func containsNearbyAlmostDuplicate(_ nums: [Int], _ k: Int, _ t: Int) -> Bool {
        
        func getID(_ x: Int, _ w: Int) -> Int {
            if x >= 0 {
                return x / w
            }
            return (x + 1) / w - 1
        }
        
        var map = [Int: Int]()
        for (index, num) in nums.enumerated() {
            let id = getID(num, t + 1)
            if let _ = map[id] {
                return true
            }
            if let x = map[id - 1], abs(num - x) <= t {
                return true
            }
            if let y = map[id + 1], abs(num - y) <= t {
                return true
            }
            map.updateValue(num, forKey: id)
            if index >= k {
                map.removeValue(forKey: getID(nums[index - k], t + 1))
            }
        }
        
        return false
    }
    
    // 221. 最大正方形
    func maximalSquare(_ matrix: [[Character]]) -> Int {
        var maxSide = 0
        if matrix.count == 0 || matrix[0].count == 0 {
            return maxSide
        }
        let rows = matrix.count, columns = matrix[0].count
        var dp = [[Int]](repeating: [Int](repeating: 0, count: columns), count: rows)
        for i in 0..<rows {
            for j in 0..<columns {
                if matrix[i][j] == "1" {
                    if i == 0 || j == 0 {
                        dp[i][j] = 1
                    } else {
                        dp[i][j] = min(min(dp[i - 1][j], dp[i][j - 1]), dp[i - 1][j - 1]) + 1
                    }
                    maxSide = max(maxSide, dp[i][j])
                }
            }
        }
        return maxSide * maxSide
    }
    
    // 222. 完全二叉树的节点个数
    func countNodes(_ root: TreeNode?) -> Int {
        var result = 0
        
        func getNode(_ root: TreeNode?) {
            if root == nil {
                return
            }
            result += 1
            getNode(root?.left)
            getNode(root?.right)
        }
        
        getNode(root)
        
        return result
    }
}