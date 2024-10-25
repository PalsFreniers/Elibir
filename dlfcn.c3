module dlfcn::dl;

distinct Handle = void*;
distinct Fun = void*;


extern fn Handle dlopen(char* file, int flag);
extern fn char* dlerror();
extern fn Fun dlsym(Handle h, char* name);
extern fn int dlclose(Handle h);

fn Handle open(char* file, int flag) => dlopen(file, flag);
fn Fun Handle.getSymbol(self, char* name) => dlsym(self, name);
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
