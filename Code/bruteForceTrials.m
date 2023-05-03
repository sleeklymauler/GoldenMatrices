% author: Luke Sellmayer

% requires: bruteForce.m

% measuring times it takes to bruteforce golden encryption

numTrials = 20;

% range for key values
lower = -17;
upper = 17;

% vector to store trials
bruteTimes = zeros(numTrials, 1);

% tolerance
tolerance = 0.01;

for i = 1 : numTrials
    
    % create random 2 x 2 message matrix of integers
    plaintext = randi([-100, 100], 2, 2);

    % create random key to encrypt
    trueKey = (upper - lower) * rand(1) + lower;

    disp("Trial number: ");
    disp(i);
    
    % measure time to brute force
    f = @() bruteForce(trueKey, plaintext, tolerance, lower, upper);
    bruteTimes(i) = timeit(f);
end

boxplot(bruteTimes, 'orientation', 'horizontal');
xlabel("Time to Brute Force x-key (s)");