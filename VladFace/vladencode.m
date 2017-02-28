function vlad= vladencode(D, F, numOfCenters,d)
%
% ===========
% D    (Input) : dictionary m (samples) x d (sample) size 
% F    (Input) : Features to encode using Dicionary D c (centers) x d
%  (center size)
% numOfCenters (input): Number of Centers (clusters in D)
% d    (input) : Sample Dcimensionality (Also Dictionary elements
% dimensionality)
% ===========
% vlad (Output): Encoded features
% ===========
%
% Author: Dimitris Kastaniotis,
% dkastaniotis@upatras.gr
% www.upcv.upatras.gr/personal/kastaniotis
% Please do not hesitate to contant me for any suggestions, bugs, etc...
%
% Function Decsription
%
% Assign every feature f_i in F to a Codebook/Dictionary
% vector D_i. Then aggergate the residual between
% f_i- D_i to the vlad_i
%
% References:
% Aggregating local descriptors into a compact image representation
% Herv? J?gou, Matthijs Douze, Cordelia Schmid and Patrick P?rez
% Proc. IEEE CVPR‘10, June, 2010
%

% a. Allocate space for output vector vlad
[N,M]=size(D);
% check if everything is ok...
assert(N==numOfCenters,'Number of centers is incorect (or the matrix is transposed')
assert(M==d,'Dimension mismatch (or the matrix is transposed')
   
vlad = zeros(1,M*N);
% b. Compute distances between Codebook and Features

 
data= F;
    
dist= squareform(pdist([D;data])); % here we use euclidean distance (Default)

% We want the distances between data and D

[dsts, pos]=sort(dist(numOfCenters+1:end,1:numOfCenters),2,'ascend');
% pos has the position of the closest Dictionary Element 
% for every sample vector
% Now we aggregate the residuals
for i=1:size(pos,1)
    % compute the residual
    rs =  data(i,:)-D(pos(i,1),:);
    % aggregate
    vlad((pos(i,1)-1)*M+1:(pos(i,1))*M)=vlad((pos(i,1)-1)*M+1:(pos(i,1))*M)+rs;
    
end
% Normalize with the number of samples
vlad=vlad./length(pos);

% L2 normalize
vlad=vlad./norm(vlad);

% we are done!

end