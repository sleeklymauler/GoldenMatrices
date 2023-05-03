% author: Luke Sellmayer

% requires: goldenEncrypt.m, goldenDecrypt.m

% finds the secret key for golden matrix encryption by repeatedly guessing 
% values for it
%
% inputs: realKey, the key used to encrypt the matrices; plaintext, the
% matrix being encrypted; tolerance, how close the values of the guessed
% decrypted matrix should be to the plaintext matrix; lower, lower bound on
% key values; upper, upper bound on key values
%
% outputs: guessedKey, key that correctly decrypts cipher matrix into
% plaintext matrix
function guessedKey = bruteForce(realKey, plaintext, tolerance, lower, ...
    upper)

    pause(0.2);

    % set seed of random generator
    rng('shuffle');
     
    % encrypting
    [evenEncrypt, oddEncrypt] = goldenEncrypt(plaintext, realKey);
    
    % found a key yet?
    found = false;

    % how many times we guessed until we found the key
    guessCount = 0;
    
    % keep guessing until we find one
    while ~found
        % guess a random key between lower and upper
        guessedKey = (upper - lower) * rand(1) + lower;
    
        % decrypt using that key
        [evenDecrypt, oddDecrypt] = goldenDecrypt(evenEncrypt, ...
            oddEncrypt, guessedKey);

        guessCount = guessCount + 1;
    
        % check if evenDecrypt matches
        if abs(plaintext(1, 1) - evenDecrypt(1, 1)) <= tolerance && ...
            abs(plaintext(1, 2) - evenDecrypt(1, 2)) <= tolerance && ...
            abs(plaintext(2, 1) - evenDecrypt(2, 1)) <= tolerance && ...
            abs(plaintext(2, 2) - evenDecrypt(2, 2)) <= tolerance
                disp("Guessed the key! Value: ");
                disp(guessedKey);
                disp("Plaintext matrix: ");
                disp(plaintext);
                disp("Decrypted matrix: ");
                disp(evenDecrypt);
                disp("Number of guesses: ");
                disp(guessCount);
                guessCount = 0;
                found = true;
        end
        % check if oddDecrypt matches
        if abs(plaintext(1, 1) - oddDecrypt(1, 1)) <= tolerance && ...
            abs(plaintext(1, 2) - oddDecrypt(1, 2)) <= tolerance && ...
            abs(plaintext(2, 1) - oddDecrypt(2, 1)) <= tolerance && ...
            abs(plaintext(2, 2) - oddDecrypt(2, 2)) <= tolerance
                disp("Guessed the key! Value: ");
                disp(guessedKey);
                disp("Plaintext matrix: ");
                disp(plaintext);
                disp("Decrypted matrix: ");
                disp(oddDecrypt);
                disp("Number of guesses: ");
                disp(guessCount);
                guessCount = 0;
                found = true;
        end
    end
end