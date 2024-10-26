module elibir;
import elibir::test;
import termcolor;
import dlfcn;
import std::os::process;
import std::io;
import std::core::builtin;
import libc;

fault ElibirFault {
        MAKE_ERROR,
}

fn void! explode() {
        return ElibirFault.MAKE_ERROR?;
}

extern ZString* environ;

fn void create() @init {
        File! so = file::open("../libft/libft.so", "rb");
        if(catch so) {
                usz i;
                SubProcess proc = process::create({"make", "so", "-C" "../libft"}, {}, {"PATH=/bin:/usr/bin:/usr/local/bin"})!!;
                defer proc.destroy();
                if(proc.join()!! != 0) {
                        tc::eset(tc::RED);
                        io::eprintf("[ERROR]");
                        tc::ereset();
                        io::eprintf(" => unable to make .so version of libft\n########################################## Trace ##########################################\n");
                        File out = proc.stderr();
                        while(!out.eof()) {
                                if(try x = out.read_byte()) {
                                        io::eprintf("%c", x);
                                }
                        }
                        io::eprintn("###########################################################################################");
                        io::eprintf(" => unable to make .so version of libft\n########################################## Trace ##########################################\n");
                        File outt = proc.stdout();
                        while(!outt.eof()) {
                                if(try x = outt.read_byte()) {
                                        io::eprintf("%c", x);
                                }
                        }
                        io::eprintn("###########################################################################################");
                        return explode()!!;
                }
        } else {
                so.close()!!;
        }
        test::lft = dl::open("../libft/libft.so", rtld::LAZY)!!;
}
