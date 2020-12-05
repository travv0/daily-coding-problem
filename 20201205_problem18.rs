// Given an array of integers and a number k, where 1 <= k <= length of the
// array, compute the maximum values of each subarray of length k.
// 
// For example, given array = [10, 5, 2, 7, 8, 7] and k = 3, we should get: [10,
// 7, 8, 8], since:
// 
//     10 = max(10, 5, 2)
//     7 = max(5, 2, 7)
//     8 = max(2, 7, 8)
//     8 = max(7, 8, 7)
// 
// Do this in O(n) time and O(k) space. You can modify the input array in-place
// and you do not need to store the results. You can simply print them out as
// you compute them.

use std::collections::VecDeque;

fn main() {
    print_maximums(&[10, 5, 2, 7, 8, 7], 1);
    print_maximums(&[10, 5, 2, 7, 8, 7], 2);
    print_maximums(&[10, 5, 2, 7, 8, 7], 3);
    print_maximums(&[1, 2, 4, 3, 6, 3, 2, 3, 1, 6], 3);
}

fn print_maximums(v: &[usize], k: usize) {
    let mut deque = VecDeque::with_capacity(k);
    for (i, &n) in v.iter().enumerate() {
        while deque.len() >= k || !deque.is_empty() && deque.front() <= Some(&n) {
            deque.pop_front();
        }
        deque.push_back(n);
        if i >= k - 1 {
            print!(
                "{}{}",
                deque.front().unwrap(),
                if i < v.len() - 1 { ", " } else { "" }
            );
        }
    }
    println!();
}
