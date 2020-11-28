#![warn(clippy::pedantic)]

use std::collections::HashMap;

fn main() {
    let tree = process_words(&["dog", "deer", "deal"]);
    let result = tree.get_words("de");
    assert_eq!(2, result.len());
    assert!(result.contains(&"deer".to_string()));
    assert!(result.contains(&"deal".to_string()));
}

#[derive(Debug)]
struct Tree {
    value: Option<String>,
    next: HashMap<char, Tree>,
}

impl Tree {
    fn new() -> Self {
        Self {
            next: HashMap::new(),
            value: None,
        }
    }

    fn _add(&mut self, word: &str, s: &str) {
        if let Some(c) = s.chars().next() {
            let tree = self.next.entry(c).or_insert_with(Tree::new);
            tree._add(word, &s.chars().skip(1).collect::<String>());
        } else {
            self.value = Some(word.to_string());
        };
    }

    fn add(&mut self, word: &str) {
        self._add(word, word);
    }

    fn get_words(&self, s: &str) -> Vec<String> {
        let mut node = self;
        for c in s.chars() {
            node = match node.next.get(&c) {
                Some(tree) => tree,
                None => return vec![],
            }
        }
        let mut rest = node
            .next
            .values()
            .flat_map(|tree| tree.get_words(""))
            .collect();
        match &node.value {
            Some(word) => {
                let mut v = vec![word.to_string()];
                v.append(&mut rest);
                v
            }
            None => rest,
        }
    }
}

fn process_words(words: &[&str]) -> Tree {
    let mut tree = Tree::new();
    for word in words {
        tree.add(word);
    }
    tree
}
