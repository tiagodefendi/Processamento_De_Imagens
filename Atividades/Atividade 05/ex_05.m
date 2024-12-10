pkg load image;

imagem = imread("./input/pratica5.png");
imagem = im2double(imagem);

#zero padding
imagem_padded = fft2(imagem, 512, 512);

#centralizando a transformada de fourier
imagem_centralizada = fftshift(imagem_padded);

#magnitude da transformada
magnitude = abs(imagem_centralizada);
magnitude = uint8(magnitude);

# 7 filtro passa-baixa gaussiano
P = 512;
Q = 512;
D0 = 20;
filtro = zeros(P,Q);

#calculando os valores do filtro
for i = 1:P
  for j = 1:Q
    D_uv = sqrt((i - P/2)^2 + (j - Q/2)^2);

    filtro(i, j) = exp( - (D_uv^2) / (2 * D0^2));
  endfor
endfor

#multiplicando o filtro passa-baixa pela transformada de fourier
imagem_filtrada = imagem_centralizada;

for i = 1:512
  for j = 1:512
    imagem_filtrada(i, j) = imagem_filtrada(i, j) * filtro(i, j);
  endfor
endfor

#descentralizando a matriz
matriz_descentralizada = ifftshift(imagem_filtrada);

#transformada inversa rápida de Fourier 2D na matriz descentralizada
transformada_inversa = ifft2(matriz_descentralizada);

#parte real da matriz da transformada inversa rápida
parte_real = real(transformada_inversa);

#extraindo a região M × N do canto superior esquerdo da matriz
M = 256;
N = 256;

imagem_regiao = parte_real(1:M, 1:N);

#passando para uint8
resultado = im2uint8(imagem_regiao);

#imagem original
figure(1);
imshow(imagem);

#imgem espectro de furier
figure(2);
imshow(magnitude);
imwrite(magnitude, "./output/magnitude.png");

#imagem do filtro passa-baixa gaussiano
figure(3);
imshow(filtro);
imwrite(filtro, "./output/filtro.png");

#imagem do resultado
figure(4);
imshow(resultado);
imwrite(resultado, "./output/resultado.png");

# ==============================================================================
# Responda a pergunta 4
# Fazer o zero padding na imagem e aplicar a transformada rápida de Fourier 2D
# sobre a imagem de entrada, use a função fft2(A, m, n). Qual a dimensão
# da transformada? Responda essa questão no comentário do seu código
# R: A dimensão da transformada é 2*M e 2*N = 512 e 512

