# Laboratory 6 - Labor Market Field Experiment - Race in Boston and Chicago

Authors: [Leonardo Sangali Barone](leonardo.barone@usp.br)

## Disclosure

Originally, this laboratory was prepared by myself for the Basics of Quantitative Methods for Public Policy Analysis course taught by Professor Bruno Cautrès at IPSA-USP Summer School. Since this year both courses are happening simultaneously, I decided to incorporate it in our lab schedule.

## Objective

We are going to partially replicate the results in of the Labor Market Field Experiment published by Marianne Bertrand e Sendhil Mullainathan in 2004. Download the Marianne Bertrand e Sendhil Mullainathan paper and data that comes with this laboratory.

We will do it by steps. 

## The problem

In Marianne Bertrand e Sendhil Mullainathan publisehd a study race in the labor market by sending fictitious resumes to help-wanted ads in Boston and Chicago newspapers. To manipulate perceived race, resumes were randomly assigned African-American or White-sounding names. We will look at the paper results and try to replicate part of it.

Open the original paper (at the laboratory materials) and read form page 994 to page 997 (section II - Experimental Design).

Cool design, isn´t it? After reading it, pay a lot of attention to table 1 at page 997. Can you interpret it?

## The data

Once you have understood the problem, you can start examining the dataset.

Each of the observations are resumes that were sent to a company. First, let´s look at the variables on the dataset:

```
describe
```

The variables give us important information on the resumes. The most important is: did the fake resumes recieved a call back from the company?

```
codebook call
tabulate call
```

Among 4478 resumes, 8.05% were called back. This is the unconditional expectation of the "call" variable: 8.05%. It is a proportion, since the variable is a binary variable.

Our main goal is to assess if the proportion of call backs are equal for  different racial groups. Besides, we could separate racial grupos between those in different cities or gender.

We can take a quick look at all those variables

```
codebook race city sex
tabulate race
tabulate city
tabulate sex
```

## Joint Distributions

Alert: If you have not seem joint distributions in class yet, stop here.

We could also look at the joint distributions of pairs of variables, like race and city or race and sex:

```
tabulate race city, row
tabulate race sex, row
```

Great! Now, before we move forward, let´s compare call back proportions among different groups.

First, let´s see if racial groups differ in call back proportions for all of our observations (resumes)

```
tabstat call, by(race) stat(mean)
```

Don´t rush! Try to interpret this result carefully. Do you think the experimental condition (race) affects the dependent variable (call back rates?)

(Don´t rush! Don´t rush! Don´t rush! Don´t rush!)

## Proportions test

Alert: If you have not seem hypothesis test in class yet, stop here.

Although tables are extremely useful, we don´t know if the difference we found among call back rates are relevant (statistically speaking). Are they? In order to assess that, we need a hypothesis test. Let´s see how we can perform it:

We need to recode the care variable into a numeric variable very quickly

```
generate race_n = 0
replace race_n = 1 if race == "b"
prtest call, by(race_n)
```

Wait! can you read the ouptut?

## Hypothesis test - reading the output - Exercise

a) Go back to table 1 at page 997 in the original paper. Can you see the elements of the hypothesis test that are represented in the table?
b) Read the full output of the hypothesis test. Can you understand it?

## Heterogeneous effects for groups - Exercise

We have already explored the main result of the paper: difference in proportions among racial groups. However, as we can see on table 1, the "treatment" effect can be separated by combination of other variables (specially city and gender).

Your task know is: using the if commands, try to replicate part (or maybe interely) table 1.

Hint: use logical operators to subset the data while using the "prtest" command for the proportions test

If you feel this task is too challenging, call for help. We can give you an example to start with.
