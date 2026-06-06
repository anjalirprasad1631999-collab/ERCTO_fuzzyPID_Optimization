function cost = fitness_fun(X)

    % Discretize
    X = floor(X);
    X = max(min(X, 6), 0);

    % Convert to rule matrix
    ruleOutputs = reshape(X, [3,49])';

    % Apply to FIS
    fis = applyOutputsToFIS(ruleOutputs);

    % Send FIS to workspace
    assignin('base', 'optimizedFIS', fis);

    % Run Simulink
    out = sim("FuzzyPID.slx", 'ReturnWorkspaceOutputs', 'on');

    % Error signal
    errorSignal = out.logsout.get('error').Values.Data;
    time = out.logsout.get('error').Values.Time;

    % ITAE
    cost = trapz(time, time .* abs(errorSignal));

end
