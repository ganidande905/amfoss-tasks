use std::io;

fn is_prime(num: u32) -> bool {
    if num < 2 {
        return false;
    }
    for i in 2..=(num as f64).sqrt() as u32 {
        if num % i == 0 {
            return false;
        }
    }
    true
}

fn main() {
    println!("Enter a number: ");
    let mut input = String::new();
    io::stdin().read_line(&mut input).expect("Failed to read line");
    let n: u32 = input.trim().parse().expect("Invalid input");

    println!("Prime numbers up to {}:", n);
    for i in 2..=n {
        if is_prime(i) {
            println!("{}", i);
        }
    }
}
