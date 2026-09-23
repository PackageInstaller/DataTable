--传送台

function Awake()
    cAnimator = ComUtil.GetCom(gameObject,"CAnimator");
    if(cAnimator)then
        
    end
    if(pos)then
        CSAPI.SetLocalPos(pos,0,0.5,0);
--        local r = ComUtil.GetCom(pos,"Renderer");
--        if(not IsNil(r))then
--            r.enabled = false;
--        end
    end
end

--申请传送
function ApplyTransfer(targetCharacter,posGridId,targetGridId,targetCallBack,targetCaller,targetTransferProp)
    character = targetCharacter;
    transferProp = targetTransferProp;
    fromId = posGridId;
    toId = targetGridId;

    callBack = targetCallBack;
    caller = targetCaller;

    local  targetParentId = back and targetGridId or posGridId; 
    local grid = BattleMgr:GetGrid(targetParentId);
    if(not grid)then
        LogError("传送失败，找不到格子" .. tostring(targetParentId));
    end
    CSAPI.SetParent(gameObject,grid.gameObject);

  
    if(pos)then
         CSAPI.SetParent(character.gameObject,pos);
         if(transferProp)then
            CSAPI.SetParent(transferProp.gameObject,pos);            
         end
--    else
--        FuncUtil:Call(ApplyComplete,nil,1000);
    end
end

function OnMoveComplete()
    ApplyComplete();   
end

function ApplyComplete()    
    local characterParentGo = BattleMgr:GetCharacterParentGO();
    CSAPI.SetParent(character.gameObject,characterParentGo);
    character.SetToGrid(toId);

    if(transferProp)then
        CSAPI.SetParent(transferProp.gameObject,characterParentGo);
        transferProp.SetToGrid(toId);         
    end

    if(callBack)then
        callBack(caller);
    end

    CSAPI.RemoveGO(gameObject);
end
function OnDestroy()    
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
pos=nil;
end
----#End#----