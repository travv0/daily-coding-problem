#![warn(clippy::pedantic)]

use std::collections::HashMap;

fn main() {
    let tree = CompletionTree::from(&["dog", "deer", "deal"]);
    let result = tree.get_completions("de");
    assert_eq!(2, result.len());
    assert!(result.contains(&"deer".to_string()));
    assert!(result.contains(&"deal".to_string()));
}

#[derive(Debug)]
struct CompletionTree {
    value: Option<String>,
    next: HashMap<char, Self>,
}

impl CompletionTree {
    fn new() -> Self {
        Self {
            next: HashMap::new(),
            value: None,
        }
    }

    fn from(words: &[&str]) -> Self {
        let mut tree = Self::new();
        for word in words {
            tree.add(word);
        }
        tree
    }

    fn add(&mut self, word: &str) {
        fn add(tree: &mut CompletionTree, word: &str, s: &str) {
            if let Some(c) = s.chars().next() {
                let mut tree = tree.next.entry(c).or_insert_with(CompletionTree::new);
                add(&mut tree, word, &s.chars().skip(1).collect::<String>());
            } else {
                tree.value = Some(word.to_string());
            };
        }

        add(self, word, word);
    }

    fn get_completions(&self, s: &str) -> Vec<String> {
        let mut node = self;
        for c in s.chars() {
            match node.next.get(&c) {
                Some(tree) => node = tree,
                None => return vec![],
            }
        }
        node.flatten()
    }

    fn flatten(&self) -> Vec<String> {
        let mut result = self
            .next
            .values()
            .flat_map(Self::flatten)
            .collect::<Vec<_>>();
        if let Some(word) = &self.value {
            result.push(word.to_string());
        };
        result
    }
}
