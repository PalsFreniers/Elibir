import elibir;
import termcolor;
import dlfcn;
import std::os::process;
import std::io;

fn void create() {
        File! so = File::open("../libft/libft.so", "rb");
        if(catch so) {
                SubProcess proc = create({"/bin/make", "so", "-C" "../libft"})!!;
                defer proc.destroy();
                if(proc.join()!! != 0) {
                        tc::eset(RED);
                        io::eprintf("[ERROR]");
                        tc::ereset();
                        io::eprintf("unable to make .so version of libft\nTrace:\n");
                        File out = proc.stdout()!!;
                        while(!out.eof()) {
                                if(try x = out.read_byte()) {
                                        io::printf("%c", x);
                                }
                        }
                        return;
                }
        } else {
                so.close()!!;
        }
        test::lft = dl::open("../libft/libft.so", rtld::LAZY);
}
