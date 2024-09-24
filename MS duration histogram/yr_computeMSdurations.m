function yr_computeMSdurations()

% monkey='Legolas';
monkey='Gandalf';

%load msMats of all MSs in the paper
folder='D:\Yarden\yarden matlab files\analysis_data\blankPaperData';
load([folder filesep monkey filesep monkey 'AllMSs.mat']);

msDurations=nan(size(msMats,1)-1,1);
for ms_id=1:(size(msMats,1)-1)
    session_name=cell2mat(msMats(ms_id+1,1));
    [cortexFileRoot,calibrationFileRoot]=yr_cortexFileRoot(session_name);
    msOnsetFr=cell2mat(msMats(ms_id+1,4));
    cortex_id=cell2mat(msMats(ms_id+1,2));
    if contains(session_name,'legolas')
        monkeySessionMetaFile.monkeyName='legolas';
        monkeySessionMetaFile.sessionName=session_name;
        monkeySessionMetaFile.engbretThreshold=6;
        monkeySessionMetaFile.engbertMinDur=12;
        monkeySessionMetaFile.rejectGlitch=0;
        monkeySessionMetaFile.rejectInconsistent=0;
        monkeySessionMetaFile.followersMethod='reject';
        monkeySessionMetaFile.smoothEM=25;
        monkeySessionMetaFile.fineTuning='accBaseline';
        monkeySessionMetaFile.accThresholdBegin=1;
        monkeySessionMetaFile.accThresholdEnd=1;
        monkeySessionMetaFile.velThreshold=8;
        monkeySessionMetaFile.ampMethod='max';
        monkeySessionMetaFile.angleMethod='final';
        monkeySessionMetaFile.msAmpThreshold=1;
        monkeySessionMetaFile.maxFrame=130;
        [MSduringVSD,mainTimeMat]=yr_msDuringVSD_short(cortexFileRoot,calibrationFileRoot,monkeySessionMetaFile,cortex_id);
    elseif contains(session_name,'gandalf')
        monkeySessionMetaFile.monkeyName='gandalf';
        monkeySessionMetaFile.sessionName=session_name;
        monkeySessionMetaFile.engbretThreshold=6;
        monkeySessionMetaFile.engbertMinDur=12;
        monkeySessionMetaFile.rejectGlitch=0;
        monkeySessionMetaFile.rejectInconsistent=0;
        monkeySessionMetaFile.followersMethod='firstMS';
        monkeySessionMetaFile.smoothEM=25;
        monkeySessionMetaFile.fineTuning='accBaseline';
        monkeySessionMetaFile.accThresholdBegin=2;
        monkeySessionMetaFile.accThresholdEnd=2;
        monkeySessionMetaFile.velThreshold=3;
        monkeySessionMetaFile.ampMethod='max';
        monkeySessionMetaFile.angleMethod='final';
        monkeySessionMetaFile.msAmpThreshold=1;
        monkeySessionMetaFile.maxFrame=130;
        [MSduringVSD,mainTimeMat]=yr_msDuringVSD_short(cortexFileRoot,calibrationFileRoot,monkeySessionMetaFile,cortex_id);
    end
    trialMs=MSduringVSD{cortex_id,1};
    vsdOnset=cell2mat(mainTimeMat(4,cortex_id+1));
    msFrOnsets=floor((trialMs(:,1)-vsdOnset)./10);
    msInTrial_id=find(msFrOnsets==msOnsetFr);
    if ~isempty(msInTrial_id)
        msDur=trialMs(msInTrial_id,2)-trialMs(msInTrial_id,1);
        msDur=trialMs(msInTrial_id,6);
    else
        msDur=(cell2mat(msMats(ms_id+1,5))-cell2mat(msMats(ms_id+1,4)))*10;
    end
    msDurations(ms_id)=msDur;
end

figure; histogram(msDurations,8,'Normalization','probability');
title([monkey ' MS durations']);
xlabel('duration (ms)');
ylabel('probability');

a=1;
