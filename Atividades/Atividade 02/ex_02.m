Pollen = imread("./input/pollen.jpg");

result = zeros(889,889,"uint8"); # Criando uma imagem "zerada/nula"
result = Pollen; # Copiando a imagem de entrada na imagem "zerada"

# Definindo os pontos
r1 = 90; #90
s1 = 30; #30

r2 = 140; #140
s2 = 230; #230

# Equação da Reta
# m = (xb-xa)/(yb-ya)
# y = ya + m*(x-xa)

ys = zeros(255, 1, "uint8"); # Vetor para guardar os Ys
Pollen = imread("./input/pollen.jpg");

result = zeros(889,889,"uint8"); # Criando uma imagem "zerada/nula"
result = Pollen; # Copiando a imagem de entrada na imagem "zerada"

# Definindo os pontos
r1 = 90; #90
s1 = 30; #30

r2 = 140; #140
s2 = 230; #230

# Equação da Reta
# m = (xb-xa)/(yb-ya)
# y = ya + m*(x-xa)

ys = zeros(255, 1, "uint8"); # Vetor para guardar os Ys

# Do ponto (0,0) até (r1,s1)
m = s1/r1;
for x = 0:r1
  y = m*x;
  ys(x+1) = y;
endfor

# Do ponto (r1,r1) até (r2,s2)
m = (s2-s1)/(r2-r1);
for x = r1:r2;
  y = s1+m*(x-r1);
  ys(x+1) = y;
endfor

# Do ponto (r2,r2) até (255,255)
m = (255-s2)/(255-r2);
for x = r2: 255
  y = s2+m*(x-r2);
  ys(x+1) = y;
endfor

# Grafico plotado com as equações da reta
figure(1)
plot(0:255, ys);

# Aplicando pixel a pixel o contraste
for i = 1:889
  for j = 1:889
    result(i,j) = ys(Pollen(i,j)); # Função T(r) sobre a imagem de entrada
  endfor
endfor

figure(2)
imshow(result);

imwrite(result, "./output/result.png");
