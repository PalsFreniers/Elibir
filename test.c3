module elibir::test;
import elibir::defs;
import elibir::alloc;
import std::io;
import dlfcn;
import termcolor;

Handle lft = null;

fn void strlenTests() @test {
        if(lft == null) elibir::create();
        Strlen! ft_strlen = lft.getSymbol("ft_strlen");
        if(catch ft_strlen) unreachable("unable to find function ft_strlen");
        Strlen strlen = ft_strlen;
        assert(strlen("Hello World!") == 12, "test: ft_strlen(\"Hello World\");");
}

fn void callocTests() @test {
        if(lft == null) elibir::create();
        Calloc! ft_calloc = lft.getSymbol("ft_calloc");
        if(catch ft_calloc) unreachable("unable to find function ft_calloc");
        Calloc calloc = ft_calloc;
        alloc::reset();
        void* tmp = calloc(10, 1);
        assert(tmp != null, "test: ft_calloc(10, 1);");
        assert(alloc::alloced == 1, "calloc did not do any allocations");
        alloc::free(tmp);
}
