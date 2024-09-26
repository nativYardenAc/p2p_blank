function [SacDuringVSD,mainTimeMat,emVecs]=yr_sacDuringVSD_ml(mlFileRoot,monkeySessionMetaFile,trial2check)

%the function calculates microsaccades times and amplitude during VSD recording
%input:  1. mlFileRoot- root of monkey logic data during session
%        2. monkeySessionMetaFile- monkey data including name, session and
%        all the relevant parameters for MS detection
%        3. trial2check- the cortex trial number to show figures of
%output: 1. mainTimeMatCorrect- cell array with details for main time
%           courses in each trial. only correct trials will appear.
%        2. MSduringVSD- cell matrix, each cell is a correct trial and in
%           the cell array will appear a double array- col1- MS start, 
%           col2- MS end, col3- amplitude, col4- direction, col5- max velocity
%notes: one can add manually trials with errors to remove (for example
%       because of trial buffer problem). the function also displays at the
%       workspace suspected problematic trials that their times are not
%       reasonable.
%
%date of last update: 10/12/2023
%update by: Yarden Nativ


monkeyName=getfield(monkeySessionMetaFile,'monkeyName');

%%%%%end of definitions

monkeyLogicData = mlread(mlFileRoot);
sampleRate=1;
analogData=[monkeyLogicData.AnalogData];
errors=[monkeyLogicData.TrialError];
behavior=[monkeyLogicData.BehavioralCodes];
conds=[monkeyLogicData.Condition];
blank_cond=1;
% engbretThreshold=4;
% engbertMinDur=5;
% maxFrame=800; %maximum EM trace to save


%Build time matrix of main events in each trial for further filtering
[mainTimeMat,emptyTrials2remove]=yr_createTimeMatBoromir(analogData, errors,behavior, conds, blank_cond);

%filter trials only to correct trials
manualErrorTrials=[]; %you can add manually trials with problem
manualErrorTrials=emptyTrials2remove;
correctTrialsIdces=find(errors==0);
for errorTrial=manualErrorTrials;
    correctTrialsIdces(find(correctTrialsIdces==errorTrial))=[];
end

%create 2 cell arrays with array for each trial- one for MS and one for
%saccades, only for correct trials between pre-cue and fixation point off.
%for each trial: col1- EM start, col2- EM end, col3- amplitude

EMmatSac={};
emVecsAllTrials={};
% rndTrials2check=find(cell2mat(mainTimeMatCorrect(1,2:end))==trial2check);
rndTrials2check=trial2check;

vsdOnset=cell2mat(mainTimeMat(4,trial2check+1));
startEManalysis=vsdOnset;
endEManalysis=vsdOnset+3000;
startEManalysis=floor(startEManalysis./sampleRate);
endEManalysis=floor(endEManalysis./sampleRate);
eyeData=analogData(trial2check).Eye;
relEyeX=eyeData(startEManalysis:endEManalysis,1);
relEyeY=eyeData(startEManalysis:endEManalysis,2);
emVecs=[relEyeX relEyeY];
        
trialMetaFile.trial_id=mainTimeMat(1,trial2check+1);
trialMetaFile.timeOnset=vsdOnset./sampleRate;
trialMetaFile.fr27=mainTimeMat(5,trial2check+1);;
trialMetaFile.sampleRate=sampleRate;

timeSac=yr_detectSac(relEyeX,relEyeY,monkeySessionMetaFile,trialMetaFile);

%write in ms
EMmatSac=timeSac;
if ~isempty(timeSac)
    EMmatSac(:,1)=timeSac(:,1).*sampleRate;
    EMmatSac(:,2)=timeSac(:,2).*sampleRate;
end

%filter microsaccades only to those during VSD recording
SacDuringVSD={};
if ~isempty(EMmatSac)
    allEMs=EMmatSac;
    relEMs=find(allEMs(:,3)>monkeySessionMetaFile.minAmpThreshold);
    allEMs=allEMs(relEMs,:);
    rowIdces=find(allEMs(:,1)>(vsdOnset));
    SacDuringVSD=EMmatSac(rowIdces,:);
end

a=1;