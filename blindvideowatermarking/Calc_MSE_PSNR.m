function [MSE, PSNR] = Calc_MSE_PSNR(clean,denoised)
% Compute MSE and PSNR.
%
% clean: inputted clean image
% denoised: inputted denoised image
% MSE: outputted mean squared error
% PSNR: outputted peak signal-to-noise ratio

N = prod(size(clean));
clean = double(clean(:)); denoised = double(denoised(:));
t1 = sum((clean-denoised).^2);
MSE = sqrt(t1/N);
PSNR = 20*log10(max(clean)/MSE);
