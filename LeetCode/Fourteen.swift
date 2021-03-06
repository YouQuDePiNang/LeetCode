//
//  Fourteen.swift
//  LeetCode
//
//  Created by UED on 2021/6/16.
//

import Cocoa

class Fourteen {
    // 140. 单词拆分 II
    func wordBreak(_ s: String, _ wordDict: [String]) -> [String] {
        var map = [Int: [[String]]]()
        let sArr = s.map { String($0) }
        
        func backtrack(_ length: Int, _ index: Int) -> [[String]] {
            if !map.keys.contains(index) {
                var wordBreaks = [[String]]()
                if index == length {
                    wordBreaks.append([String]())
                } else {
                    for i in index + 1...length {
                        let word = sArr[index..<i].joined()
                        if wordDict.contains(word) {
                            let nextWordBreaks = backtrack(length, i)
                            for nextWordBreak in nextWordBreaks {
                                var wordBreak = nextWordBreak
                                wordBreak.insert(word, at: 0)
                                wordBreaks.append(wordBreak)
                            }
                        }
                    }
                }
                map[index] = wordBreaks
            }
            return map[index]!
        }
        
        let wordBreaks = backtrack(s.count, 0)
        var breakList = [String]()
        for wordBreak in wordBreaks {
            breakList.append(wordBreak.joined(separator: " "))
        }
        return breakList
    }
    
    // 141. 环形链表
    func hasCycle(_ head: ListNode?) -> Bool {
        /** // 方法一
        var array = [String]()
        var head = head
        while head != nil {
            if array.contains(head.debugDescription) {
                return true
            } else {
                array.append(head.debugDescription)
            }
            head = head?.next
        }
        
        return false
        */
        if head == nil || head?.next == nil {
            return false
        }
        var slow = head
        var fast = head?.next
        while slow.debugDescription != fast.debugDescription {
            if fast == nil || fast?.next == nil {
                return false
            }
            slow = slow?.next
            fast = fast?.next?.next
        }
        return true
    }
    
    // 142. 环形链表 II
    func detectCycle(_ head: ListNode?) -> ListNode? {
        /** // 方法一
        var array = [String]()
        var pos = head
        while pos != nil {
            if array.contains(pos.debugDescription) {
                return pos
            } else {
                array.append(pos.debugDescription)
            }
            pos = pos?.next
        }
        return nil
        */
        if head == nil {
            return nil
        }
        var slow = head, fast = head
        while fast != nil {
            slow = slow?.next
            if fast?.next != nil {
                fast = fast?.next?.next
            } else {
                return nil
            }
            if fast.debugDescription == slow.debugDescription {
                var ptr = head
                while ptr.debugDescription != slow.debugDescription {
                    ptr = ptr?.next
                    slow = slow?.next
                }
                return ptr
            }
        }
        return nil
    }
    
    // 143. 重排链表
    func reorderList(_ head: ListNode?) {
        var nodes = [ListNode?]()
        var node = head
        while node != nil {
            nodes.append(node)
            node = node?.next
        }
        
        var i = 0, j = nodes.count - 1
        while i < j {
            let leftNode = nodes[i]
            let rightNode = nodes[j]
            leftNode?.next = rightNode
            i += 1
            if i == j {
                break
            }
            rightNode?.next = nodes[i]
            j -= 1
        }
        let leftNode = nodes[i]
        leftNode?.next = nil
    }
    
    // 144. 二叉树的前序遍历
    func preorderTraversal(_ root: TreeNode?) -> [Int] {
        var orders = [Int]()
        
        func preorder(_ root: TreeNode?) {
            if root == nil {
                return
            }
            orders.append(root!.val)
            preorder(root?.left)
            preorder(root?.right)
        }
        
        preorder(root)
        
        return orders
    }
    
    // 145. 二叉树的后序遍历
    func postorderTraversal(_ root: TreeNode?) -> [Int] {
        var orders = [Int]()
        
        func postorder(_ root: TreeNode?) {
            if root == nil {
                return
            }
            postorder(root?.left)
            postorder(root?.right)
            orders.append(root!.val)
        }
        
        postorder(root)
        
        return orders
    }
    
    // 147. 对链表进行插入排序
    func insertionSortList(_ head: ListNode?) -> ListNode? {
        if head == nil {
            return head
        }
        let dummyHead = ListNode.init(0, head)
        var lastSorted = head, curr = head?.next
        while curr != nil {
            if lastSorted!.val <= curr!.val {
                lastSorted = lastSorted?.next
            } else {
                var prev: ListNode? = dummyHead
                while prev?.next != nil && prev!.next!.val <= curr!.val {
                    prev = prev?.next
                }
                lastSorted?.next = curr?.next
                curr?.next = prev?.next
                prev?.next = curr
            }
            curr = lastSorted?.next
        }
        return dummyHead.next
    }
    
    // 148. 排序链表
    func sortList(_ head: ListNode?) -> ListNode? {
        
        func merge(_ head1: ListNode?, _ head2: ListNode?) -> ListNode? {
            let dummyHead: ListNode? = ListNode.init(0)
            var temp = dummyHead, temp1 = head1, temp2 = head2
            while temp1 != nil && temp2 != nil {
                if temp1!.val <= temp2!.val {
                    temp?.next = temp1
                    temp1 = temp1?.next
                } else {
                    temp?.next = temp2
                    temp2 = temp2?.next
                }
                temp = temp?.next
            }
            if temp1 != nil {
                temp?.next = temp1
            } else if temp2 != nil {
                temp?.next = temp2
            }
            return dummyHead?.next
        }
        
        func address(_ obj: Any?) -> Int {
            let point = Unmanaged<AnyObject>.passUnretained(obj as AnyObject).toOpaque()
            return point.hashValue
        }
        func address2(_ obj: Any?) -> Int {
            let hashValue = withUnsafePointer(to: obj) { (point) -> Int in
                return point.hashValue
            }
            return hashValue
        }
        
        func sortList(_ head: ListNode?, _ tail: ListNode?) -> ListNode? {
            if head == nil {
                return head
            }
            if address(head?.next) == address(tail) {
                head?.next = nil
                return head
            }
            
            var slow = head, fast = head
            while address(fast) != address(tail) {
                slow = slow?.next
                fast = fast?.next
                if address(fast) != address(tail) {
                    fast = fast?.next
                }
            }
            let mid = slow
            let list1 = sortList(head, mid)
            let list2 = sortList(mid, tail)
            let sorted = merge(list1, list2)
            return sorted
        }
        
        return sortList(head, nil)
    }
    
    // 149. 直线上最多的点数
    func maxPoints(_ points: [[Int]]) -> Int {
        
        func gcd(_ a: Int, _ b: Int) -> Int {
            if b == 0 {
                return a
            }
            return gcd(b, a % b)
        }
        
        if points.count < 3 {
            return points.count
        }
        var res = 0
        for i in 0..<points.count {
            var iRepeat = 0
            var dic = [String: Int]()
            var iMaxP = 0
            for j in i + 1..<points.count {
                var x = points[j][0] - points[i][0]
                var y = points[j][1] - points[i][1]
                if x == 0 && y == 0 {
                    iRepeat += 1
                    continue
                }
                let gcdValue = gcd(x, y)
                x /= gcdValue
                y /= gcdValue
                let key = "\(x)-\(y)"
                dic[key, default: 0] += 1
                iMaxP = max(iMaxP, dic[key]!)
            }
            res = max(res, iMaxP + iRepeat + 1)
        }
        return res
    }
}
