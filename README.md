# polyfitc
A function to compute polynomial regression with fixed coefficients

Determine the best-fitting polynomial of degree n to the observations (x, y), under the additional constraint that some coefficients are given and fixed.

## Usage:
 `p = polyfitc(x, y, n, c)`
where x, y, and n are the same as polyfit(x, y, n), and c is a vector of lenght n+1 that stores the fixed coefficients, using NaN or Inf for the coefficients that have to be determined.

For instance,
```
  n = 3;
  c = [inf, nan, 3, -inf];
```
specifies that the desired polynomial is of the shape
```
  p(x) = p(1) * x^3 + p(2) * x^2 + 3 * x + p(4)
 ```
that is, p([1, 2, 4]) are computed and p(3) = 3.

If c is not passed as an input, or it only contains NaNs and Infs, polyfitc(x, y, n, c) returns the same output of polyfit(x, y, n).

## Authorship

Author: Stefano Gambuzza

Email: stefanogambuzza AT duck DOT com

Licence: MIT Licence
