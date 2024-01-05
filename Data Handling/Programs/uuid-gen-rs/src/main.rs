use uuid::Uuid;
use std::process::exit;
use std::str::FromStr;

fn main() {
    let mut args = std::env::args();
    let arg = match args.nth(1) {
        Some(number) => number,
        None => String::from("1"),
    };
    match u32::from_str(&arg) {
        Ok(n) => generate_uuids(n),
        Err(..) => {
            println!("Argument can't be converted into number.");
            print_help(-2);
        }
    };

    exit(0);
}

fn generate_uuids(number: u32) {
    for _ in 0..number {
        println!("{}", Uuid::new_v4());
    }
}

fn print_help(code: i32){
    println!("uuidgen usage: uuidgen [n]");
    println!("\tn: number of times to generate a uuid v4. must be non-negative and fit in a rust u32.");
    println!("\tIf no n is given, the program defaults to generating 1 uuid.");
    exit(code);
}
