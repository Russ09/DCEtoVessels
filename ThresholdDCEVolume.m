function [ ThreshParamMap ] = ThresholdDCEVolume( DCE4D, ParamMap ,meanThresh)
%
if (nargin < 2)
        [fname, folder1] = uigetfile('*.nii', 'Open 4D Volume');
        DCE4D = load_untouch_nii([folder1, fname]);
        [fname, folder1] = uigetfile([folder1,'*.nii'], 'PK Parameter Map');
        ParamMap = load_untouch_nii([folder1, fname]);
end

if (nargin < 3)
   
    meanThresh = 7000;
    
end

Dims = size(ParamMap.img);

MeanMap = mean(DCE4D.img,4);
MaxMap = max(DCE4D.img,4);

ThreshParamMap = ParamMap;

ThreshParamMap.img = (ParamMap.img).*(MeanMap > meanThresh);
figure(1);
imshow3D(MeanMap);
figure(2);
imshow3D(ThreshParamMap.img);

end