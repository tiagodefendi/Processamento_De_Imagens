pkg load image;

imagem = imread("./input/pratica4.jpg");
imagem = im2double(imagem);

filtro = ones(9) / 81;

# filtro da média com borda de zeros
resultado_zeros = zeros(size(imagem), "double");
resultado_zeros = filter2(filtro, imagem); #filter2(filtro, imagem, 'full') = borda de zeros

# filtro da média com replicação
temp1 = padarray(imagem, [4, 4], 'replicate');
resultado_replicacao = filter2(filtro, temp1,  'valid'); #para bordas com replicacao

# filtro de sobel
sobel_x = [-1 0 1; -2 0 2; -1 0 1];
sobel_y = [-1 -2 -1; 0 0 0; 1 2 1];


temp2 = padarray(imagem, [1, 1], 'replicate');

gx = filter2(sobel_x, temp2, 'valid');
gy = filter2(sobel_y, temp2, 'valid');

#magnitude do gradiente
M = abs(gx) + abs(gy);

# imagem original
figure(1);
imshow(imagem);

# imagem com filtro da média com borda de zeros oq aconteceu?
# a borda está preta, pois utilizamos padding de zeros
figure(2);
imshow(resultado_zeros);

#imagem com filtro da média com borda de replicação
figure(3);
imshow(resultado_replicacao);

#imagem da magnitude do gradiente
figure(4);
imshow(M, []);
