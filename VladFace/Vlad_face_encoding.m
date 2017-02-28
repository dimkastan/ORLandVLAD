% *********************************
%  Demo Vlad for face recognition
% *********************************
% -Initially local patches are extracted from images
% -Then using k-means C clusters are estimated
% -Using the center of these cluster we encode every face according
% to VLAD feamework 
% -Finally we visualize results in three dimensions using classic MDS
% 
%
%
%  Copyright 2016
% Author: Dimitris Kastaniotis
% dkastaniotis@upatras.gr
% Please sent me your comments and suggestions
%
% *********************************
%% add path current folder
addpath(pwd);
cd ORL

%% load images
 
face=cell(40,10);
for i=1:40
    fprintf('Loading person %d\n',i);
    cd(sprintf('s%d',i));
    for j=1:10
       face{i}{j}=imread(sprintf('%d.pgm',j)); 
    end
    cd ..
end

%% Extract Features
feats=cell(40,10);
for i=1:40  
    for j=1:10
        feats{i}{j}=im2col(face{i}{j},[7 7]);
    end
end

%% Compute Dictionary 
% Use a small set to find clusters in patches using k-means
X=[]; % this is not efficient but its ok for small data sizes
for i=1:1:length(feats)
    X=[X feats{i}{1}];
end


%% Use  k-means to compute clusters
numOfCenters=8; % number of centers
fprintf('Compute center %d of clusters\n',numOfCenters);
[id,Dict]=kmeans(double(X)',numOfCenters,'MaxIter',1000);

%% Select K persons to encode
K = 40;
fprintf('Evaluating Demo using only %d users\n',K);

%% encode features into compact vectors
d = size(feats{1}{1},1); 
vlad= cell(K,10);
for i=1:K
    fprintf('\nEncoding person %d',i);
    for j=1:10
        fprintf('.');
        vlad{i}{j}=vladencode(Dict, double(feats{i}{j}'), numOfCenters,d);
    end
end
fprintf('\n');
%% unroll data into vecs
vecs=[]; % this is not efficient but its ok for small data sizes
for i=1:K
    for j=1:10
            vecs=[vecs;vlad{i}{j}];
     end
    
end
%% Compute samples pairwise distances
D= squareform(pdist(vecs));
figure;
imagesc(D);
title('Distance Matrix')

%% view in 3 dimensions using classic mds
y = cmdscale(D,3);
% open a new figure
figure;
% view in three dimensions
scatter3(y(:,1),y(:,2),y(:,3),3,ceil((1:K*10)./10),'filled');
hold on
labels=[ceil((1:K*10)./10)];
for i=1:length(y)
    text(y(i,1) ,y(i,2), y(i,3),sprintf('%d',labels(i)));
end
title('Classic MDS')
