function CFTree = insert_CFTree(X,B,T,CFTree)

%% insert_CFTree(X,B,T,CFTree)
% X = vector of values to be inserted into the tree
% B = brancing factor of the tree
% T = Threshold
% CFTree = The existing tree

%% Create a node for the value to be inserted
ls = X;
ss = X .* X;
node.N = 1; node.LS = ls; node.SS = ss; node.value = []; 


%% Check if Tree is empty
if(nnodes(CFTree) == 1)
    node.value = [];
    node.value = [node.value;X];
    CFTree = CFTree.addnode(1,node);
    return;
end

%% Insert node if not root
root = CFTree.getchildren(1);
CFTree = insert_node(root(1),node,X,CFTree,B,T);

