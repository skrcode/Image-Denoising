function CFTree = insert_node(pos,node,val,CFTree,B,T)

%% insert_node(pos,node,val,CFTree,B,T);
% CFTree = The existing tree
% node = The node that has to be inserted
% pos = index of the node currently being seen in the tree
% val = value fields of the node
% B = branching factor
% T = threshold

%% Check if node is leaf node
if(CFTree.isleaf(pos)) 
    temp_node = CFTree.get(pos);
    %%If this node is also the root
    if(CFTree.getparent(pos) == 1)
        centroid = temp_node.LS/temp_node.N;
        if(euclidean(centroid,node.LS/node.N) <= T)
            temp = addtheorem(node,temp_node);
            temp.value = [temp_node.value; val];
            CFTree = CFTree.set(pos,temp);
            return;
        end
        newnode = addtheorem(node,temp_node);
        node.value = [node.value; val];
        n1 = node; n2 = temp_node;
        CFTree = CFTree.removenode(pos);
        CFTree = CFTree.addnode(1,newnode);
        CFTree = CFTree.addnode(pos,n1); CFTree = CFTree.addnode(pos,n2);
        return;
    end
    temp = addtheorem(temp_node,node);
    temp.value = [temp_node.value; val];
    CFTree = CFTree.set(pos,temp);
    return;
end

%%If not a leaf node
cur_nodes = CFTree.getchildren(pos);

%% If the node's children are leaf nodes
if(CFTree.isleaf(cur_nodes(1)))
    f = 0;
    mn = 999999;
    for i = 1:size(cur_nodes,2)
        temp = CFTree.get(cur_nodes(i));
        centroid = temp.LS/temp.N;
        if(euclidean(centroid,node.LS/node.N) < mn)
            ind = i;
            mn = euclidean(centroid,node.LS/node.N);
        end
    end
    
    if(mn <= T)
        CFTree = insert_node(cur_nodes(ind),node,val,CFTree,B,T);
        f = 1;
    end
    if(f == 1)
        newnode.N = 0;newnode.LS = 0;newnode.SS = 0;
        children = CFTree.getchildren(pos);
        for i = 1:size(children,2)
            newnode = addtheorem(newnode,CFTree.get(children(i)));
        end
        CFTree = CFTree.set(pos,newnode);
        return;
    end
    node.value = val;
    CFTree = CFTree.addnode(pos,node);
    newnode.N = 0;newnode.LS = 0;newnode.SS = 0;
    children = CFTree.getchildren(pos);
    for i = 1:size(children,2)
        newnode = addtheorem(newnode,CFTree.get(children(i)));
    end
    
    CFTree = CFTree.set(pos,newnode);
    if(size(CFTree.getchildren(pos),2)>B)
        CFTree = split(pos,CFTree,B,T);
    end
    return;
end

%% If the node's children are not leaf nodes
ans = 999999999;
ind = -1;
for i = 1:size(cur_nodes,2)
    temp = euclidean(CFTree.get(cur_nodes(i)).LS/CFTree.get(cur_nodes(i)).N,node.LS/node.N);
    if(temp<ans)
        ans = temp;
        ind = cur_nodes(i);
    end
end

CFTree = insert_node(ind,node,val,CFTree,B,T);

newnode.N = 0;newnode.LS = 0;newnode.SS = 0;
children = CFTree.getchildren(pos);
for i = 1:size(children,2)
    newnode = addtheorem(newnode,CFTree.get(children(i)));
end
CFTree = CFTree.set(pos,newnode);


        
        
        


