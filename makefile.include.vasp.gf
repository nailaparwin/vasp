# Precompiler options

CPP_OPTIONS= -DMPI -DHOST=\"NSC-GFORTRAN-B01\" -DNGZhalf\
             -DCACHE_SIZE=8000 -Davoidalloc \
             -Duse_bse_te \
             -Dtbdyn \
             -Duse_shmem \
             -DMPI_BLOCK=8000 -Duse_collective

CPP        = /usr/bin/gcc -E -P -C -w -std=f90 $*$(FUFFIX) >$*$(SUFFIX) $(CPP_OPTIONS)

FC         = /usr/bin/mpif90
FCL        = /usr/bin/mpif90

FREE       = -ffree-form -ffree-line-length-none
FFLAGS     =  -w
OFLAG      = -O1
OFLAG_IN   = $(OFLAG)
DEBUG      = -O0

LIBDR     = /usr/lib
LIBDIR     = /data/programs/lapack-3.5.0
LIBDIR2 = /data/programs/scalapack-2.0.2

BLAS       = -L$(LIBDR) -lrefblas
LAPACK     = -L$(LIBDIR) -ltmglib -llapack
#BLACS      = 
SCALAPACK  = -L$(LIBDIR2) -lscalapack $(BLACS)

FFTW       = /usr

OBJECTS    = fftmpiw.o fftmpi_map.o  fftw3d.o  fft3dlib.o \
             -L$(FFTW)/lib/x86_64-linux-gnu/libfftw3.a


INCS       =-I$(FFTW)/include



#MKL_PATH   = $(MKLROOT)/lib/intel64
#BLAS       =
#LAPACK     =
#BLACS      = -lmkl_blacs_intelmpi_lp64
#SCALAPACK  = $(MKL_PATH)/libmkl_scalapack_lp64.a $(BLACS)



#OBJECTS    = fftmpiw.o fftmpi_map.o fftw3d.o fft3dlib.o \
             $(MKLROOT)/interfaces/fftw3xf/libfftw3xf_intel.a
#INCS       =-I$(MKLROOT)/include/fftw
LLIBS      = $(SCALAPACK) $(LAPACK) $(BLAS)

OBJECTS_O1 += fft3dfurth.o fftw3d.o fftmpi.o fftmpiw.o chi.o
OBJECTS_O2 += fft3dlib.o

# For what used to be vasp.5.lib
CPP_LIB    = $(CPP)
FC_LIB     = $(FC)
CC_LIB     = gcc
CFLAGS_LIB = -O
FFLAGS_LIB = -O1
FREE_LIB   = $(FREE)

OBJECTS_LIB= linpack_double.o getshmem.o

LLIBS      += -lstdc++

#Normally no need to change this
SRCDIR     = ../../src
BINDIR     = ../../bin

########################################################################################
# GPU Stuff


CPP_GPU    = -DCUDA_GPU -DRPROMU_CPROJ_OVERLAP -DCUFFT_MIN=28
# -DUSE_PINNED_MEMORY 

#OBJECTS_GPU = fftmpiw.o fftmpi_map.o fft3dlib.o fftw3d_gpu.o fftmpiw_gpu.o \
              $(MKLROOT)/interfaces/fftw3xf/libfftw3xf_intel.a

#MAGMA_ROOT := /data/programs/magma-2.2.0/lib


OBJECTS_GPU= fftmpiw.o fftmpi_map.o fft3dlib.o fftw3d_gpu.o fftmpiw_gpu.o \
            -L$(FFTW)/lib/x86_64-linux-gnu/libfftw3.a


CC         = /usr/bin/gcc
CXX        = /usr/bin/g++
CFLAGS     = -fPIC -DADD_ -openmp -DMAGMA_WITH_MKL -DMAGMA_SETAFFINITY -DGPUSHMEM=300 -DHAVE_CUBLAS


CUDA_ROOT  := /usr/local/cuda
NVCC       := $(CUDA_ROOT)/bin/nvcc
CUDA_LIB   := -L$(CUDA_ROOT)/lib64 -lnvToolsExt -lcudart -lcuda -lcufft -lcublas

#GENCODE_ARCH    := -gencode=arch=compute_30,code=\"sm_30,compute_30\" -gencode=arch=compute_35,code=\"sm_35,compute_35\"

GENCODE_ARCH    := -gencode=arch=compute_30,code=\"sm_30,compute_30\" \
                   -gencode=arch=compute_35,code=\"sm_35,compute_35\" \
                   -gencode=arch=compute_60,code=\"sm_60,compute_60\"



MPI_INC    =/usr/lib/openmpi/include
#MPI_INC   =/usr/include
#MPI_INC = /opt/intel/impi/2017.2.191/include64

                                                                                                                                                       110,1         Bot
