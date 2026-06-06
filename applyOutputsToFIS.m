function fis = applyOutputsToFIS(outputMatrix)
    fis = readfis("initialBaseFIS.fis");  

    for i = 1:49
        for j = 1:3
            mfIndex = outputMatrix(i, j) + 1;
            mfIndex = max(min(mfIndex, length(fis.Outputs(j).MembershipFunctions)), 1);

            fis.Rules(i).Consequent(j) = mfIndex;
        end
    end
end
