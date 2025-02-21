pkg load image;

# carregando a imagem
img = im2double(imread('./input/projeto pratico.jpg'));

# carregando o filtro
filtro = im2double(imread('./input/filtro.jpg'));

# separarando os canais de cor
R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);

# aplicando FFT em todos os canais
F_R = fftshift(fft2(R));
F_G = fftshift(fft2(G));
F_B = fftshift(fft2(B));

# calculando o espectro
F_original_mean = (log(1 + abs(F_R)) + log(1 + abs(F_G)) + log(1 + abs(F_B))) / 3;

# normalizar o espectro para fazer imwrite
F_original_mean_norm = (F_original_mean - min(F_original_mean(:))) / (max(F_original_mean(:)) - min(F_original_mean(:)));

# aplicando o filtro em cada canal
F_R_filtrado = F_R .* filtro;
F_G_filtrado = F_G .* filtro;
F_B_filtrado = F_B .* filtro;

# fazendo a transformada inversa para reconstruir a imagem
R_filtrado = real(ifft2(ifftshift(F_R_filtrado)));
G_filtrado = real(ifft2(ifftshift(F_G_filtrado)));
B_filtrado = real(ifft2(ifftshift(F_B_filtrado)));

# recombinando os canais filtrados
img_filtrada = cat(3, R_filtrado, G_filtrado, B_filtrado);

# normalizando para valores entre 0 e 1
img_filtrada = (img_filtrada - min(img_filtrada(:))) / (max(img_filtrada(:)) - min(img_filtrada(:)));


# calculando os tamanhos para o padding
[M,N,canais] = size(img_filtrada);
P = M*2;
Q = N*2;

# passando para hsi
HSV = rgb2hsv(img_filtrada);

# separando os canais do HSI
Hr = HSV(:,:,1);
Sr = HSV(:,:,2);
Vr = HSV(:,:,3);

# fazendo zero padding
imagemPadded = padarray(Vr, [max(0,P-M), max(0,Q-N)], 0, 'post');

# ajustando o contraste
v_contraste = imadjust(imagemPadded, [0.1;0.95],[0;1]);

# passando imagem para o tamanho original
imgFinal = imcrop(v_contraste, [1,1,N-1,M-1]);

# montando o hsi
imgRemontada = cat(3,Hr,Sr,imgFinal);

# passando para RGB
img_contraste = hsv2rgb(imgRemontada);

# resultados
# espectro da imagem
figure(1);
imshow(F_original_mean, []);
title("Espectro da imagem");
imwrite(F_original_mean_norm, "./output/img_espectro.png");

% filtro notch feito em um editor de foto do espectro
figure(2);
imshow(filtro);
title("Filtro");

# imagem original
figure(3);
imshow(img);
title("Imagem original");

# resultado com contraste ajustado
figure(4);
imshow(img_contraste);
title("Imagem com Contraste Ajustado");
imwrite(img_contraste, "./output/img_resultado.png");
