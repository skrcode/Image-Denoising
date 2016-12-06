function [cluster] = get_cluster(pos,CFTree,patch)
%% get_cluster(CFTree,img)
% pos = current node being traversed
% CFTree = input CF-Tree
% patch = patch of image to whose, similar cluster has to be computed

if(CFTree.isleaf(pos))
    cluster = CFTree.get(pos).value;
    return;
end

ans = 999999999;
ind = -1;
cur_nodes = CFTree.getchildren(pos);

%% Create a node for the value to be inserted
ls = patch;
ss = patch .* patch;
node.N = 1; node.LS = ls; node.SS = ss; node.value = []; 

for i = 1:size(cur_nodes,2)
    temp = euclidean(CFTree.get(cur_nodes(i)).LS/CFTree.get(cur_nodes(i)).N,node.LS/node.N);
    if(temp<ans)
        ans = temp;
        ind = cur_nodes(i);
    end
end
cluster = get_cluster(ind,CFTree,patch);