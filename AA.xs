#include "aa.h"

AA::AA() {
    is_init = 0;
    hparams = &aa_defparams;
    rparams = &aa_defrenderparams;
}

AA::~AA() {
    if (is_init > 0) {
        aa_close(c);
        is_init = 0;
    }
}

int AA::easyinit() {
    if ((c = aa_autoinit(hparams))==NULL) {
        return 0;
    }
    is_init = 1;
    return 1;
}

int AA::autoinitkbd(int mode) {
    aa_autoinitkbd(c, mode);
}

void AA::uninitkbd() {
    aa_uninitkbd(c);
}

int AA::autoinitmouse(int mode) {
    aa_autoinitmouse(c, mode);
}

void AA::uninitmouse() {
    aa_uninitmouse(c);
}

char * getarstring(AV *source, I32 i) {
    SV ** sv = av_fetch(source, i, FALSE);
    return SvPV(*sv, PL_na);
}

char ** ar2argv(SV *in) {
    char ** target;
    AV *tempav;
    I32 len;
    int i;
    SV **tv;
    if (!SvROK(in)) { croak("input is not a ref!"); }
    tempav = (AV *)SvRV(in);
    len = av_len(tempav);
    target = (char **)malloc((len+2)*sizeof(char *));
    for (i=0;i<=len;i++) {
        tv = av_fetch(tempav, i, 0);
        target[i] = (char *) SvPV(*tv, PL_na);
    }
    return target;
}

SV * argv2ar(char **in) {
    AV * myav;
    SV **svs;
    SV *target;
    int i = 0, len = 0;
    while (in[len]) {
        len++;
        if (in[len-1]) {
            cout << len-1 << "] " << in[len-1] << "\n";
        }
        else {
            cout << "nil\n";
        }
    }
    svs = (SV **) malloc(len*sizeof(SV *));
    for (i = 0; i < len; i++) {
        svs[i] = sv_newmortal();
        cout << i << ") " << in[i] << "\n";
        sv_setpv((SV*)svs[i],in[i]);
    }
    myav = av_make(len,svs);
    free(svs);
    target = newRV((SV *)myav);
    sv_2mortal(target);
    return target;
}

int AA::_parseoptions(SV *argv) {
    int argc, ret;
    char ** args;
    args = ar2argv(argv);
    argc = (int)av_len((AV *)SvRV(argv));
    ret = aa_parseoptions(hparams, rparams, &argc, args);
    if (!ret) {
        cout << aa_help << "\n";
    }
    //argv = argv2ar(args);
    free(args);
    return ret;
}

int AA::htmlinit() {
    /*
    struct aa_savedata *opt;
    opt = malloc(sizeof(struct aa_savedata));
    opt->name = "zzzzzzlette";
    opt->format = &aa_html_format;
    c = aa_init(&mem_d,&aa_defparams,NULL);
    if (c==NULL) {
        is_init = 1;
    }
    return is_init;
    */
    return 0;
}

void AA::test() {
    int i, y;
    for (i = 0; i < aa_imgwidth(c); i++)
      for (y = 0; y< aa_imgheight(c); y++)
        putpixel(i, y, i + y < 80 ? i : ((i + y) < 100 ? (i + y == 89 ? 150 : 0) : y * 8));
    hidecursor();
    fastrender(0, 0, scrwidth(), scrheight());
    aa_printf(c,0, 0, AA_SPECIAL, "Fast rendering routine %i",1);
    flush();
}

/* real glue here */

int AA::imgwidth() {
    return aa_imgwidth(c);
}

int AA::imgheight() {
    return aa_imgheight(c);
}

void AA::putpixel(int x, int y, int color) {
    aa_putpixel(c, x, y, color);
}

void AA::hidecursor() {
    aa_hidecursor(c);
}

void AA::showcursor() {
    aa_showcursor(c);
}

void AA::fastrender(int x1, int y1, int x2, int y2) {
    aa_fastrender(c,x1,y1,x2,y2);
}

int AA::scrwidth() {
    return aa_scrwidth(c);
}

int AA::scrheight() {
    return aa_scrheight(c);
}

int AA::printf(int x, int y, enum aa_attribute opts, const char *fmt, ...) {
    return aa_printf(c, x, y, opts, fmt);
}

void AA::puts(int x, int y, enum aa_attribute opts, const char *str) {
    aa_puts(c, x, y, opts, str);
}

void AA::flush() {
    aa_flush(c);
}

char * AA::image() {
    unsigned char * fb;
    fb = aa_image(c);
    int x, y;
    for (y=0;y<imgheight();y++) {
        unsigned char *dus = &fb[y];
        for (x=0;x<imgwidth();x++) {
            //cout << dus[x] << " ";
        }
        //cout << "\n";
    }
     
    return "dus";
}

int AA::getevent(int wait) {
    return aa_getevent(c, wait);
}

void AA::hidemouse() {
    aa_hidemouse(c);
}

void AA::showmouse() {
    aa_showmouse(c);
}

void AA::_getmouse() {
    int x, y, b;
    aa_getmouse(c, &x, &y, &b);
    mouse_x = x;
    mouse_y = y;
    mouse_b = b;
}

int AA::getmousex() {
    return mouse_x;
}

int AA::getmousey() {
    return mouse_y;
}

int AA::getmouseb() {
    return mouse_b;
}
    
MODULE = AA		PACKAGE = AA		

AA *
AA::new()

void
AA::DESTROY()

int
AA::easyinit()

int
AA::htmlinit()
    
void
AA::test()

int
AA::imgwidth()
    
int
AA::imgheight()

void
AA::putpixel(int x, int y, int color)

void
AA::showcursor()

void
AA::hidecursor()

int
AA::scrwidth()

int
AA::scrheight()

void
AA::fastrender(int x1, int y1, int x2, int y2)

int
AA::printf(int x, int y, enum aa_attribute opts, const char * fmt, ...)

void
AA::puts(int x, int y, enum aa_attribute opts, const char * str)
 
void
AA::flush()

char *
AA::image()

int
AA::autoinitmouse(int mode)

void
AA::uninitmouse()

int
AA::autoinitkbd(int mode)

void
AA::uninitkbd()

int
AA::getevent(int wait)

void
AA::hidemouse()

void
AA::showmouse()

void
AA::_getmouse()

int
AA::getmousex()

int
AA::getmousey()

int
AA::getmouseb()

int
AA::_parseoptions(SV *argv)

