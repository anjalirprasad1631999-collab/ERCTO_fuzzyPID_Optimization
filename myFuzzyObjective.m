function cost = myFuzzyObjective(X)
    X = floor(X);
    X = max(min(X, 6), 0);
    ruleOutputs = reshape(X, [3, 49])';
    fis = applyOutputsToFIS(ruleOutputs);         
    writefis(fis, 'optimizedFIS.fis');              
    assignin('base', 'optimizedFIS', fis);        
    out = sim("FuzzyPID.slx", 'ReturnWorkspaceOutputs', 'on');
    errorSignal = out.logsout.get('error').Values.Data;
    time = out.logsout.get('error').Values.Time;

    cost = trapz(time, time .* abs(errorSignal)); 
end
