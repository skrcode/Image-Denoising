function CFTree = train_images(psz)

%% Apply Edge Preserving Filter

num_iter = 5;
delta_t = 1/7;
kappa = 30;
option = 2;


%% Read Images from Folder

X = zeros(1,psz*psz);
Y = zeros(1,1);
srcFiles = dir('C:/Users/Suraj Rajan/Desktop/major project/MP Codes/src/Training Set/*.tiff');

for i = 1 : length(srcFiles)
    filename = strcat('C:/Users/Suraj Rajan/Desktop/major project/MP Codes/src/Training Set/',srcFiles(i).name);
    I = imread(filename);
    I = im2double(I);
    I = I - anisodiff2D(I,num_iter,delta_t,kappa,option);
    x = get_patches(I,psz);
    X = [X;x];
end

%% Learn m * m patches with dictionary learning

CFTree = birch_main(X,7,0.01);



