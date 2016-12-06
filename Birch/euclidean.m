function dist = euclidean(X,Y)

dist = X-Y;
dist = dist .* dist;
dist = sum(dist);
dist = sqrt(dist);