# Getting StaRted with

<img src="Images/R_logo.png" width="200"/>

R is a programming language designed for statistical analysis
and data visualization. 
Like Python, R can also be used as a general-purpose programming language, complete with a menu of data types, 
tools for conditional logic, repetition, functions and methods. 

## Data Types

As with Python, there exist several *classes* of data in ```R```. 

<img src="Images/Rvariablesdata.jpg" width="500"/>

Now let's consider how to define and manipulate these data types in R. 

### Strings

```character``` strings are variables that contain alphanumeric characters, just like type ```str``` in Python. 

```R
my_string <- "abcde"
class(my_string)
"character"
```
Notice that the assignment operator in R is an arrow
made up of the less than sign followed by a dash or minus sign. 
You can also use the equal sign as you would in Python
but the convention in R is only to use the equal sign
for passing arguments to functions. 


### Integer variables

An ```integer``` in R corresponds to type ```str``` in Python. 

```R
some_numbers.integers <- 1:10
class(some_numbers.integers)
[1] "integer"
```
Most characters can be used in variable names
but they must start with a character and not contain operators.
A popular convention is to use only characters separated by
underscores (```_```), and perhaps some integers. 


### Numeric variables

Numeric is a broader class of, well, numeric variables, 
similar to type ```float``` in Python.
```R
value_of_pi <- pi
class(value_of_pi)
[1] "numeric"
```
Note that ```pi``` is a built-in variable in R
but would otherwise be imported into Python
with the ```math``` module.
R, by default, has a set of utilities commonly used for 
statistical analysis and data visualization
but we will see that many R packages are available
to extend R to cover a wide variety of applications. 


### Logical variables

Logical values denote true or false conditions, 
much like type ```bool``` in Python.
```R
true_statement1 <- value_of_pi == pi
class(true_statement1)
[1] "logical"
false_statement1 <- value_of_pi == pi + 2
class(false_statement1)
[1] "logical"
```


## Running Blocks of Code

To interact with R, we will use RStudio, 
which is a graphical user interface (GUI) for R, 
much like Spyder is for Python. 

In RStudio, pressing ctrl + Enter will run the block of code that is selected. It can also be done by clicking the button above marked "Run" with the green arrow. 
To run the blocks of code, select them with your mouse (or using arrows while holding the shift key) before pressing Run (or ctrl + Enter). 
As you gain skill, you will find that you use your mouse less and less and prefer the shift + arrows and ctrl + enter. 

Let's apply the skills above to analyze some data in RStudio. 


## Listing 1.1 - A Sample R session

Before we read in some data from a file,
define some vectors of variables using the c() function.
This function concatenates variables into a vector.

```R
age <- c(1, 3, 5, 2, 11, 9, 3, 9, 12, 3)
weight <- c(4.4, 5.3, 7.2, 5.2, 8.5, 7.3, 6, 10.4,
    10.2, 6.1)
```
You can end a command on the next line
as long as the line terminates with an operator
that indicates an unfinished command.


Now calculate some statistics with these variables.

```R
# Calculate the mean:
mean(weight)
[1] 7.06

# Calculate the standard deviation:
sd(weight)
[1] 2.077498

# Calculate the correlation between two variables:
cor(age, weight)
[1] 0.9075655
```


R comes standard with several tools for
statistical analysis as well as graphics.

```R
plot(age, weight)
```

The default version is a very simple
black-and-white scattergraph but we will learn how to
use R for richer data visualization.


## Listing 1.2 - Managing the R Workspace.

Change the next line to assign ```wd_path``` a valid directory
on your computer.

```R
wd_path <- '~/Teaching/QMB6358_Fall_2020/GitRepos/QMB6358F20/demo_05_R_intro'
setwd(wd_path)
```

We can use the ```runif()``` function to generate
uniformly distributed random variables.
```R
x <- runif(20)
```

The ```summary()``` command is the basic function
for investigating new data.

```R
summary(x)
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
 0.1098  0.3154  0.5103  0.5565  0.7920  0.9605
```

The ```hist()``` function plots a histogram.
```R
hist(x)
```

You can save the history of your commands in a session with
```savehistory()```
and also save the state of your session,
including all the values of variables in memory, with
```save.image()```.

Although useful, this is not recommended
because the state of your workspace can always
be recreated with your data and your script.
You should develop the habit of writing code in a script
so that it preserves your analysis.



## Listing 1.3 - Working with a new package

So far, we have seen several built-in functions.
The full functionality of R is achieved by
installing packages of functions developed
by other users in the R community.

The package vcd is used to Visualizing Categorical Data.
Install packages with the ```install.packages()``` function:

```R
install.packages("vcd")
```

The package needs only be installed once,
unless you want to update the version.
Once installed, you need to attach the package
with the ```library()``` function.

```R
library(vcd)
```

Now, all the functions in the vcd library are available
to use in your workspace.


You can obtain a description of the functions available
in a package.
```
help(package = "vcd")
```
Many packages contain sample datasets to use as examples
of the functionality.
In package ```vcd```, one dataset is a study of treatments for Arthritis. 

```
help(Arthritis)
```


Find the examples corresponding to the datasets with ```example()```

```R
example(Arthritis)
Arthrt> data("Arthritis")

Arthrt> art <- xtabs(~ Treatment + Improved, data = Arthritis, subset = Sex == "Female")

Arthrt> art
         Improved
Treatment None Some Marked
  Placebo   19    7      6
  Treated    6    5     16

Arthrt> mosaic(art, gp = shading_Friendly)
```

You can copy the text for a command that uses this dataset

```R
art <- xtabs(~ Treatment + Improved, data = Arthritis, subset = Sex == "Female")
```

Hit ```<Return>``` to cycle through the plots.



## Getting Help

We saw the help function used above.
It can be used in many ways.
You can find many resources to get you started with help.

```R
help.start()
```

After running this, 
you should see some links in the lower right pane of RStudio. 

Often you need some help specific to a function that you want to use. 
If you know the name of a function, such as ```lm```, you can type either 
```'?'(lm)``` or ```help(lm)``` in the console. 
You can also type keywords in the help window in RStudio. 
If you don't know the keywords, you will often find what you need by searching online with a query like "r linear regression" and you should find that the ```lm``` function is recommended. 
You should know that solutions provided on online fora 
tend to escalate to the most concise or 'elegant' solution,
i.e. *code golf*, which may not make sense to a new user.
Sometimes you want the solution that is most clear.
Over time, you will develop the skill of searching for help
--and work on your golf game, if that is your style.



