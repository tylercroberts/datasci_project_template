#! C:\Program Files\Git\bin\bash


# Tyler Roberts, Nov 21st 2017
#
# This script intializes a project directory structure (and potentially git repo) for a data science project
# This script takes no command line arguments. All required details are asked for in the terminal during run-time.
#
# Usage: bash cookiecutter.sh


# ---------------------- Initialize Setup Variables ------------------------ #
echo "What is your name?"
read USER # Will be used for generating default files

echo "Hello, "$USER". What is your project's name? (no spaces please!)"
read PROJ # Takes input, sets the project directory name

echo "Please enter the path: (no '/' at the end). 'pwd' for present directory"
read PROJPATH # Sets the path to the parent folder of your project
if [ $PROJPATH != "pwd" ] # Error handling for mistyped/non-existent directories
then
  # -------------------- Check that the path exists ------------------------ #à

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

echo "Is this project for Data Analysis (DA), a Data Tool (DT) or Neural Network (NN)?
(For a list of all alternative project types, type HELP)"
read TYPE  # Determines the type of project you are creating
while [ $TYPE = "HELP" ]
do
  echo "Currently supported project types are:
  DA -- Data Analysis. Generally consist of interactive projects exploring a dataset,
  DT -- Data Tool. Packages or libraries for a solution to data problems.
  NN -- Neural Net. [In Progress] Specialized directory structure and building blocks for designing NN architectures/models."
  read TYPE
done
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
      NN -- Neural Network. [In Progress] Specialized directory structure and building blocks for designing NN architectures/models."
    done
done
echo "What type of license would you like to use?
(For a list of supported licenses, type HELP)."
read LICTYPE  # Reads in License Type. Currently BSD and MIT Supported.
while [ $LICTYPE = "HELP" ]
do
  echo "Available license types are:
  BSD -- Requires all redistributed code to also be licensed under BSD.,
  MIT -- Requires all redistributed code to preserver copyright & license notices, and have same license.,
  AGPL3 -- Requires complete source code and same license for redistribution.,
  GPL -- Requires complete source code and same license. Contributors provide express grant of patent rights.,
  LGPL -- Less strict form of GPL for redistribution.,
  MOZILLA -- Weak copyleft. Limitations for trademark use. Must disclose source.,
  APACHE -- Preservation of copyright and lincense notices, changes must be stated.,
  UNLICENSE -- No conditions whatsoever, work is public domain.

  If you do not want a license to be initialized for you, type anything else."
  read LICTYPE
done
YEAR=`date +%Y`  # Sets a variable for the current year.
# -------------------------------------------------------------------------- #
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

# ---------------------- Git details --------------------------- #
# Determines if the user would like to turn this project into a Git repository
echo "Would you like to initialize a local Git repo? (Y/N)"
read GITCHECK
if [ $GITCHECK = "Y" ]
then
# -------------------- $GITNAME used for documentation ------------------- #
  git init
  # Sets up the .gitignore file with some standard extensions you likely dont want
  touch .gitignore
  echo ".DS_Store
  .gitignore" >> .gitignore
  echo "What is your GitHub username?
  If N/A, enter NONE"
  read GITNAME
  echo "Do you already have a remote repository on GitHub for this project?"
  read HUBCHECK
  if [ $HUBCHECK = "Y" ]
  then
    git add .
    git commit -m "Initial Commit"
    echo "
    What is the URL?"
    read GITURL
    URLCHECK=`curl -s --head $GITURL | head -n 1 | grep "HTTP/1.[01] [23].."`
    if [ $URLCHECK -n ]
    then
      git remote add origin $GITURL
      git push -u origin master
    else
      echo "Uh-oh. Something went wrong with the URL you entered. Remote repository not initialized."
    fi
  fi
  if [ $GITNAME = "NONE" ] # sets $GITNAME back to null if NONE
  then
    unset GITNAME
  fi
fi

# -------------- Set up License based on previously set type ------------- #
if [ $LICTYPE = "BSD" ]
then
  cat $HOMEPATH/assets/licenses/bsd.txt >> LICENSE
elif [ $LICTYPE = "MIT" ]
then
  cat $HOMEPATH/assets/licenses/mit.txt >> LICENSE
elif [ $LICTYPE = "AGPL3" ]
then
  cat $HOMEPATH/assets/licenses/agpl3.txt >> LICENSE
elif [ $LICTYPE = "GPL" ]
then
  cat $HOMEPATH/assets/licenses/gpl.txt >> LICENSE
elif [ $LICTYPE = "LGPL" ]
then
  cat $HOMEPATH/assets/licenses/lgpl.txt >> LICENSE
elif [ $LICTYPE == "MOZILLA" ]
then
  cat $HOMEPATH/assets/licenses/mozilla.txt >> LICENSE
elif [ $LICTYPE == "APACHE" ]
then
  cat $HOMEPATH/assets/licenses/apache.txt >> LICENSE
elif [ $LICTYPE == "UNLICENSE" ]
then
  cat $HOMEPATH/assets/licenses/unlicense.txt >> LICENSE
else
  echo "$LICTYPE is not supported, would you like to try again?"
  read TRYAGAIN
  while [ $TRYAGAIN = "Y"] # Need to set up a check for $LICTYPE not in a list of values.
  do
  contains() {
    [[ $1 =~ (^|[[:space:]])$2($|[[:space:]]) ]] && exit(0) || exit(1)
  }
     read LICTYPE
     if [ contains "BSD MIT AGPL3 GPL LGPL MOZILLA APACHE UNLICENSE" $LICTYPE ]
     then
       if [ $LICTYPE = "BSD" ]
       then
        cat $HOMEPATH/licenses/bsd.txt >> LICENSE
       elif [ $LICTYPE = "MIT" ]
       then
        cat $HOMEPATH/licenses/mit.txt >> LICENSE
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
         cat $HOMEPATH/licenses/apache.txt >> LICENSE
       elif [ $LICTYPE == "UNLICENSE" ]
       then
         cat $HOMEPATH/licenses/unlicense.txt >> LICENSE # Think I still need a catch after this, just in case.
      fi
  done
  echo "License not initialized -- License Type: '$LICTYPE' is not currently supported"
fi

# --------------------- Set up Type-based Files/Folders ------------------- #
if [ $TYPE = "DA" ]
then
  mkdir reports
  mkdir results
    mkdir results/figures
      touch results/figures/.gitkeep
  touch src/dataio/.gitkeep
  touch src/models/.gitkeep
  touch src/features/.gitkeep
  touch src/features/.gitkeep
  echo "Done setting up data analysis files"

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
  echo "Done setting up data tool files"

  # Create template for setup.py file
  if [ $GITNAME -n ]
  then
    cat $HOMEPATH/assets/setup_template_git.txt >> setup.py

    echo "Be sure to update the setup file with your dependencies"
  else
    cat $HOMEPATH/assets/setup_template.txt >> setup.py
    echo "Be sure to update the setup file with your dependencies and URL"
  fi
# --------------- Setup paths for preprocessing.py scripts --------------- #
  echo "input_path = $ABSPATH/data/raw" >> src/features/preprocessing.py
  echo "output_path = $ABSPATH/data/processed" >> src/features/preprocessing.py

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
    read NNFRAME
  done

  while [ ! $NNFRAME = "TF" ] && [ ! $NNFRAME = "TORCH" ]
  do
    echo "$NNFRAME is not a supported framework. Please enter a supported framework or type HELP for assistance"
  done
  mkdir reports
    mkdir reports/figures
      touch reports/figures/.gitkeep
  mkdir examples
      mkdir examples/figures
        touch examples/figures/.gitkeep
      touch examples/.gitkeep
  mkdir src/utils

  touch setup.py
  touch src/__init__.py
  touch src/dataio/dataread.py
  touch src/dataio/datadown.py
  touch src/features/preprocessing.py
  touch src/models/layers.py
  touch src/models/model.py
  touch src/models/nn.py
  touch src/utils/optimizers.py
  touch src/utils/utils.py
  touch src/visualization/visualize.py
  echo "Done setting up neural net files."

  for file in src/dataio/*.py
  do
    echo "import numpy as np
    import os" >> $file
  done



  if [ $GITNAME -n ]
  then
    if [ $NNFRAME = "TF" ]
    then
      # ----------- Automatically add some imports to .py files  ----------- #

      # -- Seems to be a better way to iterate over all these files
      #for f in */*.py **/*/*.py ; do
        ...
      #done;
      for file in src/models/*.py
      do
        echo "import tensorflow as tf" >> $file
      done
      for file in src/visualization/*.py
      do
        echo "import matplotlib.pyplot as plt
import tensorflow as tf" >> $file
      done
      for file in src/utils/*.py
      do
        echo "import tensorflow as tf" >> $file
      done
      for file in src/features/*.py
      do
        echo "import tensorflow as tf" >> $file
      done
      cat $HOMEPATH/assets/setup_template_git.txt >> setup.py
    elif [ $NNFRAME = "TORCH" ]
    then
    # ----------- Automatically add some imports to .py files  ----------- #

      for file in src/models/*.py
      do
        echo "import torch" >> $file
      done
      for file in src/visualization/*.py
      do
        echo "import matplotlib.pyplot as plt
import torch" >> $file
      done
      for file in src/utils/*.py
      do
        echo "import torch" >> $file
      done
      for file in src/features/*.py
      do
        echo "import torch" >> $file
      done

      cat $HOMEPATH/assets/setup_template_git.txt >> setup.py
    fi
  else
    if [ $NNFRAME = "TF" ]
    then
    # ----------- Automatically add some imports to .py files  ----------- #

      for file in src/models/*.py
      do
        echo "import tensorflow as tf" >> $file
      done
      for file in src/visualization/*.py
      do
        echo "import matplotlib.pyplot as plt
import tensorflow as tf" >> $file
      done
      for file in src/utils/*.py
      do
        echo "import tensorflow as tf" >> $file
      done
      for file in src/features/*.py
      do
        echo "import tensorflow as tf" >> $file
      done

      cat $HOMEPATH/assets/setup_template.txt >> setup.py

    elif [ $NNFRAME = "TORCH" ]
    then
      # ----------- Automatically add some imports to .py files  ----------- #
      for file in src/models/*.py
      do
        echo "import torch" >> $file
      done
      for file in src/visualization/*.py
      do
        echo "import matplotlib.pyplot as plt
        import torch" >> $file
      done
      for file in src/utils/*.py
      do
        echo "import torch" >> $file
      done
      for file in src/features/*.py
      do
        echo "import torch" >> $file
      done

      cat $HOMEPATH/assets/setup_template.txt >> setup.py

    fi
  fi
else
  echo "Something has gone wrong, you shouldn't be able to get here! Please re-run the script."
fi

# ------------ Exit Block. Gives time to read console if errors ------------ #

echo "Please provide any input to exit."
read LEAVE
