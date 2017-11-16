# Data Science Project Template

This script creates a cookie-cutter project template for data analysis. It automatically generates folders to organize project files including data I/O & manipulation, model training/fitting, and visualization.

There are no arguments fed to this script from the command line. All required inputs are asked for during run-time. You will be asked for:
* Name
* Project Title
* Desired Path
* Type of Project
* Desired License Type

In all empty folders, a `.gitkeep` file is created upon initialization in order to ensure that all folders can be pushed to Git.

The general directory structure is:
```
├── LICENSE              <- Current supports automatically initializing MIT or BSD licenses
├── README.md            <- The top-level README for this project
├── .gitignore           <- .gitignore file if you wish to create a git repository. Only created if $GITCHECK == Y
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
│   │
│   └──figures         <- Figures for use with files in the reports directory
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

Written by Tyler Roberts on November 16th 2017
