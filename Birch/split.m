function CFTree = split(pos,CFTree,B,T)

%% CFTree = split(pos,CFTree,B,T)
% CFTree = The existing tree
% pos = index of the node currently being seen in the tree
% B = branching factor
% T = threshold

%%

%% If root
if(pos == 1)
    cur_nodes = CFTree.getchildren(pos);
    newnode.N = 0;newnode.LS = 0;newnode.SS = 0;
    for i = size(cur_nodes,2):-1:1
        newnode = addtheorem(newnode,CFTree.get(cur_nodes(i)));
    end
    [CFTree newpos] = CFTree.addnode(1,newnode);
    cur_nodes = CFTree.getchildren(pos);
    for i = size(cur_nodes,2)-1:-1:1
        t = CFTree.subtree(cur_nodes(i));   
        CFTree = CFTree.graft(newpos,t);
        CFTree = CFTree.chop(cur_nodes(i));
        newpos = newpos-nnodes(t);
    end
    return;
end

cur_nodes = CFTree.getchildren(pos);
if(size(cur_nodes)<=B)
    return;
end

newnode.N = 0; newnode.LS = 0; newnode.SS = 0;
n = (B+1)/2;
for i = n+1 : 2*n
    newnode = addtheorem(newnode,CFTree.get(cur_nodes(i)));
end

[CFTree newpos] = CFTree.addnode(CFTree.getparent(pos),newnode);
cur_nodes = CFTree.getchildren(pos);
for i = 2*n :-1:n+1
    t = CFTree.subtree(cur_nodes(i));   
    CFTree = CFTree.graft(newpos,t);
    CFTree = CFTree.chop(cur_nodes(i));
    newpos = newpos-nnodes(t);
end

newnode.N = 0; newnode.LS = 0; newnode.SS = 0;
for i = 1 : n
    newnode = addtheorem(newnode,CFTree.get(cur_nodes(i)));
end
CFTree = CFTree.set(pos,newnode);

cur_nodes = CFTree.getchildren(newpos);
newnode.N = 0; newnode.LS = 0; newnode.SS = 0;
for i = 1 : n
    newnode = addtheorem(newnode,CFTree.get(cur_nodes(i)));
end
CFTree = CFTree.set(newpos,newnode);
CFTree = split(CFTree.getparent(pos),CFTree,B,T);
