#include <ruby.h>
#include <unistd.h>
#include <sys/times.h>

// From ruby >= 2.0.0, following ruby codes are available, though
// 
//     require 'etc'
//     Etc.sysconf(Etc::SC_CLK_TCK)
static VALUE
rb_clock_tick(VALUE self)
{
    long hertz = (double)sysconf(_SC_CLK_TCK);
    return LONG2NUM(hertz);
}

void
Init_get_process_start_time(void)
{
    VALUE class = rb_define_class("GetProcessStartTime", rb_cObject);
    rb_define_singleton_method(class, "clock_tick", rb_clock_tick, 0);
}
