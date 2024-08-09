use std::fs;

fn main() {
    let n: i32 = fs::read_to_string("input.txt")
        .expect("Failed to read file")
        .trim()
        .parse()
        .expect("Invalid number");

    let mut output = String::new();

    for i in 0..n {
        output.push_str(&format!("{}{}\n", " ".repeat((n-i-1) as usize), "*".repeat((2*i+1) as usize)));
    }

    for i in (0..n-1).rev() {
        output.push_str(&format!("{}{}\n", " ".repeat((n-i-1) as usize), "*".repeat((2*i+1) as usize)));
    }

    fs::write("output.txt", output).expect("Failed to write file");
}
