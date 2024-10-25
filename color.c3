module termcolor::tc;
import std::io;

distinct Color = String;

const Color RESET = "\e[0m";
const Color RED = "\e[0;31m";
const Color GREEN = "\e[0;32m";

fn void reset() {
        io::printf((String)RESET);
}

fn void ereset() {
        io::eprintf((String)RESET);
}

fn void set(Color c) {
        io::printf((String)c);
}

fn void eset(Color c) {
        io::eprintf((String)c);
}
