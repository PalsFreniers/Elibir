module elibir::alloc;
import dlfcn;
import libc;
import std::io;

def Malloc = fn void*(usz);
def Free = fn void(void*);

Malloc libcMalloc = null;
Free libcFree = null;

isz alloced = 0;

fn void reset() {
        alloced = 0;
}

fn void initAlloc() {
        libcMalloc = (Malloc)rtld::NEXT.getSymbol("malloc")!!;
        libcFree = (Free)rtld::NEXT.getSymbol("free")!!;
}

fn void* malloc(usz size) @extern("malloc") {
        if(libcMalloc == null) initAlloc();
        alloced++;
        char* ptr = libcMalloc(size);
        io::printn("dflkqjnsdlkfnsqdlkfnqskdljfnsqdlkjfnsqdlkfnsqdlkf");
        if(ptr != null) {
                for(usz i = 0; i < size; i++) {
                        ptr[i] = 69;
                }
        }
        return ptr;
}

fn void free(void* ptr) @extern("free") {
        if(libcMalloc == null) initAlloc();
        alloced--;
        libcFree(ptr);
}
