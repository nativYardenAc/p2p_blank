function yr_saccadeInBlank()

session_names={'boromir_011221a',...
'boromir_011221b',...
'boromir_011221c',...
'boromir_011221d',...
'boromir_011221e'};
mlFileRoots={'D:\Yarden\yarden matlab files\raw_data\boromir right\01Dec2021_vsdi\data+ML\a\ML\211201_Boromir_cond_2AFC_stage4_LocJitter4VSD.bhv2',...
'D:\Yarden\yarden matlab files\raw_data\boromir right\01Dec2021_vsdi\data+ML\b\ML\211201_Boromir_cond_2AFC_PsychCurve4VSD_01Dec_b.bhv2',...
'D:\Yarden\yarden matlab files\raw_data\boromir right\01Dec2021_vsdi\data+ML\c\ML\211201_Boromir_cond_2AFC_PsychCurve4VSD_01Dec_c.bhv2',...
'D:\Yarden\yarden matlab files\raw_data\boromir right\01Dec2021_vsdi\data+ML\d\ML\211201_Boromir_cond_2AFC_PsychCurve4VSD_01Dec_d.bhv2',...
'D:\Yarden\yarden matlab files\raw_data\boromir right\01Dec2021_vsdi\data+ML\e\ML\211201_Boromir_cond_2AFC_PsychCurve4VSD_01Dec_e.bhv2'};
% cortexFileRoot='E:\Yarden\yarden matlab files\raw_data\gandalf left\2018July10\Cortex\gan_2018July10_a.1';
% calibrationFileRoot='E:\Yarden\yarden matlab files\raw_data\gandalf left\2018July10\Cortex\gan_2018July10_caleye.1';

session_conds={[2,3,4],...
[2],...
[2],...
[2],...
[2]};

%%%%%end of definitions

sacMatsUnited={{'original session'},{'ML trial'},{['condsXUnited trial num']},{'sac onset frame'},{'sac offset frame'},{'sac amp'},{'sac direction'},{'sac velocity'},{'emX'},{'emY'}};
syncMatUnited={{'ML trial'},{'RSD file name'}, {'mat file name'}, {['condsXUnited trial num']}};
condVSD_dataUnited=double.empty(10000,256,0);
prevLastVSDTrial=0;
unitedEMData=[];
for session_id=1:size(session_names,2)
    session_name=session_names{session_id};
    disp(['running session ' session_name]);
    mlFileRoot=mlFileRoots{session_id};
    vsdfileRoot=['D:\Yarden\yarden matlab files\analysis_data\preprocessed_VSDdata' filesep session_name];
    synchronyFilePath=['D:\Yarden\yarden matlab files\analysis_data\cortex-cam synched lists' filesep session_name '.xlsx'];
    cd(vsdfileRoot)    
    load pix_to_remove;
    load noisyPixels;
    cond_numbers=session_conds{session_id};
    for cond_num=cond_numbers
%         condName=['condsXn' int2str(cond_num)];
        condName=['condsX' int2str(cond_num)];
        % eval(['load condsAn ',condName,';']);
%         eval(['load condsXn ',condName,';']);
        eval(['load condsX ',condName,';']);
        eval(['condVSD_data=',condName,';']);
        condVSD_dataUnited=cat(3,condVSD_dataUnited,condVSD_data);
        syncMat=yr_autoSyncML2MatFiles(synchronyFilePath,vsdfileRoot,cond_num);
        relVSDTrials=cell2mat(syncMat(2:end,4))+prevLastVSDTrial;    
        syncMat2add=syncMat;
        syncMat2add(2:end,4)=num2cell(relVSDTrials);
        syncMatUnited=[syncMatUnited; syncMat2add(2:end,:)];
        relCortexTrials=cell2mat(syncMat(2:end,1));
        
        monkeyLogicData = mlread(mlFileRoot);
        analogData=[monkeyLogicData.AnalogData];

        if contains(session_name,'boromir')
            monkeySessionMetaFile.monkeyName='boromir';
            monkeySessionMetaFile.sessionName=session_name;
            monkeySessionMetaFile.engbretThreshold=6;
            monkeySessionMetaFile.engbertMinDur=7;
            monkeySessionMetaFile.minAmpThreshold=1;
        elseif contains(session_name,'legolas')
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
            elseif contains(session_name,'legolas')

                minChoiceSacAmp=6; %double check
                minChoiceFrame=130;
            end

            %take only choice saccades- larger than 6 degrees, and the
            %first one after frame 150 (lights shut off 400 ms after
            %fixation on choice)
            vsdOnset=cell2mat(mainTimeMat(4,ml_id+1));
            sacAmps=SacDuringVSD(:,3);
            bigSacs=SacDuringVSD(find(sacAmps>minChoiceSacAmp),:);
            sacOnsets=floor((bigSacs(:,1)-vsdOnset)./10);
            choiceSacIdices=find(sacOnsets>minChoiceFrame);
            choiceSac=bigSacs(choiceSacIdices(1),:);

            if ~isempty(choiceSac)
                sacMats(sacRow,1)={session_name};
                sacMats(sacRow,2)=syncMat(mlRelId+1,1);
                sacMats(sacRow,3)=syncMat2add(mlRelId+1,4);
                sacMats(sacRow,4)={floor((choiceSac(1)-vsdOnset)./10)};
                sacMats(sacRow,5)={floor((choiceSac(2)-vsdOnset)./10)};
                sacMats(sacRow,6)={choiceSac(3)};
                sacMats(sacRow,7)={choiceSac(4)};
                sacMats(sacRow,8)={choiceSac(5)};
                sacOnsetEmVecIndex=(choiceSac(1)-vsdOnset);
                sacMats(sacRow,9)={emVecs(sacOnsetEmVecIndex-250:sacOnsetEmVecIndex+440,1)};
                sacMats(sacRow,10)={emVecs(sacOnsetEmVecIndex-250:sacOnsetEmVecIndex+440,2)};
                sacRow=sacRow+1;
            end 
        end
    end
    sacMatsUnited=[sacMatsUnited; sacMats(2:end,:)];
    prevLastVSDTrial=prevLastVSDTrial+size(condVSD_data,3);
end

sacMats=sacMatsUnited;
syncMat=syncMatUnited;
condVSD_data=condVSD_dataUnited;

relVSDTrials=cell2mat(syncMat(2:end,4));

blankAN=condVSD_data;
for relTrialIdx = 1:size(relVSDTrials,1)
    cleanBlankWithoutTrial=blankAN;
    cleanBlankWithoutTrial(:,:,relTrialIdx)=[];
    blankMeanWithoutTrial=nanmean(cleanBlankWithoutTrial,3);
    trial_id=relVSDTrials(relTrialIdx);
    dataRelTrials(:,:,trial_id) = condVSD_data(:,:,trial_id)./blankMeanWithoutTrial;
%     figure; plotspconds(dataRelTrials(:,2:150,trial_id)-1,100,100,10);
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
    titleStr='All data aligned by ms Onset';

    figure; mimg2(nanmean(dataBySac_no_BV,3)-1,100,100,low,high,[-15:24],3); colormap(mapgeog); suptitle(titleStr);
    figure; plotspconds(nanmean(dataBySac,3)-1,100,100,10);
    set(gcf,'name',titleStr,'numbertitle','off');
%     framesAxis=[-15:0.1:34];
    numOfBins=round(size(dataBySac,3)./7);
    for bin_id=1:numOfBins
        firstSac=7*(bin_id-1)+1;
        if bin_id==numOfBins
            lastMS=size(dataByMs,3);
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
