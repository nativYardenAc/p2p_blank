function yr_saccadeInBlank()
close all;

% % % session_names={'boromir_011221a',...
% % % 'boromir_011221b',...
% % % 'boromir_011221c',...
% % % 'boromir_011221d',...
% % % 'boromir_011221e'};
% % % mlFileRoots={'D:\Yarden\yarden matlab files\raw_data\boromir right\01Dec2021_vsdi\data+ML\a\ML\211201_Boromir_cond_2AFC_stage4_LocJitter4VSD.bhv2',...
% % % 'D:\Yarden\yarden matlab files\raw_data\boromir right\01Dec2021_vsdi\data+ML\b\ML\211201_Boromir_cond_2AFC_PsychCurve4VSD_01Dec_b.bhv2',...
% % % 'D:\Yarden\yarden matlab files\raw_data\boromir right\01Dec2021_vsdi\data+ML\c\ML\211201_Boromir_cond_2AFC_PsychCurve4VSD_01Dec_c.bhv2',...
% % % 'D:\Yarden\yarden matlab files\raw_data\boromir right\01Dec2021_vsdi\data+ML\d\ML\211201_Boromir_cond_2AFC_PsychCurve4VSD_01Dec_d.bhv2',...
% % % 'D:\Yarden\yarden matlab files\raw_data\boromir right\01Dec2021_vsdi\data+ML\e\ML\211201_Boromir_cond_2AFC_PsychCurve4VSD_01Dec_e.bhv2'};
% % % 
% % % session_conds={[2,3,4],...
% % % [2],...
% % % [2],...
% % % [2],...
% % % [2]};

%legolas 111108
session_names={'legolas_111108c',...
'legolas_111108d',...
'legolas_111108h'};

cortexFileRoots={'D:\Yarden\yarden matlab files\raw_data\legolas right\leg_2008_11_11\behavior\leg_2008_11_11_c.1',...
'D:\Yarden\yarden matlab files\raw_data\legolas right\leg_2008_11_11\behavior\leg_2008_11_11_d.1',...
'D:\Yarden\yarden matlab files\raw_data\legolas right\leg_2008_11_11\behavior\leg_2008_11_11_h.1'};

calibrationFileRoots={'D:\Yarden\yarden matlab files\raw_data\legolas right\leg_2008_11_11\behavior\leg_2008_11_11_cal.1',...
'D:\Yarden\yarden matlab files\raw_data\legolas right\leg_2008_11_11\behavior\leg_2008_11_11_cal.1',...
'D:\Yarden\yarden matlab files\raw_data\legolas right\leg_2008_11_11\behavior\leg_2008_11_11_cal.1'};

session_conds={[1,2],...
    [1,2],...
    [1,2]};


% % % %legolas 181108
% % % session_names={'legolas_181108c',...
% % % 'legolas_181108d',...
% % % 'legolas_181108e'};
% % % 
% % % cortexFileRoots={'D:\Yarden\yarden matlab files\raw_data\legolas right\leg_2008_11_18\behavior\leg_2008_11_18_c.1',...
% % % 'D:\Yarden\yarden matlab files\raw_data\legolas right\leg_2008_11_18\behavior\leg_2008_11_18_d.1',...
% % % 'D:\Yarden\yarden matlab files\raw_data\legolas right\leg_2008_11_18\behavior\leg_2008_11_18_e.1'};
% % % 
% % % calibrationFileRoots={'D:\Yarden\yarden matlab files\raw_data\legolas right\leg_2008_11_18\behavior\leg_2008_11_18_cal.1',...
% % % 'D:\Yarden\yarden matlab files\raw_data\legolas right\leg_2008_11_18\behavior\leg_2008_11_18_cal.1',...
% % % 'D:\Yarden\yarden matlab files\raw_data\legolas right\leg_2008_11_18\behavior\leg_2008_11_18_cal.1'};
% % % 
% % % session_conds={[3],...
% % %     [3],...
% % %     [3],...
% % %     [3]};
% % % 
% % % %legolas 251108
% % % session_names={'legolas_251108d',...
% % % 'legolas_251108e',...
% % % 'legolas_251108f',...
% % % 'legolas_251108g'};
% % % 
% % % cortexFileRoots={'D:\Yarden\yarden matlab files\raw_data\legolas right\leg_2008_11_25\behavior\leg_2008_11_25_d.1',...
% % % 'D:\Yarden\yarden matlab files\raw_data\legolas right\leg_2008_11_25\behavior\leg_2008_11_25_e.1',...
% % % 'D:\Yarden\yarden matlab files\raw_data\legolas right\leg_2008_11_25\behavior\leg_2008_11_25_f.1',...
% % % 'D:\Yarden\yarden matlab files\raw_data\legolas right\leg_2008_11_25\behavior\leg_2008_11_25_g.1'};
% % % 
% % % calibrationFileRoots={'D:\Yarden\yarden matlab files\raw_data\legolas right\leg_2008_11_25\behavior\leg_2008_11_25_cal.1',...
% % % 'D:\Yarden\yarden matlab files\raw_data\legolas right\leg_2008_11_25\behavior\leg_2008_11_25_cal.1',...
% % % 'D:\Yarden\yarden matlab files\raw_data\legolas right\leg_2008_11_25\behavior\leg_2008_11_25_cal.1',...
% % % 'D:\Yarden\yarden matlab files\raw_data\legolas right\leg_2008_11_25\behavior\leg_2008_11_25_cal.1'};

% % % session_conds={[3],...
% % %     [3],...
% % %     [3],...
% % %     [3]};

sacAmpRange=[1 15];
viewPlots=1;
%%%%%end of definitions

sacMatsUnited={{'original session'},{'ML trial'},{['condsXUnited trial num']},{'sac onset frame'},{'sac offset frame'},{'sac amp'},{'sac direction'},{'sac velocity'},{'emX'},{'emY'}};
syncMatUnited={{'ML trial'},{'RSD file name'}, {'mat file name'}, {['condsXUnited trial num']}};
condVSD_dataUnited=double.empty(10000,256,0);
prevLastVSDTrial=0;
unitedEMData=[];
for session_id=1:size(session_names,2)
    session_name=session_names{session_id};
    disp(['running session ' session_name]);
    if contains(session_name,'boromir')
        mlFileRoot=mlFileRoots{session_id};
    else
        cortexFileRoot=cortexFileRoots{session_id};
        calibrationFileRoot=calibrationFileRoots{session_id};
    end
        
    vsdfileRoot=['D:\Yarden\yarden matlab files\analysis_data\preprocessed_VSDdata' filesep session_name];
    synchronyFilePath=['D:\Yarden\yarden matlab files\analysis_data\cortex-cam synched lists' filesep session_name '.xlsx'];
    cd(vsdfileRoot)    
    load pix_to_remove;
    load noisyPixels;
    cond_numbers=session_conds{session_id};
    for cond_num=cond_numbers
        % eval(['load condsAn ',condName,';']);
        if contains(session_name,'boromir')
            condName=['condsX' int2str(cond_num)];
            eval(['load condsX ',condName,';']);
        elseif contains(session_name,'legolas')
            condName=['condsXn' int2str(cond_num)];
            eval(['load condsXn ',condName,';']);
        end
        eval(['condVSD_data=',condName,';']);
        condVSD_dataUnited=cat(3,condVSD_dataUnited,condVSD_data);
        if contains(session_name,'boromir')
            syncMat=yr_autoSyncML2MatFiles(synchronyFilePath,vsdfileRoot,cond_num);
            %         vsdfileRootNoisy=[vsdfileRoot filesep 'noisyfiles'];
            %         syncMat_noisy=yr_autoSyncML2MatFiles(synchronyFilePath,vsdfileRootNoisy,cond_num);
            %         syncMat=[syncMat; syncMat_noisy(2:end,:)];
            %         [~,sortIdx]=sort(cell2mat(syncMat(2:end,4)));
            %         syncMat=syncMat(sortIdx+1,:);
            firstSyncId=2;
        else
            syncMat=yr_autoSyncCortex2MatFiles(synchronyFilePath,vsdfileRoot,cond_num);
            firstSyncId=1;
        end    
        relVSDTrials=cell2mat(syncMat(firstSyncId:end,4))+prevLastVSDTrial;
        syncMat2add=syncMat;
        syncMat2add(firstSyncId:end,4)=num2cell(relVSDTrials);
        syncMatUnited=[syncMatUnited; syncMat2add(2:end,:)];
        relCortexTrials=cell2mat(syncMat(2:end,1));

        if contains(session_name,'boromir')
            monkeySessionMetaFile.monkeyName='boromir';
            monkeySessionMetaFile.sessionName=session_name;
            monkeySessionMetaFile.engbretThreshold=7;
            monkeySessionMetaFile.engbertMinDur=7;
            monkeySessionMetaFile.minAmpThreshold=1;
        elseif contains(session_name,'legolas')
            monkeySessionMetaFile.monkeyName='legolas';
            monkeySessionMetaFile.sessionName=session_name;
            monkeySessionMetaFile.engbretThreshold=6;
            monkeySessionMetaFile.engbertMinDur=8;
            monkeySessionMetaFile.minAmpThreshold=1;
        end
        %make mat with all frames of beginning of ms-synching time and frames to allow onset

        sacMats={{'original session'},{'ML trial'},{['condsXn' num2str(cond_num) ' trial num']},{'ms onset frame'},{'ms offset frame'},{'ms amp'},{'ms direction'},{'ms velocity'},{'emX'},{'emY'}};
        sacRow=2;
        for mlRelId=1:size(relCortexTrials)
            if contains(session_name,'boromir')
                ml_id=relCortexTrials(mlRelId);
                [SacDuringVSD,mainTimeMat,emVecs]=yr_sacDuringVSD_ml(mlFileRoot,monkeySessionMetaFile,ml_id);
                minChoiceSacAmp=6;
                minChoiceFrame=140;
                sampleRate=1;
            elseif contains(session_name,'legolas')
                cortex_id=relCortexTrials(mlRelId);
                [SacDuringVSD,mainTimeMat,emVecs,sampleRate]=yr_sacDuringVSD_cortex(cortexFileRoot,calibrationFileRoot,monkeySessionMetaFile,cortex_id);
                minChoiceSacAmp=5; %double check
                minChoiceFrame=130;
                ml_id=cortex_id;
            end

            %take only choice saccades- larger than 6 degrees, and the
            %first one after frame 150 (lights shut off 400 ms after
            %fixation on choice)
            vsdOnset=cell2mat(mainTimeMat(4,ml_id+1));
            if ~isempty(SacDuringVSD)
                sacAmps=SacDuringVSD(:,3);
                bigSacs=SacDuringVSD(find(sacAmps>minChoiceSacAmp),:);
                sacOnsets=floor((bigSacs(:,1)-vsdOnset)./10);
                choiceSacIdices=find(sacOnsets>minChoiceFrame);
                if ~isempty(choiceSacIdices)
                    choiceSac=bigSacs(choiceSacIdices(1),:);
                else
                    choiceSac=[];
                end
            end

            if ~isempty(choiceSac)
                sacMats(sacRow,1)={session_name};
                sacMats(sacRow,2)=syncMat(mlRelId+1,1);
                sacMats(sacRow,3)=syncMat2add(mlRelId+1,4);
                sacMats(sacRow,4)={floor((choiceSac(1)-vsdOnset)./10)};
                sacMats(sacRow,5)={floor((choiceSac(2)-vsdOnset)./10)};
                sacMats(sacRow,6)={choiceSac(3)};
                sacMats(sacRow,7)={choiceSac(4)};
                sacMats(sacRow,8)={choiceSac(5)};
                sacOnsetEmVecIndex=(choiceSac(1)-vsdOnset)./sampleRate;
                sacMats(sacRow,9)={emVecs(floor((sacOnsetEmVecIndex-250)./sampleRate):floor((sacOnsetEmVecIndex+440)./sampleRate),1)};
                sacMats(sacRow,10)={emVecs(floor((sacOnsetEmVecIndex-250)./sampleRate):floor((sacOnsetEmVecIndex+440)./sampleRate),2)};
                sacRow=sacRow+1;
            end 
        end
        sacMatsUnited=[sacMatsUnited; sacMats(2:end,:)];
        prevLastVSDTrial=prevLastVSDTrial+size(condVSD_data,3);
    end
end

sacMats=sacMatsUnited;
syncMat=syncMatUnited;
condVSD_data=condVSD_dataUnited;

amps=cell2mat(sacMats(2:end,6));
idx2Save=find(amps>min(sacAmpRange));
idx4sacMats=[1; idx2Save+1];
sacMats=sacMats(idx4sacMats,:);

amps=cell2mat(sacMats(2:end,6));
idx2Save=find(amps<max(sacAmpRange));
idx4sacMats=[1; idx2Save+1];
sacMats=sacMats(idx4sacMats,:);

sacOnsets=cell2mat(sacMats(2:end,4));
idx2Save=find(sacOnsets<180);
idx4sacMats=[1; idx2Save+1];
sacMats=sacMats(idx4sacMats,:);

relVSDTrials=cell2mat(syncMat(2:end,4));

if contains(session_name,'boromir')
    blankAN=condVSD_data;
    for relTrialIdx = 1:size(relVSDTrials,1)
        cleanBlankWithoutTrial=blankAN;
        cleanBlankWithoutTrial(:,:,relTrialIdx)=[];
        blankMeanWithoutTrial=nanmean(cleanBlankWithoutTrial,3);
        trial_id=relVSDTrials(relTrialIdx);
        dataRelTrials(:,:,trial_id) = condVSD_data(:,:,trial_id)./blankMeanWithoutTrial;
        %     figure; plotspconds(dataRelTrials(:,2:150,trial_id)-1,100,100,10);
    end
elseif contains(session_name,'legolas')
    for relTrialIdx = 1:size(relVSDTrials,1)
        trial_id=relVSDTrials(relTrialIdx);
        dataRelTrials(:,:,trial_id) = condVSD_data(:,:,trial_id);
    end
end

%allign all data to ms onset
for sac_id=1:size(sacMats,1)-1
    trial_id=cell2mat(sacMats(sac_id+1,3));
    sacOnset=cell2mat(sacMats(sac_id+1,4));
    frames=[sacOnset-15:sacOnset+24];
    dataBySac(:,:,sac_id) = dataRelTrials(:,frames,trial_id);
    emDataX(:,sac_id)=cell2mat(sacMats(sac_id+1,9));
    emDataY(:,sac_id)=cell2mat(sacMats(sac_id+1,10));
end

dataBySac_no_BV=dataBySac;
dataBySac_no_BV(find(chamberpix),:,:)=nan;
dataBySac_no_BV(find(bloodpix),:,:)=nan;

if (viewPlots)
    low=-0.0005;
    high=0.0005;
    titleStr='All data aligned by sac Onset';

    figure; mimg2(nanmean(dataBySac_no_BV,3)-1,100,100,low,high,[-15:24],3); colormap(mapgeog); suptitle(titleStr);
    figure; plotspconds(nanmean(dataBySac,3)-1,100,100,10);
    set(gcf,'name',titleStr,'numbertitle','off');
%     framesAxis=[-15:0.1:34];
    numOfBins=round(size(dataBySac,3)./7);
    for bin_id=1:numOfBins
        firstSac=7*(bin_id-1)+1;
        if bin_id==numOfBins
            lastMS=size(dataBySac,3);
        else
            lastMS=7*bin_id;
        end
        figure;
        framesAxis=[-25:0.1:44];
        for ms_id=firstSac:lastMS
            subplot(2,1,1);
            plot(framesAxis,emDataX(:,ms_id)); hold on;
            xlim([framesAxis(1) framesAxis(end)]);
            xlabel('frames');
            title('eyeX');
            
            subplot(2,1,2);
            plot(framesAxis,emDataY(:,ms_id)); hold on;
            xlim([framesAxis(1) framesAxis(end)]);
            xlabel('frames');
            title('eyeY');
        end
        suptitle(['MSs between ' num2str(firstSac) '-' num2str(lastMS)]);
    end
    figure;
    amps=cell2mat(sacMats(2:end,6)); 
    hist(amps);
    title('Sac amplitudes');
    
    figure;
    sacOnsets=cell2mat(sacMats(2:end,4)); 
    hist(sacOnsets);
    title('Sac frame onsets');
    
    sessionDataToTC=nanmean(nanmean(dataBySac_no_BV,1),3);
    %     sessionDataToTC=sessionDataToTC-nanmean(sessionDataToTC(1:10));
    timeAxis=([1:size(dataBySac_no_BV,2)]-15).*10;
    sessionDataToSEMacrossMS = nanmean(dataBySac_no_BV,1);
    semErrorBarAcrossMs = [];
    for frame_id=1:size(timeAxis,2)
        meanPixelAcrossMsVec=squeeze(sessionDataToSEMacrossMS(:,frame_id,:));
        semAcrossMs = nanstd(meanPixelAcrossMsVec)./sqrt(size(meanPixelAcrossMsVec,1)-1);
        semErrorBarAcrossMs = [semErrorBarAcrossMs semAcrossMs];
    end
    figure; shadedErrorBar(timeAxis,sessionDataToTC-1,semErrorBarAcrossMs,'k');
end

a=1;
