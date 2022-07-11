function p = polyfitc(x, y, n, c)
%  p = POLYFITC(x, y, n, coeffs)
%  Determine the best-fitting polynomial of degree n to the observations (x, y)
%  under the additional constraint that some coefficients are given and fixed.
%
%  Usage:
%   p = polyfitc(x, y, n, c)
%  where x, y, and n are the same as polyfit(x, y, n)
%  and c is a vector of lenght n+1 that stores the fixed coefficients, 
%  using NaN or Inf for the coefficients that have to be determined.
%  For instance, 
%    n = 3;
%    c = [inf, nan, 3, -inf];
%  specifies that the desired polynomial is of the shape
%    p(x) = p(1) * x^3 + p(2) * x^2 + 3 * x + p(4)
%  that is, p([1, 2, 4]) are computed and p(3) = 3.
%
%  If c is not passed as an input, or it only contains NaNs and Infs,
%  polyfitc(x, y, n, c) returns the same output of polyfit(x, y, n)
%
%  Author: Stefano Gambuzza
%  Email: stefanogambuzza AT duck DOT com
%  Licence: MIT Licence

% check on inputs
narginchk(3, 4);

if numel(x) ~= numel(y)
	error('The first two inputs must have the same number of elements.');
end
if ~isscalar(n) || n ~= floor(n) || n < 0
	error('The polynomial degree must be an integer, nonnegative scalar');
end
if nargin == 3
	c = nan(n+1, 1);
end
if length(c) ~= n+1
	error('The number of coefficients must be n+1');
end

x = x(:);
y = y(:);
mask = isfinite(c); % 1 if the coefficient is fixed, 0 otherwise;

% build Vandermonde matrix
V = ones(length(x), n+1);
for jj = 2:n+1
	V(:, jj) = x.^(jj-1);
end
V = fliplr(V); % to keep up with Matlab's custom on the order of coefficients
V(:, mask) = 0; % blank the lines that we don't have to fit

% build modified y vector
c = fliplr(c);
for jj = 1:length(c)
	if isfinite(c(jj))
		y = y - c(jj) * x.^(jj-1);
	end
end
p = V\y; % this throws a warning cause V has det == 0 (as we imposed that)
c = fliplr(c);
p(mask) = c(mask);
