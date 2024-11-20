F = importdata("flyingtimeseries.mat")
G = importdata("groundtimeseries.mat")

Rf = cov(F(2:6,1:6)')
Rg = cov(G(2:6,1:6)')

