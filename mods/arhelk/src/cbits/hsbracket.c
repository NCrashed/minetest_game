#include <HsFFI.h>

static void mod_enter(void) __attribute__((constructor));
static void mod_enter(void)
{
  static char *argv[] = { "libmod.so", 0 }, **argv_ = argv;
  static int argc = 1;
  hs_init(&argc, &argv_);
}

static void mod_exit(void) __attribute__((destructor));
static void mod_exit(void)
{
  hs_exit();
}