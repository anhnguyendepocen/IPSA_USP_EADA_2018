# Laboratory 12 - Generating new variables and calculating functions of variables (mean and correlation)

Authors: [Leonardo Sangali Barone](leonardo.barone@usp.br) and Patrick Silva

## Objective

In this lab we check the formulas for variance and correlation by creating new variables and calculating the summation of variables.

## Mean and variance

In a dataset where all of the observations have the same weight, it's is quite straightforward to calculate the summation of a variable using the tabstat command. For example:

```
tabstat api13, stat(sum)
```

The sample mean is the sum of the variable divided by the number of observations. With the "summarize" command, we can discover the number of non-missing observations:

```
summarize api13
```

The sample mean is (as you just saw with the "summarize") command is:

```
display  7256222/9258 
```

Easy, right? Now, let's calculate the variance and the standard deviation of api13. First, we need to create a new variable that is the distance to the mean of each value of api13. We can call it d_api13:

```
generate d_api13 = api13 - 783.77857
```

Did you notice the warning on missings? A variable derived from another always keep the missings values. If you are curious, open the data matrix and check there is a new collum at the end of it. As we discussed, the sum of the distances is zero. We can check that using the "tabstat" command: 

```
tabstat d_api13, stat(sum)
```

It is not zero in this case!!! Why? Because of the decimals and how computers deal with rounding errors, which make  calculations imprecise. Still, the number is very, very close to zero considering this variables can assume values from 0 to 1000.

Good. Now we can square these distances. Let's store it into a new variable called d2_api13:

```
generate d2_api13 = d_api13 * d_api13
```

Now, we can sum these squared distances and divide by the number of valid observations to get the variance of api13:

```
tabstat d2_api13, stat(sum)
```

Bizzare? Yes, because it is in scientific notation. 9.96e+07 means 9.96 times 10.000.000. We can use the "format" option to get it right. "11.2f" means we want to show 11 numbers before decimals and 2 decimals.

```
tabstat d2_api13, stat(sum) format(%11.0g)
```

Now, calculate the variance:

```
display 99622957.01 / 9258
```

And the standard deviation -- sqrt means "square root":

```
display sqrt(99622957.01 / 9258)
```

We can check with the value calculated by Stata:

```
summarize api13
```

Close enough, isn't it? Again, the difference is just a matter on how computers deal/store with decimals.

## Mean and variance - Your turn

Do it yourself for the variable that represent school parents average education.

## Mean and variance - Your turn, again
 
Do you remember what happens with the mean and the variance when we add a constant to a variable?

Your task is to generate 2 new variables, one that is a variable from the dataset plus a constant and the other one that is a variable from the  dataset time a constant and verify the consequences for the meaan and the variance. You can use Stata commands to get the new values of the mean and the variance (which is the square of the standar deviation)

## Covariance and correlation

We can repeat the same procedure as above to generate the covariance and correlation between two variables, for example, api13 and api12. First, we calculate the mean for both:

```
summarize api13 api12
```

Next, we calculate distances from the mean. Don't forget to drop our old d_api13 variable out

```
drop d_api13
generate d_api13 = api13 - 783.77857
generate d_api12 = api12 - 789.8357
```

Then we multiply both.

```
generate dd = d_api12 * d_api13
```

Be extremely careful: if there is missing in one variable, the new variable will be also missing.

Finally, we can sum the multiplication of distances and divide by the number of valid observations to get the covariance between the two variables:

```
summarize dd
tabstat dd, stat(sum) format(%11.0g)
display  91233466.9 / 9025
```

If we divid the result again, by both standard deviations, we get the  correlation:

```
summarize api13 api12 if api12 != . &  api13 != .
display 10108.971 / (102.7223 *  101.9599)
```

By using the stata command for correlation we get a very close result and the difference, again, is due to computational errors.