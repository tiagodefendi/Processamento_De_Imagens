Img_01 = imread("./input/tungsten_filament_shaded.tif");
Img_01 = im2double(Img_01);
Img_02 = imread("./input/tungsten_sensor_shading.tif");
Img_02 = im2double(Img_02);

Res = Img_01./Img_02;

imshow(Res);

imwrite(Res, "./output/tungsten_filament_corrected.tif");

