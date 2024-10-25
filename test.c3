module elibir::test;
import elibir::alloc;
import std::io;
import termcolor;

def TestFn = fn void!();

fault TestFault {
        NOT_FOUNDED,
        MALLOC,
        FREE,
        FAILED,
}

Handle lft = null;

fn void execTest(String name, TestFn test) {
        if(catch test()) {
                case TestFault.NOT_FOUNDED:
                        io::eprintf("%s: ", name);
                        tc::eset(tc::RED);
                        io::eprintf("[NF]");
                        tc::ereset();
                        io::eprintfn(" => function %s not founded", name);
                case TestFault.MALLOC:
                        io::eprintf("%s: ", name);
                        tc::eset(tc::RED);
                        io::eprintf("[MKO]");
                        tc::ereset();
                        io::eprintfn(" => %x allocation leaking", alloc::alloced);
                case TestFault.FREE:
                        io::eprintf("%s: ", name);
                        tc::eset(tc::RED);
                        io::eprintf("[FKO]");
                        tc::ereset();
                        io::eprintfn(" => %x free unalloced memory", alloc::alloced);
                case TestFault.FAILED:
                        io::eprintf("%s: ", name);
                        tc::eset(tc::RED);
                        io::eprintf("[KO]");
                        tc::ereset();
                        io::eprintn(" => Error during test");
        } else {
                io::printf("%s: ", name);
                tc::set(tc::GREEN);
                io::printfn("[OK]");
                tc::reset();
        }
}
