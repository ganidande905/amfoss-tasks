use std::fs;

fn main() {
    let content = fs::read_to_string("input.txt").expect("Failed to read file");
    fs::write("output.txt", content).expect("Failed to write file");
}
