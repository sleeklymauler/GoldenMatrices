% author: Luke Sellmayer

% measuring time it takes for golden encryption and decryption to run

% requires: goldenEncrypt.m, goldenDecrypt.m

numTrials = 100;

% set seed of random generator
rng('shuffle');

% vector of timing values for each random plaintext matrix and key
encryptTimings = zeros(numTrials, 1);
decryptTimings = zeros(numTrials, 1);

for i = 1 : numTrials
    % create random 2 x 2 message matrix of integers
    plaintext = randi([-100, 100], 2, 2);

    % create random key value between -17 and 17
    a = -17;
    b = 17;
    key = (b - a) * rand(1) + a;

    % run once but don't time so we can get the encrypted matrices in order
    % to time the decryption function
    [evenEncrypt, oddEncrypt] = goldenEncrypt(plaintext, key);
    
    % measure time to encrypt
    f = @() goldenEncrypt(plaintext, key);
    encryptTimings(i) = timeit(f);

    % measure time to decrypt
    g = @() goldenDecrypt(evenEncrypt, oddEncrypt, key);
    decryptTimings(i, 1) = timeit(g);
end

% plot times in box plot
hold on;
figure();
boxplot(encryptTimings, 'orientation', 'horizontal');
xlabel("Time to Run (s)")
title("Time to Encrypt Matrix");
hold off;

hold on;
figure();
boxplot(decryptTimings, 'orientation', 'horizontal');
title("Time to Decrypt Matrix");
xlabel("Time to Run (s)")
hold off;



