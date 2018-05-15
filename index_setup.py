from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext

ext_modules = Extension("klt_index", 
	["pyindex.pyx"], 
	language="c", 
	# extra_compile_args=["-O3", "-Wall"],
    extra_link_args=["-L.", "./libindex.a", "-L./iconv/lib", "-lc"])

setup(ext_modules=[ext_modules],
      cmdclass = {'build_ext': build_ext})
