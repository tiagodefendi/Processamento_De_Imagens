pkg load image;

Einstein = imread("./input/imagem.jpg");

# criando matriz vazia
result = zeros(size(Einstein), "uint8");

# calcular o histograma
[counts, x] = imhist(Einstein);

# normalizar o histograma
cdf = cumsum(counts) / sum(counts);

# função de transformação
T = round(cdf * 255);

# aplicando pixel a pixel a função T(r)
for i = 1:size(Einstein, 1)
	for j = 1:size(Einstein, 2)
    	result(i, j) = T(Einstein(i, j) + 1); # função T(r) sobre a imagem de entrada
	end
end

# plotando o gráfico
figure(1);
plot(x, T);

# salvando a imagem
figure(2);
imshow(result);

imwrite(result, "./output/result.jpg");

