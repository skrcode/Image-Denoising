function CFTree = birch_main(X,B,T);
%% CFTree = birch_main(X,B,T)
% X = Training patches
% B = branching factor
% T = threshold

%% Create an empty CF Tree

CFTree = tree;

%% Get each data point, insert into CF- Tree
disp('Getting each data point and inserting into CF-Tree...');

for i = 1:size(X,1)
    CFTree = insert_CFTree(X(i,:),B,T,CFTree);
end


