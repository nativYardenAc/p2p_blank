raw 723
%used only for the reviewer calculation of time duration 230924
msVecX=vecX(msMat(ms_id,1):msMat(ms_id,2));
msVecY=vecY(msMat(ms_id,1):msMat(ms_id,2));
[maxX,maxXidx]=max(msVecX);
[minX,minXidx]=min(msVecX);
[maxY,maxYidx]=max(msVecX);
[minY,minYidx]=min(msVecX);
msInTrial(ms_id,6)=min(max([maxXidx,minXidx]),max([maxYidx,minYidx])).*sampleRate;