// Given two singly linked lists that intersect at some point, find the
// intersecting node. The lists are non-cyclical.
//
// For example, given A = 3 -> 7 -> 8 -> 10 and B = 99 -> 1 -> 8 -> 10, return
// the node with value 8.
//
// In this example, assume nodes with the same value are the exact same node
// objects.
//
// Do this in O(M + N) time (where M and N are the lengths of the lists) and
// constant space.

use list::*;
use std::iter::Iterator;
use std::rc::Rc;

fn main() {
    let mut list1 = List::new();
    list1.push(10);
    list1.push(8);
    list1.push(7);
    list1.push(3);

    let mut list2 = List::new();
    list2.push(10);
    list2.push(8);
    list2.push(1);
    list2.push(99);
    list2.push(12);
    list2.push(84);

    assert_eq!(8, find_intersection(list1, list2).unwrap().value);
}

fn find_intersection<T>(list1: List<T>, list2: List<T>) -> Option<Rc<Node<T>>>
where
    T: PartialEq,
{
    let (mut long_list, mut short_list) = if list1.len() > list2.len() {
        (list1, list2)
    } else {
        (list2, list1)
    };
    while long_list.len() != short_list.len() {
        long_list.next();
    }
    for (node1, node2) in long_list.zip(&mut short_list) {
        if node1 == node2 {
            return Some(node1);
        }
    }
    None
}

mod list {
    use std::rc::Rc;

    pub struct List<T> {
        head: Option<Rc<Node<T>>>,
        len: usize,
    }

    pub struct Node<T> {
        pub value: T,
        next: Option<Rc<Node<T>>>,
    }

    impl<T> Default for List<T> {
        fn default() -> Self {
            List { head: None, len: 0 }
        }
    }

    impl<T> List<T> {
        pub fn new() -> Self {
            Self::default()
        }

        pub fn push(&mut self, elem: T) {
            self.head = Some(Rc::new(Node {
                value: elem,
                next: self.head.clone(),
            }));
            self.len += 1;
        }

        pub fn len(&self) -> usize {
            self.len
        }
    }

    impl<T> Iterator for List<T> {
        type Item = Rc<Node<T>>;

        fn next(&mut self) -> Option<Self::Item> {
            let ret = self.head.clone();
            if let Some(node) = &self.head {
                self.head = node.next.clone();
            }
            self.len -= 1;
            ret
        }
    }

    impl<T> PartialEq for Node<T>
    where
        T: PartialEq,
    {
        fn eq(&self, other: &Self) -> bool {
            self.value == other.value
        }
    }
}
