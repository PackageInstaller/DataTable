
function OnOpen()
    if(not data)then
         LogError("播放失败！");
    end
    CSAPI.StopBGM();
    local videoName = data.videoName;
    local video = ResUtil:PlayVideo(videoName);
    CSAPI.SetParent(video.gameObject,node);
    video:AddCompleteEvent(OnComplete);
 
    SetSkipState(false);
    if(g_GuideFightSkipShow and FightClient:IsNewPlayerFight())then
         return;
    end
    FuncUtil:Call(SetSkipState,nil,1000,true);
 end
 
 function SetSkipState(state)
     if(not IsNil(btnSkip))then
         CSAPI.SetGOActive(btnSkip,state);
     end
 end
 
 function OnClickSkip()    
     OnComplete();
     FuncUtil:Call(Close,nil,500);
 end
 
 function Close()
    if(isDestroyed)then
        return;
    end
 
    if(not IsNil(view))then
        view:Close();
    end
 end
 
 
 function OnDestroy()
     isDestroyed = 1;
 end
 
 function OnComplete()    
     if(data)then
         local callBack = data.callBack;
         local caller = data.caller
         data = nil;
         if(callBack)then        
             callBack(caller);
         end
     end
 
     SetSkipState(false);
 end
 