function [newp] = NLMPatch(noisy_patch, patches,h,psz)
%% NLMPatch(noisy_patch,patches,h)
% noisy_patch = the input patch of the original image
% patches = patches to be compared to\
% h = filtering paramater
% psz = patch size


newp = 0;
w_sum = 0;
[m ,n] = size(patches);
mid = floor(psz*psz/2)+1;

for i = 1:m
    p = noisy_patch;
     q=patches(i,:);
     p(1,mid)=0;
     q(1,mid)=0;
     d=p-q;
     d=sum( d .* d );
     w=exp(-d/(h^h));
     w_sum =w_sum+w;
     newp = newp + patches(i,mid) * w;
end
 
 newp = newp/w_sum;