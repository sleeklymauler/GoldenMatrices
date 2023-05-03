% author: Luke Sellmayer

% calculate and plot relative error for different key values

% requires: goldenEncrypt.m, goldenDecrypt.m

% plaintext message
plaintext = [-100, 567; -179, 990;];

% potential keys to use, assuming permutation P1
keys = -20 : 0.001 : 20;

% arrays to hold relative errors for different key values
evenRelativeErrs = zeros(1, length(keys));
oddRelativeErrs = zeros(1, length(keys));

% for every possible key value
for i = 1 : length(keys)
    % encrypt and then decrypt the plaintext message using key
    [evenEncrypt, oddEncrypt] = goldenEncrypt(plaintext, keys(i));
    [evenDecrypt, oddDecrypt] = goldenDecrypt(evenEncrypt, oddEncrypt, ...
                                                keys(i));
    
    % calculate relative error between values of original plaintext matrix
    % and values of decrypted matrix
    evenRelativeErrSum = 0;
    oddRelativeErrSum = 0;
    for j = 1 : 2
        for k = 1 : 2
            evenRelativeErrSum = evenRelativeErrSum + ...
                (abs(plaintext(j, k) - evenDecrypt(j, k))) / ...
            abs(plaintext(j, k));
            oddRelativeErrSum = oddRelativeErrSum + ...
                (abs(plaintext(j, k) - oddDecrypt(j, k))) / ...
            abs(plaintext(j, k));
        end
    end
    % store in vectors to plot later
    evenRelativeErrs(i) = evenRelativeErrSum;
    oddRelativeErrs(i) = oddRelativeErrSum;
end

% plot key values against relative errors

% even golden matrices
figure("Name", "Relative Error for Even Golden Matrix");
hold on;
title("Relative Errors for Q-Matrices of form $Q^{2x}$", ...
    'interpreter', 'latex');
xlabel("Key Values, -20 <= key <= 20");
ylabel("Relative Error, |observed - expected| / expected");
scatter(keys, evenRelativeErrs, 10, 'red', 'filled');
hold off;

% odd golden matrices
figure("Name", "Relative Error for Odd Golden Matrix");
hold on;
title("Relative Errors for Q-Matrices of form $Q^{2x+1}$", ...
    'interpreter', 'latex');
xlabel("Key Values, -20 <= key <= 20");
ylabel("Relative Error, |observed - expected| / expected");
scatter(keys, oddRelativeErrs, 10, 'blue', 'filled');
hold off;