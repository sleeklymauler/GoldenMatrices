% author: Luke Sellmayer

% encrypts a plaintext matrix using a golden matrix with permutation P1
%
% inputs: plainText, message matrix to encrypt; xKey, the x-key to use for
% encryption
%
% outputs: evenEncrypt, cipher matrix using Q^(2x) golden matrix;
% oddEncrypt, cipher matrix using Q^(2x+1) golden matrix
function [evenEncrypt, oddEncrypt] = goldenEncrypt(plainText, xKey)
    % definitions

    % golden ratio
    phi = (1 + sqrt(5)) / 2;
    
    % symmetrical hyperbolic fibonacci functions
    % sin
    sFs = @(x) ( (phi ^ x) - (phi ^ -x) ) / sqrt(5);
    % cos
    cFs = @(x) ( (phi ^ x) + (phi ^ -x) ) / sqrt(5);

    % matrices

    % create message matrix using permuation P1
    M = [plainText(1, 1), plainText(1, 2); plainText(2, 1), ...
        plainText(2, 2)];
    % create even Fibonacci Q-matrix using x-key
    evenQ = [cFs(2 * xKey + 1), sFs(2 * xKey);
          sFs(2 * xKey), cFs(2 * xKey - 1);];
    % create odd Fibonacci Q-matrix using x-key
    oddQ = [sFs(2 * xKey + 2), cFs(2 * xKey + 1);
          cFs(2 * xKey + 1), sFs(2 * xKey);];

    % RETURN VALUES
    
    % cipher encrypted by even Q-matrix
    evenEncrypt = M * evenQ;
    % cipher encrypted by odd Q-matrix
    oddEncrypt = M * oddQ;
end