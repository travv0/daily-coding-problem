// You run an e-commerce website and want to record the last N order ids in a
// log. Implement a data structure to accomplish this, with the following API:
// 
//     record(order_id): adds the order_id to the log
//     get_last(i): gets the ith last element from the log. i is guaranteed to be
//                  smaller than or equal to N.
// 
// You should be as efficient with time and space as possible.

#[warn(clippy::pedantic)]

fn main() {
    let mut log = Log::new(5);
    log.record(1);
    log.record(2);
    log.record(3);
    log.record(4);
    assert_eq!(Some(2), log.get_last(2));
    assert_eq!(None, log.get_last(4));
    log.record(5);
    log.record(6);
    assert_eq!(Some(4), log.get_last(2));
    assert_eq!(Some(6), log.get_last(0));
    assert_eq!(None, log.get_last(5));
}

#[derive(Debug)]
struct Log {
    entries: Vec<Option<usize>>,
    curr_index: usize,
    size: usize,
}

impl Log {
    fn new(size: usize) -> Self {
        Log {
            entries: vec![None; size],
            curr_index: 0,
            size,
        }
    }

    fn record(&mut self, order_id: usize) {
        self.curr_index = (self.curr_index + 1) % self.size;
        self.entries[self.curr_index] = Some(order_id);
    }

    fn get_last(&self, i: usize) -> Option<usize> {
        if i < self.size {
            self.entries[(self.curr_index + (self.size - i)) % self.size]
        } else {
            None
        }
    }
}
