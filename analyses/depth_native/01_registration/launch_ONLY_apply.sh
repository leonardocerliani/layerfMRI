#!/bin/bash

# This script runs do_registration.py for all subjects in parallel in the
# conda environment layerfMRI
# Check python do_registration.py -h for information about the arguments

# NB: pandoc should be installed on the system by sudo

# initialize the proper environment to run the python script
source activate layerfMRI
echo
echo `conda info | grep "active environment"`
echo
echo

# subjects 1 4 7 have missing data
subject_numba_file=/data00/layerfMRI/list_subjects

subjects=$(<${subject_numba_file})

# # estimate native <-- full <-- MNI transformation
# printf "%s\n" "${subjects[@]}" | xargs -n 1 -P 12 -I{} python do_estimate_native_full_MNI.py --sub={}

# apply transformation to depth and atlas
printf "%s\n" "${subjects[@]}" | xargs -n 1 -P 12 -I{} python do_apply_native_full_MNI.py --sub={}

echo
echo


# when all is done, cleanup the /tmp, since ANTs leaves a lot of stuff there
rm -rf `find /tmp -user cerliani`
