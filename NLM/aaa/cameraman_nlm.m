f = imread('lena.tiff');
f = im2double(f);
g = awgn(f,10,'measured');
r = NLmeansfilter(f,5,2,10);
% [a, b] = psnr(g,f);
% [c, d] = psnr(r,f);
subplot(1,2,1), imshow(g), title('noisy');
subplot(1,2,2), imshow(r), title('noiseless');

