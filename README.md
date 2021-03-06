# Data Science Project Template

This script creates a cookie-cutter project template for data analysis. It automatically generates folders to organize project files including data I/O & manipulation, model training/fitting, and visualization.

There are no arguments fed to this script from the command line. All required inputs are asked for during run-time. You will be asked for:
* Name
* Project Title
* Desired Path
* Type of Project
  * NN Framework (if applicable).
* Desired License Type
* Initialize Git Repo
  * GitHub Username

![](assets/fig/example_run.PNG)

In all empty folders, a `.gitkeep` file is created upon initialization in order to ensure that all folders can be pushed to Git.

The general directory structure is:
```
├── LICENSE              <- Current supports automatically initializing MIT or BSD licenses
├── README.md            <- The top-level README for this project
├── .gitignore           <- .gitignore file if you wish to create a git repository. Only created if $GITCHECK == Y
├── assets               <- All auxiliary files/images necessary for running.
│   └── figs              <- Images for notebooks, etc.
|
├── data
│   ├── processing       <- Intermediate data that has been partly transformed, or still needs work.
│   ├── processed        <- The final data, ready for input into analysis scripts.
│   └── raw              <- The original data straight from its source
│
├── docs                 <- Documentation files for the project & utilities
│
├── notebooks            <- Jupyter notebooks - either tutorials for the tool, or interactive analysis.
│
├── references           <- Data dictionaries, manuals, citations, etc.
│
├── src                  <- Source code for use in this project.
│   │
│   ├── dataio           <- Scripts to download, generate, or read in data
│   │
│   ├── features         <- Scripts to turn raw data into features for modeling
│   │
│   ├── models           <- Scripts for training and fitting models.                 
│   │
│   └── visualization    <- Scripts to create exploratory and results oriented visualizations
```
### The two supported Project Types currently are: Data Analysis (DA) and Data Tools (DT)

##### DA:
Adds the following folders to the root of the project directory
```
├── reports            <- Non-interactive reports (PDF, HTML, etc.)
├── results            <- Results of analysis/figures
│   │
│   └──figures         <- Figures for use in creating reports, etc.
```
##### DT:
Adds the following folders/files to the root of the project directory
```
├── examples           <- Sample analysis, start-to-finish scripts on simple, clean data.
│
├── setup.py           <- Contains basic information about the package including
|                         required packages for this tool. Will be run during `pip install`
│
├── src                <- Already exists, extra folders are added within
│   │
│   ├── __init__.py    <- Main script for running Python code.
│   │
│   ├── utils          <- Additional utility functions necessary for the project.
|   |
│   ├── dataio           
│   │   ├── dataread.py
│   │   └── datadown.py   <- Data downloading/API scraping script.
│   │
│   ├── features        
│   │   └── preprocessing.py   <- Cleaning, transforming, and outputting data.
│   │
│   ├── models                           
│   │   ├── train.py      <- Model training
│   │   └── predict.py    <- Model fitting
│   │
│   └── visualization
        └── visualize.py    <- Creating graphics based on analysis of your model
```

#### NN:
```
├── setup.py              <- Adds NN framework to dependencies.
|
├── examples           <- Sample analysis, start-to-finish scripts on simple, clean data.
|
├── reports            <- Non-interactive reports (PDF, HTML, etc.)
│   │
│   └──figures         <- Figures for use with files in the reports directory
|
├── src
│   ├── dataio           
│   │   ├── dataread.py
│   │   └── datadown.py   <- Data downloading/API scraping script.
│   │
│   ├── features        
│   │   └── preprocessing.py   <- Cleaning, transforming, and outputting data.
|   |
│   ├── utils             <- Additional utility functions necessary for the project.
│   │   ├── optimizers.py    <- Functions for training steps with various optimizers.
│   │   └── utils.py         <- All other necessary utilities for layers & training.
|   |
│   ├── models                           
│   │   ├── model.py      <- Script to create computational graph.
│   │   ├── layers.py     <- Layer definitions & block setup
│   │   └── nn.py         <- Script to begin training & validation of NN
│   │
│   └── visualization
        └── visualize.py    <- Creating graphics based on analysis of your model
```


Written by Tyler Roberts on November 18th 2017
