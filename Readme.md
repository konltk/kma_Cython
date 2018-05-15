# kma_Cython
We will make kma(morphs ...) using cython.  

## index
### how to build
python3 index_setup.py build_ext -i

### how to use
```python
import klt_index
klt_index.init.(".") # location of hdic. can use relative path
klt_index.nouns("명사추출기")
