function sacInTrial=yr_detectSac(vecX,vecY,monkeySessionMetaFile,trialMetaFile)
%%%OUTPUT:
%sacInTrial(1:num,1)=sac onset (milliseconds; clock of the behavior system)
%sacInTrial(1:num,2)=ms offset (milliseconds; clock of the behavior system)
%sacInTrial(1:num,3)=max amplitude
%sacInTrial(1:num,4)=angle (in degrees; final)
%sacInTrial(1:num,5)=max velocity
%sacInTrial(1:num,6)=duration to peak
%date of last update: 26/09/2024
%update by: Yarden Nativ

%definitions
sampleRate=trialMetaFile.sampleRate;
minAmpThreshold=monkeySessionMetaFile.minAmpThreshold;

vel=vecvel([vecX vecY],1000./sampleRate,2);
sacMat=microsacc([vecX vecY],vel,monkeySessionMetaFile.engbretThreshold,round(monkeySessionMetaFile.engbertMinDur./sampleRate));   

%delete irrelevant saccades
if ~isempty(sacMat)
    rows2delete=[];
    %minimal threshold
    for sac_id=1:size(sacMat,1)
        maxAmp=sqrt(sacMat(sac_id,6).^2+sacMat(sac_id,7).^2);
        if maxAmp<minAmpThreshold
            rows2delete=[rows2delete; sac_id];
        end
    end
    sacMat(rows2delete,:)=[];
end

sacInTrial=[];
for sac_id=1:size(sacMat,1)
    sacInTrial(sac_id,1:2)=[sacMat(sac_id,1)+trialMetaFile.timeOnset sacMat(sac_id,2)+trialMetaFile.timeOnset];
    sacInTrial(sac_id,3)=sqrt(sacMat(sac_id,6).^2+sacMat(sac_id,7).^2); %max amplitude

    firstLocationX=(vecX(sacMat(sac_id,1)));
    firstLocationY=(vecY(sacMat(sac_id,1)));
    endLocationX=(vecX(sacMat(sac_id,2)));
    endLocationY=(vecY(sacMat(sac_id,2)));
    if endLocationX-firstLocationX<0
        angle=atan((endLocationY-firstLocationY)./(endLocationX-firstLocationX))+3.14;
    else
        angle=atan((endLocationY-firstLocationY)./(endLocationX-firstLocationX));
    end

    sacInTrial(sac_id,4)=rad2deg(angle); %final direction
    sacInTrial(sac_id,5)=sacMat(sac_id,3); %peak velocity

    sacVecX=vecX(sacMat(sac_id,1):sacMat(sac_id,2));
    sacVecY=vecY(sacMat(sac_id,1):sacMat(sac_id,2));
    [maxX,maxXidx]=max(sacVecX);
    [minX,minXidx]=min(sacVecX);
    [maxY,maxYidx]=max(sacVecY);
    [minY,minYidx]=min(sacVecY);
    sacInTrial(sac_id,6)=min(max([maxXidx,minXidx]),max([maxYidx,minYidx])).*sampleRate; %duration to peak
end

a=1;