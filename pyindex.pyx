cdef extern from "index_header/ham-ndx.h":
    ctypedef struct HAM_RUNMODE:
        pass
    int open_HAM_index_dicpath(HAM_RUNMODE *mode, char *options, char *inifile,	char *dpath, char *dic_usr, char *dic_cnn, char *dic_stop)
    int get_stems(unsigned char *sent, unsigned char *keys[], HAM_RUNMODE *mode)

cdef extern from "index_header/cnoun-api.h":
    int genNounCompKSC(unsigned char *word, unsigned char *nlist, int *n2, unsigned char noun_delimiter, int *cnndic)

cdef HAM_RUNMODE mode
import os
def init(path):
    global mode
    path = os.path.abspath(path) + "/"
    kltpath = path+"hdic/KLT2000.ini"
    tmppath = path+"hdic/"
    kltpath=kltpath.encode("cp949")
    tmppath=tmppath.encode("cp949")

    rc = open_HAM_index_dicpath(&mode, '1c', kltpath, tmppath, "ham-usr.dic", "ham-cnn.dic", "stopword.dic");

    return rc


def nouns(txt):
    global mode
    txt = txt.encode("cp949")
    
    cdef unsigned char *term[100];
    n = get_stems(txt, term, &mode)
    
    l = []
    for i in range(n):
        l.append(term[i].decode("cp949"))
    return l

def noun_comp(txt):
    txt = txt.encode("cp949")
    cdef int n2 = 0
    cdef int cnndic = 0
    cdef unsigned char result[1024]

    n = genNounCompKSC(txt, &result[0], &n2, " ", &cnndic)
    if n == 0:
        return [txt.decode("cp949")]
    return result.decode("cp949").split(" ")