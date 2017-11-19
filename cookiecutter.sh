#! C:\Program Files\Git\bin\bash

# ---------------------- Initialize Setup Variables ------------------------ #
echo "What is your name?"
read USER # Will be used for generating default files
echo "Hello, "$USER". What is your project's name? (no spaces please!)"
read PROJ # Takes input, sets the project directory name
echo "Please enter the path: (no '/' at the end). 'pwd' for present directory"
read PROJPATH # Sets the path to the parent folder of your project
if [ $PROJPATH != "pwd" ] # Error handling for mistyped/non-existent directories
then
  while [ ! -d $PROJPATH ]
  do
    echo "Error, no such directory, try again"
    read PROJPATH
    if [ $PROJPATH = "pwd" ]  #If the user decides they want the current wd, break.
    then
      break
    fi
  done
fi
echo "Is this project for Data Analysis (DA) or a Data Tool (DT)? (Packages coming soon)"
read TYPE  # Determines the type of project you are creating
while [ ! "$TYPE" = "DA" ] && [ ! $TYPE = "DT" ]
do
  echo "$TYPE is not a currently supported project type"
  read TYPE
done
<<<<<<< HEAD
<<<<<<< HEAD
while [ ! "$TYPE" = "DA" ] && [ ! $TYPE = "DT" ]  && [ ! $TYPE = "NN" ]
do
  echo "$TYPE is not a currently supported project type.
  Please open an issue at https://github.ubc.ca/tylercroberts/datasci_project_template.
  Type HELP for the currently supported projects."
  read TYPE
  while [ $TYPE = "HELP" ]
    do
      echo "Currently supported project types are:
      DA -- Data Analysis. Generally consist of interactive projects exploring a dataset,
      DT -- Data Tool. Packages or libraries for a solution to data problems.
      NN -- Coming soon. Specialized directory structure for building NN architectures/models."
      read TYPE
    done
done
echo "What type of license would you like to use?
(For a list of supported licenses, type HELP)."
=======
echo "What type of license would you like to use? \n (For a list of supported licenses, type HELP)."
>>>>>>> parent of 8f393d8... Error handling, help responses
=======
echo "What type of license would you like to use? \n (For a list of supported licenses, type HELP)."
>>>>>>> parent of 8f393d8... Error handling, help responses
read LICTYPE  # Reads in License Type. Currently BSD and MIT Supported.
YEAR=`date +%Y`  # Sets a variable for the current year.


# ------------------------------ Begin Setup ------------------------------- #
HOMEPATH=`pwd`
# Make project root
if [ $PROJPATH = "pwd" ]
then
  mkdir $PROJ
  cd $PROJ # Changes directory into the project directory
else
  mkdir $PROJPATH/$PROJ
  cd $PROJPATH/$PROJ
fi
ABSPATH=`pwd` # Sets a variable to the absolute path of our project

# Makes all the files/folders that are invarient wrt. project type
# `.gitkeep` files are to store the entire file structure in Git.
touch LICENSE
touch README.md
mkdir assets
  mkdir assets/figs
mkdir data
  mkdir data/raw
    touch data/raw/.gitkeep
  mkdir data/processed
    touch data/processed/.gitkeep
  mkdir data/processing
    touch data/processing/.gitkeep
mkdir docs
  touch docs/.gitkeep
mkdir notebooks
  touch notebooks/.gitkeep

mkdir references
  touch references/.gitkeep
mkdir src
  mkdir src/dataio
  mkdir src/models
  mkdir src/features
  mkdir src/visualization
echo "# $PROJ Written by: $USER" >> README.md # Initialize README.md

# -------------- Set up License based on previously set type ------------- #
while [ $LICTYPE = "HELP" ]
do
  echo "Available license types are:
  BSD,
  MIT,
  AGPL3,
  GPL,
  LGPL,
  MOZILLA,
  APACHE,
  UNLICENSE"
  read LICTYPE
done
if [ $LICTYPE = "BSD" ]
then
  echo "Copyright (c) $YEAR, $USER
  All rights reserved.

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
      * Redistributions of source code must retain the above copyright
        notice, this list of conditions and the following disclaimer.
      * Redistributions in binary form must reproduce the above copyright
        notice, this list of conditions and the following disclaimer in the
        documentation and/or other materials provided with the distribution.
      * Neither the name of the <organization> nor the
        names of its contributors may be used to endorse or promote products
        derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS 'AS IS' AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
  DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE." >> LICENSE

elif [ $LICTYPE = "MIT" ]
then
  echo "Copyright (c) $YEAR $USER

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in all
  copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE." >> LICENSE

elif [ $LICTYPE = "AGPL3" ]
then
  cat $HOMEPATH/licenses/agpl3.txt >> LICENSE
elif [ $LICTYPE = "GPL" ]
then
  cat $HOMEPATH/licenses/gpl.txt >> LICENSE
elif [ $LICTYPE = "LGPL" ]
then
  cat $HOMEPATH/licenses/lgpl.txt >> LICENSE
elif [ $LICTYPE == "MOZILLA" ]
then
  cat $HOMEPATH/licenses/mozilla.txt >> LICENSE
elif [ $LICTYPE == "APACHE" ]
then
  cat $HOMEPATH/licenses/unlicense.txt >> LICENSE
elif [ $LICTYPE == "UNLICENSE" ]
then
  cat $HOMEPATH/licenses/unlicense.txt >> LICENSE
else
  echo "License not initialized -- License Type: '$LICTYPE' is not currently supported"
fi

# --------------------- Set up Type-based Files/Folders ------------------- #
if [ $TYPE = "DA" ]
then
  mkdir reports
    mkdir reports/figures
      touch reports/figures/.gitkeep
  touch src/dataio/.gitkeep
  touch src/models/.gitkeep
  touch src/features/.gitkeep
  touch src/features/.gitkeep

elif [ $TYPE = "DT" ]
then
  mkdir examples
    touch examples/.gitkeep
  touch setup.py
  touch src/__init__.py
  mkdir src/utils
    touch src/utils/.gitkeep
  touch src/dataio/dataread.py
  touch src/dataio/datadown.py
  touch src/features/preprocessing.py
  touch src/models/predict.py
  touch src/models/train.py
  touch src/visualization/visualize.py
<<<<<<< HEAD
  echo "import numpy as np
  import matplotlib.pyplot as plt" >> src/visualization/visualize.py
=======
>>>>>>> parent of 8f393d8... Error handling, help responses

# Create template for setup.py file
echo "import os
from setuptools import setup, find_packages


def read(fname):
    try:
        return open(os.path.join(os.path.dirname(__file__), fname)).read()
    except:
        return 'Please see: <insert_url_here>'

setup(
    name='$PROJ',
    version='0.0.1',
    author='$USER',
    author_email='',
    description='',
    long_description=read('README.md'),
    license='',
    keywords='',
    # download_url='',
    packages=find_packages(),
    install_requires=['scipy','numpy'],
    classifiers=[],
    include_package_data=True
)" >> setup.py

<<<<<<< HEAD
<<<<<<< HEAD
    setup(
        name='$PROJ',
        version='0.0.1',
        author='$USER',
        author_email='',
        description='',
        long_description=read('README.md'),
        license='',
        keywords='',
        # download_url='',
        packages=find_packages(),
        install_requires=['scipy','numpy', 'matplotlib'],
        classifiers=[],
        include_package_data=True
    )" >> setup.py
    echo "Be sure to update the setup file with your dependencies"
  else
    echo "import os
    from setuptools import setup, find_packages


    def read(fname):
        try:
            return open(os.path.join(os.path.dirname(__file__), fname)).read()
        except:
            return 'Please see: <Insert URL Here>'

    setup(
        name='$PROJ',
        version='0.0.1',
        author='$USER',
        author_email='',
        description='',
        long_description=read('README.md'),
        license='',
        keywords='',
        # download_url='',
        packages=find_packages(),
        install_requires=['scipy','numpy', 'matplotlib'],
        classifiers=[],
        include_package_data=True
    )" >> setup.py
    echo "Be sure to update the setup file with your dependencies and URL"
  fi
=======
>>>>>>> parent of 8f393d8... Error handling, help responses
=======
>>>>>>> parent of 8f393d8... Error handling, help responses
# --------------- Setup paths for preprocessing.py scripts --------------- #
  echo "input_path = $ABSPATH/data/raw" >> src/features/preprocessing.py
  echo "output_path = $ABSPATH/data/processed" >> src/features/preprocessing.py

<<<<<<< HEAD
<<<<<<< HEAD
elif [ $TYPE = "NN" ]
then
  echo "What back-end are you using for your NN?
  Type HELP for supported types"
  read NNFRAME

  while [ $NNFRAME = "HELP" ]
  do
    echo "Currently supported frameworks are:
    TF -- TensorFlow
    TORCH -- PyTorch"
    read $NNFRAME
  done

  while [ ! $NNFRAME = "TF" ] && [ ! $NNFRAME = "TORCH" ]
  do
    echo "$NNFRAME is not a supported framework. Please enter a supported framework or type HELP for assistance"
    read NNFRAME
    while [ $NNFRAME = "HELP"]
      echo "Currently supported frameworks are:
      TF -- TensorFlow
      TORCH -- PyTorch"
      read NNFRAME
    do
  done

  touch setup.py
  mkdir src/utils
  touch src/visualization/visualize.py
  echo "import tensorflow as tf
  import matplotlib.pyplot as plt" >> src/visualization/visualize.py
  touch src/models/layers.py
  if [ $GITNAME -n ]
  then
    if [ $NNFRAME = "TF" ]
    then
      touch src/models/model.py
      echo "import tensorflow as tf" >> src/models/model.py
      touch src/models/nn.py
      echo "import tensorflow as tf" >> src/models/nn.py
      touch src/utils/optimizers.py
      echo "import tensorflow as tf" >> src/utils/optimizers.py
      touch src/utils/utils.py
      echo "import tensorflow as tf" >> src/utils/utils.py

      echo "import os
      from setuptools import setup, find_packages


      def read(fname):
          try:
              return open(os.path.join(os.path.dirname(__file__), fname)).read()
          except:
              return 'Please see: https://github.com/$GITNAME/$PROJ'

      setup(
          name='$PROJ',
          version='0.0.1',
          author='$USER',
          author_email='',
          description='',
          long_description=read('README.md'),
          license='',
          keywords='',
          # download_url='',
          packages=find_packages(),
          install_requires=['scipy','numpy', 'tensorflow', 'matplotlib'],
          classifiers=[],
          include_package_data=True
      )" >> setup.py
    elif [ $NNFRAME = "TORCH" ]
    then
      touch src/models/model.py
      echo "import torch" >> src/models/model.py
      touch src/models/nn.py
      echo "import torch" >> src/models/nn.py
      touch src/utils/optimizers.py
      echo "import torch" >> src/utils/optimizers.py
      touch src/utils/utils.py
      echo "import torch" >> src/utils/utils.py

      echo "import os
      from setuptools import setup, find_packages


      def read(fname):
          try:
              return open(os.path.join(os.path.dirname(__file__), fname)).read()
          except:
              return 'Please see: https://github.com/$GITNAME/$PROJ'

      setup(
          name='$PROJ',
          version='0.0.1',
          author='$USER',
          author_email='',
          description='',
          long_description=read('README.md'),
          license='',
          keywords='',
          # download_url='',
          packages=find_packages(),
          install_requires=['scipy','numpy', 'pytorch', 'matplotlib'],
          classifiers=[],
          include_package_data=True
      )" >> setup.py
    fi
  else
    if [ $NNFRAME = "TF" ]
    then
      touch src/models/model.py
      echo "import tensorflow as tf" >> src/models/model.py
      touch src/models/nn.py
      echo "import tensorflow as tf" >> src/models/nn.py
      touch src/utils/optimizers.py
      echo "import tensorflow as tf" >> src/utils/optimizers.py
      touch src/utils/utils.py
      echo "import tensorflow as tf" >> src/utils/utils.py

      echo "import os
      from setuptools import setup, find_packages


      def read(fname):
          try:
              return open(os.path.join(os.path.dirname(__file__), fname)).read()
          except:
              return 'Please see: <insert_url_here>'

      setup(
          name='$PROJ',
          version='0.0.1',
          author='$USER',
          author_email='',
          description='',
          long_description=read('README.md'),
          license='',
          keywords='',
          # download_url='',
          packages=find_packages(),
          install_requires=['scipy','numpy', 'tensorflow', 'matplotlib'],
          classifiers=[],
          include_package_data=True
      )" >> setup.py
    elif [ $NNFRAME = "TORCH" ]
    then
      touch src/models/model.py
      echo "import torch" >> src/models/model.py
      touch src/models/nn.py
      echo "import torch" >> src/models/nn.py
      touch src/utils/optimizers.py
      echo "import torch" >> src/utils/optimizers.py
      touch src/utils/utils.py
      echo "import torch" >> src/utils/utils.py

      echo "import os
      from setuptools import setup, find_packages


      def read(fname):
          try:
              return open(os.path.join(os.path.dirname(__file__), fname)).read()
          except:
              return 'Please see: <insert_url_here>'

      setup(
          name='$PROJ',
          version='0.0.1',
          author='$USER',
          author_email='',
          description='',
          long_description=read('README.md'),
          license='',
          keywords='',
          # download_url='',
          packages=find_packages(),
          install_requires=['scipy','numpy', 'pytorch', 'matplotlib'],
          classifiers=[],
          include_package_data=True
      )" >> setup.py
    fi
  fi
=======
>>>>>>> parent of 8f393d8... Error handling, help responses
=======
>>>>>>> parent of 8f393d8... Error handling, help responses
else
  echo "Type: "$TYPE" is not supported yet, please open an issue at https://github.ubc.ca/ubc-mds-2017/DSCI522_lab1_script_tcroberts"
fi

# Determines if the user would like to turn this project into a Git repository
echo "Would you like to initialize a local Git repo? (Y/N)"
read GITCHECK
if [ $GITCHECK = "Y" ]
then
 git init
 # Sets up the .gitignore file with some standard extensions you likely dont want
 touch .gitignore
 echo ".DS_Store" >> .gitignore
 echo ".ipynb_checkpoints" >> .gitignore
fi
