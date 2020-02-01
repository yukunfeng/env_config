" the best explanation about tab in vim I have seen is http://tedlogan.com/techblog3.html
let my_space = 2
set expandtab        " in Insert mode: Use the appropriate number of spaces to insert a <Tab>.
let &tabstop = my_space       " number of spaces that a <Tab> in the file counts for
let &shiftwidth = my_space
let &softtabstop = my_space
