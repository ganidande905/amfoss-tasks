use std::io;

fn main() {
    let mut input = String::new();
    println!("Enter a number: ");
    io::stdin().read_line(&mut input).expect("Failed to read input");
    let n: i32 = input.trim().parse().expect("Invalid number");

    for i in 0..n {
        println!("{}{}", " ".repeat((n-i-1) as usize), "*".repeat((2*i+1) as usize));
    }

    for i in (0..n-1).rev() {
        println!("{}{}", " ".repeat((n-i-1) as usize), "*".repeat((2*i+1) as usize));
    }
}
