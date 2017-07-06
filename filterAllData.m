load Data.mat
%% Very intensive takes a long time
sprintf('started filteringAllData')
%% Modified to smooth data first
smoothWindow = 5;
for i = 1:length(Data.cell)
    if (Data.cell(i).startTimeSample == -1)
        continue
    else
        Data.cell(i).patchSmooth = smooth(Data.cell(i).patch, smoothWindow);
        Data.cell(i).patchStd = std(Data.cell(i).patch);
        Data.cell(i).patchAvg = mean(Data.cell(i).patch);
        Data.cell(i).lpfStd = std(Data.cell(i).lpf);
        Data.cell(i).lpfAvg = mean(Data.cell(i).lpf);
        Data.cell(i).patchFilter = filterData(Data.cell(i).patchSmooth,Data.cell(i).fs);
        Data.cell(i).patchFilterStd = std(Data.cell(i).patchFilter);
        Data.cell(i).patchFilterAvg = mean(Data.cell(i).patchFilter);
    end
end
%% Saving takes time too
sprintf('finished filteringAllData')
clearvars -except Data
save Data.mat Data -v7.3
