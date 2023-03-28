//
//  main.swift
//  BaekJoon#1715
//
//  Created by 김병엽 on 2023/03/28.
//
// Reference: https://woongsios.tistory.com/266

struct Heap<T> {

    var nodes: Array<T> = []
    let comparer: (T, T) -> Bool

    init(comparer: @escaping (T, T) -> Bool) {
        self.comparer = comparer
    }

    var count: Int {
        return nodes.count
    }

    var isEmpty: Bool {
        return nodes.isEmpty
    }

    func peek() -> T? {
        return nodes.first
    }

    mutating func insert(_ element: T) {

        var index = nodes.count

        nodes.append(element)

        while index > 0, comparer(nodes[index], nodes[(index - 1) / 2]) {
            nodes.swapAt(index, (index - 1) / 2)
            index = (index - 1) / 2
        }

    }

    mutating func delete() -> T? {

        guard !nodes.isEmpty else {
            return nil
        }

        if nodes.count == 1 {
            return nodes.removeFirst()
        }

        let result = nodes.first
        nodes.swapAt(0, nodes.count - 1)
        _ = nodes.popLast()

        var index = 0

        while index < nodes.count {

            let left = index * 2 + 1
            let right = left + 1

            if right < nodes.count {
                if !comparer(nodes[left], nodes[right]), !comparer(nodes[index], nodes[right]) {
                    nodes.swapAt(index, right)
                    index = right
                } else if !comparer(nodes[index], nodes[left]) {
                    nodes.swapAt(index, left)
                    index = left
                } else {
                    break
                }
            } else if left < nodes.count {
                if !comparer(nodes[index], nodes[left]) {
                    nodes.swapAt(index, left)
                    index = left
                } else {
                    break
                }
            } else {
                break
            }
        }

        return result
    }

}

extension Heap where T: Comparable {

    init() {
        self.init(comparer: <)
    }

}

func solution() {

    let n = Int(readLine()!)!

    var heap = Heap<Int>()
    var result = 0

    for _ in 0..<n {

        let num = Int(readLine()!)!
        heap.insert(num)

    }
    
    while heap.count > 1 {

        let n1 = heap.delete()!
        let n2 = heap.delete()!

        result += n1 + n2
        heap.insert(n1 + n2)
    }

    print(result)

}

solution()
