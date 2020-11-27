// Given a list of integers, write a function that returns the largest sum of
// non-adjacent numbers. Numbers can be 0 or negative.
// 
// For example, [2, 4, 6, 2, 5] should return 13, since we pick 2, 6, and 5. [5,
// 1, 1, 5] should return 10, since we pick 5 and 5.
// 
// Follow-up: Can you do this in O(N) time and constant space?

use std::cmp::max;

fn main() {
    assert_eq!(13, sum_recursive(&[2, 4, 6, 2, 5]));
    assert_eq!(10, sum_recursive(&[4, 5, 2, 5]));
    assert_eq!(13, sum_iterative(&[2, 4, 6, 2, 5]));
    assert_eq!(10, sum_iterative(&[4, 5, 2, 5]));
}

fn sum_recursive(v: &[isize]) -> isize {
    fn sum(v: &[isize], i: isize) -> isize {
        if i < 0 {
            0
        } else {
            max(sum(v, i - 1), sum(v, i - 2) + v[i as usize])
        }
    }
    sum(v, (v.len() - 1) as isize)
}

fn sum_iterative(v: &[isize]) -> isize {
    let mut back_two = v[0];
    let mut back_one = v[1];
    for i in v.iter().skip(2) {
        let temp = max(back_one, back_two + i);
        back_two = back_one;
        back_one = temp;
    }
    back_one
}
