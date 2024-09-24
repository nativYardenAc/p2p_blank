function yr_shuffleBlank2SaveMats_restricted()

%%%%variables to change
legolasOrGandalforBoromir=2; %boromir 2 legolas 1 and gandalf 0
if (legolasOrGandalforBoromir)==2
    blankDataRoot='D:\Yarden\yarden matlab files\analysis_data\blankPaperData\boromir';
    folder2save='D:\Yarden\yarden matlab files\analysis_data\blankPaperData\p2p_analyses\git\Restricted shuffle\restrictedShufflesMat\boromir';
elseif (legolasOrGandalforBoromir)==1
    blankDataRoot='D:\Yarden\yarden matlab files\analysis_data\blankPaperData\legolas';
    folder2save='D:\Yarden\yarden matlab files\analysis_data\blankPaperData\p2p_analyses\git\Restricted shuffle\restrictedShufflesMat\legolas';
else
    blankDataRoot='D:\Yarden\yarden matlab files\analysis_data\blankPaperData\gandalf';
    folder2save='D:\Yarden\yarden matlab files\analysis_data\blankPaperData\p2p_analyses\git\Restricted shuffle\restrictedShufflesMat\gandalf';
end
[sessionsMsMats,session_names]=yr_loadSavedMats4analysis(blankDataRoot,'msMats');

for session_id=1:size(session_names,2)
    session_name=cell2mat(session_names{session_id});
    disp(['running session ' session_name]);
    
    msMatsSession=sessionsMsMats{session_id};
    numOfMSs=size(msMatsSession,1)-1;
    numOfShuffles=ceil(1000/numOfMSs);
    sizeOfPartialMat=round(numOfMSs./3);
    shuffleMat=cell(size(msMatsSession,1),numOfShuffles+1);
    for partialMat_id=1:3
        if partialMat_id~=3
            indices2take=[(partialMat_id-1)*sizeOfPartialMat+1:partialMat_id*sizeOfPartialMat];
        else
            indices2take=[(partialMat_id-1)*sizeOfPartialMat+1:numOfMSs];
        end
        msMatTitle=msMatsSession(1,:);
        msMat2take=msMatsSession(indices2take+1,:);
        msMatsPartial=[msMatTitle; msMat2take];
        shuffleMatPartial=createShuffleMat(msMatsPartial,numOfShuffles);
        shuffleMat(1,:)=shuffleMatPartial(1,:);
        shuffleMat(indices2take(1)+1:indices2take(end)+1,:)=shuffleMatPartial(2:end,:);
    end
    cd(folder2save);
    name2save=[session_name '_shuffleMatRestricted.mat'];
    eval(['save ',name2save,' shuffleMat;']);
end

a=1;

function shuffleMat=createShuffleMat(msMats,numOfShuffles)
    tic;
    countMat=cell(size(msMats,1),2);
    countMat{1,1}={'original ms Onset'};
    countMat{1,2}={'count'};
    msOnset2Shuffle=cell2mat(msMats(2:end,4));
    numOfMs=size(msOnset2Shuffle,1);
    countMat(2:end,1)=num2cell(msOnset2Shuffle);
    for row_id=2:numOfMs
        countMat{row_id,2}=sum(msOnset2Shuffle==msOnset2Shuffle(row_id-1));
    end

%     numOfShuffles=ceil(1000/numOfMs);
    shuffleMat=cell(size(msMats,1),numOfShuffles+1);
    shuffleMat{1,1}=msMats{1,3};
    shuffleMat(2:end,1)=msMats(2:end,3);
    maxOfReptitionPerMs=ceil(numOfShuffles/(numOfMs-1));
    for shuffleNum=1:numOfShuffles
        shuffleMat{1,1+shuffleNum}={['shuffle ' num2str(shuffleNum)]};
        numOfReptitions=maxOfReptitionPerMs;
        loopNum=0;
        while numOfReptitions>=maxOfReptitionPerMs
            loopNum=loopNum+1;
            rng('shuffle');
            msOnsetShuffled=round(unifrnd(20,130,[1,length(msOnset2Shuffle)]));
            for shuffledMsId=1:numOfMs
                onsetShuffled=msOnsetShuffled(shuffledMsId);
                originalOnset=msOnset2Shuffle(shuffledMsId);
                originalOnsetVec=[(originalOnset-3):(originalOnset+3)];
                countIdx=find(msOnset2Shuffle==onsetShuffled);
                if isempty(countIdx)
                    countIdx=1;
                end
                if (loopNum)>500
                    maxRep4Onset=cell2mat(countMat((countIdx(1)+1),2)).*maxOfReptitionPerMs+1;
                else
                    maxRep4Onset=cell2mat(countMat((countIdx(1)+1),2)).*maxOfReptitionPerMs;
                end
                if sum(originalOnsetVec==onsetShuffled)
                    numOfReptitions=numOfReptitions+1;
                else
                    if (shuffleNum)>1
                        numOfPrevRep=0;
                        for shuffle_col=1:(shuffleNum-1)
                            prevShuffle=cell2mat(shuffleMat(2:end,shuffle_col+1));
                            prevOnset=prevShuffle(shuffledMsId);
                            prevOnsetVec=[(prevOnset-1):(prevOnset+1)];
                            if sum(prevOnsetVec==onsetShuffled)
                                numOfPrevRep=numOfPrevRep+1;
                            end
                        end
                        if numOfPrevRep>maxRep4Onset
                            numOfReptitions=numOfReptitions+1;
                        end
                    end
                end
            end
            if numOfReptitions==maxOfReptitionPerMs
                disp(['shuffle:' num2str(shuffleNum) ' ,loop: ' num2str(loopNum)]);
                numOfReptitions=0;
            else
                numOfReptitions=maxOfReptitionPerMs;
            end
        end
        shuffleMat(2:end,1+shuffleNum)=num2cell(msOnsetShuffled);
    end
    toc;

a=1;