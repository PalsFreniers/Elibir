import std::io;
import std::core::builtin;
import std::os::process;

fn void main() {
        SubProcess! proc = process::create({"echo", "Hello World!"});
        defer proc.destroy()!!;
        if(catch proc) {
                builtin::default_panic("unable to create subprocess", "", "", 0);
        }
        proc.join()!!;
        File out = proc.stdout()!!;
        while(!out.eof()) {
                if(try x = out.read_byte()) {
                        io::printf("%c", x);
                }
        }
}
