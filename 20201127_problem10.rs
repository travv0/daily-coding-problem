// Implement a job scheduler which takes in a function f and an integer n, and
// calls f after n milliseconds.

use std::thread::{sleep, spawn};
use std::time::Duration;

fn main() {
    schedule(|| println!("Hello"), 5000);
    schedule(|| println!("Hi there"), 3000);
    sleep(Duration::from_secs(7));
}

fn schedule(f: fn(), n: u64) {
    spawn(move || {
        sleep(Duration::from_millis(n));
        f();
    });
}
