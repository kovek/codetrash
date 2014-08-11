function! Codebin() range

if !has('python')
	echo "Error: Required vim compuled with +python"
	finish
endif

python << EOF
import vim, urllib2

buf = vim.current.buffer
(lnum1, col1) = buf.mark('<')
(lnum2, col2) = buf.mark('>')
lines = vim.eval('getline({}, {})'.format(lnum1, lnum2))
lines[0] = lines[0][col1:]
lines[-1] = lines[-1][:col2]
selected_text = "\n".join(lines)

import subprocess
def local(command):
    FNULL = open(os.devnull, 'w')
    proc = subprocess.Popen(
        [command],
        stdout=subprocess.PIPE,
        stderr=FNULL,
        shell=True)
    (out, err) = proc.communicate()
    return out

import datetime
import os
filepath = vim.eval("expand('%:p:h')")
full_filepath = vim.eval("expand('%:p')")
os.chdir(filepath)

output = "On " + str(datetime.datetime.now())+":\n"
project_name = local('basename `git rev-parse --show-toplevel`')
if project_name:
    output+= "In project " + project_name + '\n'
    output+= "On branch " + local('git branch | grep \*') + '\n'
    output+= "In commit " + local('git rev-parse HEAD') + '\n'
    if "HEAD detached at" in local('git status'):
        output+= "Which was a detached HEAD," + '\n'
    else:
        output+= "Which was HEAD," + '\n'
output+= "In file " + full_filepath + '\n'
output+= "Starting on line " + str(lnum1) + '\n'
output+= "\n------------------------------------------------------------------------\n"
output+= selected_text
output+= "\n------------------------------------------------------------------------\n"
output+= "\n"


local('echo "'+output+'" >> ~/bin/code.bin')

EOF

endfunction


:vmap ccc :call Codebin()<cr>

