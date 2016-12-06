%% Train images
psz = 5;
%block_size = 50;
CFTree = train_images(psz);
%load CFTree.mat;

%% Read Image
disp('Reading Image....');
img_org = imread('cameraman.tiff');
img_org = im2double(img_org);
M = size(img_org,1); N = size(img_org,2);
%img_org = img_org(floor(0.2*M):floor(0.2*M)+block_size,floor(0.2*N):floor(0.2*N)+block_size);
%M = size(img_org,1); N = size(img_org,2);
%% Add white gaussian noise
img_noise = awgn(img_org,10,'measured');
%img_noise = img_org;

%% Apply Edge Preserving Filter
disp('Applying Edge Preserving Filter');
num_iter = 5;
delta_t = 1/7;
kappa = 30;
option = 2;
img_edge_filtered = anisodiff2D(img_noise,num_iter,delta_t,kappa,option);
img_edge = img_noise - img_edge_filtered;

%% Use the CF-Tree to find the closest clusters
disp('Using the CF-Tree to find the closest clusters');
root = CFTree.getchildren(1);
h = 7;
N = size(img_edge,1);
M = size(img_edge,2);
img_filtered = zeros(N,M);

for i = floor(psz/2)+1:N-floor(psz/2)
    for j = floor(psz/2)+1:M-floor(psz/2)
        patch_temp = img_edge(i-floor(psz/2) : i+floor(psz/2),j-floor(psz/2) : j+floor(psz/2));
        patch = reshape(patch_temp,1,psz*psz);
        cluster = get_cluster(root(1),CFTree,patch);
        img_filtered(i,j) = NLMPatch(patch,cluster,h,psz); % Apply NLM to the residual image with cluster images
    end
end

%% Display the 4 images showing results %%%%%%%%%
%subplot(2,2,1),imshow(img_edge),title('original');
subplot(2,2,1),imshow(img_noise),title('noisy');
subplot(2,2,3),imshow(img_edge_filtered),title('edge filtered image');
subplot(2,2,2),imshow(img_edge),title('edge');
subplot(2,2,4),imshow(img_filtered+img_edge_filtered),title('final');

%% Compute the SNR and PSNT values and display

[peaksnr, snr] = psnr(img_edge_filtered,img_org);
fprintf('\n The Peak-SNR value is %0.4f', peaksnr);
fprintf('\n The SNR value is %0.4f \n', snr);

[peaksnr, snr] = psnr(img_edge_filtered+img_filtered,img_org);
fprintf('\n The Peak-SNR value is %0.4f', peaksnr);
fprintf('\n The SNR value is %0.4f \n', snr);
