% author: Luke Sellmayer

% decrypts a cipher matrix created from goldenEncrypt back into plaintext
%
% inputs: evenEncrypt, cipher matrix created by Q^(2x) golden matrix;
% oddEncrypt, cipher matrix created by Q^(2x+1) golden matrix; xKey, x-key
% to use to decrypt cipher matrices
%
% outputs: evenDecrypt, plaintext matrix decrypted by Q^(2x) golden matrix;
% oddDecrypt, plaintext matrix decrypted by Q^(2x+1) golden matrix
function [evenDecrypt, oddDecrypt] = goldenDecrypt(evenEncrypt, ...
    oddEncrypt, xKey)
    % definitions

    % golden ratio
    phi = (1 + sqrt(5)) / 2;
    
    % symmetrical hyperbolic fibonacci functions
    % sin
    sFs = @(x) ( (phi ^ x) - (phi ^ -x) ) / sqrt(5);
    % cos
    cFs = @(x) ( (phi ^ x) + (phi ^ -x) ) / sqrt(5);

    % create inverse even Q-matrix
    inverseEvenQ = [cFs(2 * xKey - 1), -1 * sFs(2 * xKey);
           -1 * sFs(2 * xKey), cFs(2 * xKey + 1);];
    % create inverse odd Q-matrix
    inverseOddQ = [-1 * sFs(2 * xKey), cFs(2 * xKey + 1);
           cFs(2 * xKey + 1), -1 * sFs(2 * xKey + 2);];

    % RETURN VALUES
    
    % decrypt using even Q-matrix
    evenDecrypt = evenEncrypt * inverseEvenQ;
    % decrypt using odd Q-matrix
    oddDecrypt = oddEncrypt * inverseOddQ;
end