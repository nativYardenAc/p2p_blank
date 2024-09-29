function [SacDuringVSD,mainTimeMat,emVecs,sampleRate]=yr_sacDuringVSD_cortex(cortexFileRoot,calibrationFileRoot,monkeySessionMetaFile,trial2check)

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
session_name=getfield(monkeySessionMetaFile,'sessionName');

%%%%%end of definitions

[eyeX,eyeY,time_arr,event_arr,header]=yr_calibrateCortexData(cortexFileRoot,calibrationFileRoot); 
sampleRate=header(9,1);
% engbretThreshold=4;
% engbertMinDur=5;
% maxFrame=800; %maximum EM trace to save


%Build time matrix of main events in each trial for further filtering
switch monkeyName
    case 'frodo'
        [mainTimeMat,emptyTrials2remove]=yr_createTimeMatFrodo(header,event_arr,time_arr);
    case 'legolas'
        [mainTimeMat,emptyTrials2remove]=yr_createTimeMatLegolas(header,event_arr,time_arr);
    case 'gandalf'
        [mainTimeMat,emptyTrials2remove]=yr_createTimeMatGandalf(header,event_arr,time_arr);
end

%create 2 cell arrays with array for each trial- one for MS and one for
%saccades, only for correct trials between pre-cue and fixation point off.
%for each trial: col1- EM start, col2- EM end, col3- amplitude

EMmatSac={};
emVecsAllTrials={};
% rndTrials2check=find(cell2mat(mainTimeMatCorrect(1,2:end))==trial2check);
rndTrials2check=trial2check;

vsdOnset=cell2mat(mainTimeMat(4,trial2check+1))-cell2mat(mainTimeMat(2,trial2check+1));
startEManalysis=vsdOnset;
endEManalysis=vsdOnset+3000;
startEManalysis=floor(startEManalysis./sampleRate);
endEManalysis=floor(endEManalysis./sampleRate);
relEyeX=eyeX(startEManalysis:endEManalysis,trial2check);
relEyeY=eyeY(startEManalysis:endEManalysis,trial2check);
emVecs=[relEyeX relEyeY];
        
trialMetaFile.trial_id=mainTimeMat(1,trial2check+1);
trialMetaFile.timeOnset=vsdOnset./sampleRate;
trialMetaFile.fr27=mainTimeMat(5,trial2check+1);;
trialMetaFile.sampleRate=sampleRate;

timeSac=yr_detectSac(relEyeX,relEyeY,monkeySessionMetaFile,trialMetaFile);

%write in ms
EMmatSac=timeSac;
if ~isempty(timeSac)
    EMmatSac(:,1)=timeSac(:,1).*sampleRate+cell2mat(mainTimeMat(2,trial2check+1));
    EMmatSac(:,2)=timeSac(:,2).*sampleRate+cell2mat(mainTimeMat(2,trial2check+1));
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