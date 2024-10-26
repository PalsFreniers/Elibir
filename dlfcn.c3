module dlfcn::dl;

def Handle = void*;
def Fun = void*;

fault DlfcnFault {
        SYM_NOT_FOUNDED,
        FILE_NOT_FOUNDED,
}

extern fn Handle dlopen(char* file, int flag);
extern fn char* dlerror();
extern fn Fun dlsym(Handle h, char* name);
extern fn int dlclose(Handle h);

fn Handle! open(char* file, int flag) {
        Fun ret = dlopen(file, flag);
        if(ret == null) return DlfcnFault.FILE_NOT_FOUNDED?;
        return ret;
}

fn Fun! Handle.getSymbol(self, char* name) {
        Fun ret = dlsym(self, name);
        if(ret == null) return DlfcnFault.SYM_NOT_FOUNDED?;
        return ret;
}

fn void Handle.close(self) => dlclose(self);

module dlfcn::dl::rtld;
import dlfcn::dl;

const LAZY = 0x00001;
const NOW = 0x00002;
const BINDING_MASK = 0x3;
const NOLOAD = 0x00004;
const DEEPBIND = 0x00008;
const GLOBAL = 0x00100;
const LOCAL = 0;
const NODELETE = 0x01000;

const Handle NEXT = (Handle)(usz)-1;
const Handle DEFAULT = (Handle)0;
