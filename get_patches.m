function [X] = get_patches(img,psz)
%% Read Patches from Image
disp('Reading Patches from Image...');
X = zeros(1,psz*psz);
N = size(img,1);
M = size(img,2);
foo = floor(psz/2);
block_size = 100;
img = img(floor(0.2*M):floor(0.2*M)+block_size,floor(0.2*N):floor(0.2*N)+block_size);
N = size(img,1);
M = size(img,2);
for i = foo+1:N-foo
    for j = foo+1:M-foo
        patch = img(i-foo : i+foo,j-foo : j+foo);
        patch = reshape(patch,1,psz*psz);    
        X = [X;patch];
    end
end
X = X(1:end,:);
