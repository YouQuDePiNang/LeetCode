//
//  Seventeen.swift
//  LeetCode
//
//  Created by UED on 2021/6/28.
//

import Cocoa

class Seventeen: NSObject {
    // 171. Excel表列序号
    func titleToNumber(_ columnTitle: String) -> Int {
        func number(_ title: String) -> Int {
            switch title {
            case "A": return 1
            case "B": return 2
            case "C": return 3
            case "D": return 4
            case "E": return 5
            case "F": return 6
            case "G": return 7
            case "H": return 8
            case "I": return 9
            case "J": return 10
            case "K": return 11
            case "L": return 12
            case "M": return 13
            case "N": return 14
            case "O": return 15
            case "P": return 16
            case "Q": return 17
            case "R": return 18
            case "S": return 19
            case "T": return 20
            case "U": return 21
            case "V": return 22
            case "W": return 23
            case "X": return 24
            case "Y": return 25
            case "Z": return 26
            default : return 0
            }
        }
        
        let titles = columnTitle.map { String($0) }
        var ans = 0
        var multiple = 1
        
        for i in stride(from: titles.count - 1, through: 0, by: -1) {
            print(i)
        }
        
        for i in (0..<titles.count).reversed() {
            let num = number(titles[i])
            ans += num * multiple
            multiple *= 26
        }
        
        return ans
    }
    
    // 172. 阶乘后的零
    func trailingZeroes(_ n: Int) -> Int {
        var zeroCount = 0
        var n = n
        while n > 0 {
            n /= 5
            zeroCount += n
        }
        return zeroCount
    }
    
    // 174. 地下城游戏
    func calculateMinimumHP(_ dungeon: [[Int]]) -> Int {
        let n = dungeon.count, m = dungeon[0].count
        var dp = [[Int]](repeating: [Int](repeating: Int.max, count: m + 1), count: n + 1)
        
        dp[n][m - 1] = 1
        dp[n - 1][m] = 1
        
        for i in stride(from: n - 1, through: 0, by: -1) {
            for j in stride(from: m - 1, through: 0, by: -1) {
                let minValue = min(dp[i + 1][j], dp[i][j + 1])
                dp[i][j] = max(minValue - dungeon[i][j], 1)
            }
        }
        
        return dp[0][0]
    }
    
    // 175. 组合两个表
    // SELECT FirstName, LastName, City, State FROM Person LEFT JOIN Address ON Person.PersonId = Address.PersonId
    
    // 176. 第二高的薪水
    // SELECT (SELECT DISTINCT Salary FROM Employee ORDER BY Salary DESC LIMIT 1 OFFSET 1) AS SecondHighestSalary
    
    // 177. 第N高的薪水
    /**
     CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
     BEGIN
        SET N := N - 1;
        RETURN (
            # Write your MySQL query statement below
            
            SELECT Salary FROM Employee GROUP BY Salary ORDER BY Salary DESC LIMIT N, 1
        );
     END
     */
    
    // 178. 分数排名
    /**
     SELECT Score, DENSE_RANK() OVER (ORDER BY Score DESC) AS `Rank` FROM Scores
     */
    
    // 179. 最大数
    func largestNumber(_ nums: [Int]) -> String {
        let n = nums.count
        var numsArr = [Int](repeating: 0, count: n)
        for i in 0..<n {
            numsArr[i] = nums[i]
        }
        
        numsArr.sort { (x, y) -> Bool in
            var sx = 10, sy = 10
            while sx <= x {
                sx *= 10
            }
            while sy <= y {
                sy *= 10
            }
            return sy * x + y > sx * y + x
        }
        
        if numsArr[0] == 0 {
            return "0"
        }
        var string = ""
        for num in numsArr {
            string += "\(num)"
        }
        return string
    }
}
