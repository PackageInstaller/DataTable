local eventMgr=nil;
local data=nil
function Awake()
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.RedPoint_Refresh,OnRedPointRefersh)
end

function OnDestroy()
    eventMgr:ClearListener();
end

function Refresh(_data)
    data=_data;
    if data~=nil then
        CSAPI.SetText(txtItem1,data:GetName());
    end
    OnRedPointRefersh();
end

function OnRedPointRefersh()
    local _pData1 = RedPointMgr:GetData(RedPointType.CumulativeSpending)
    local isShow=false;
    if _pData1 and _pData1[data:GetID()]~=nil then
        isShow=true;
    end
    UIUtil:SetRedPoint(redNode, isShow, 0, 0, 0)
end