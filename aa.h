/* c++ header file for aalib glue class */

#ifdef __cplusplus
extern "C" {
#endif
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include <aalib.h>
#include "ppport.h"
#ifdef __cplusplus
    extern struct aa_hardware_params aa_defparams;
    //extern struct aa_driver mem_d;
    //extern struct aa_driver save_d;
}
#endif
#include <iostream.h>

class AA {
    struct aa_context* c;
    struct aa_hardware_params *hparams;
    struct aa_renderparams *rparams;
    int is_init;
    int mouse_x;
    int mouse_y;
    int mouse_b;
    
  public:
    AA();
    ~AA();
    
    /* helper */

    int easyinit();
    int htmlinit();
    void test();
    int autoinitkbd(int);
    void uninitkbd();
    int autoinitmouse(int);
    void uninitmouse();
    int AA::_parseoptions(SV *);

    /* glue */
    
    int imgwidth();
    int imgheight();
    void putpixel(int, int, int);
    void hidecursor();
    void showcursor();
    void fastrender(int, int, int, int);
    int scrwidth();
    int scrheight();
    int printf(int, int, enum aa_attribute, const char *, ...);
    void puts(int, int, enum aa_attribute, const char *);
    void flush();
    char * image();

    int getevent(int);
    void _getmouse();
    int getmousex();
    int getmousey();
    int getmouseb();
    void hidemouse();
    void showmouse();
};


