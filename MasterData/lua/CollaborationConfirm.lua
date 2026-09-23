local state=1;
local eventMgr=nil;
function Awake()
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.RedPoint_Refresh,SetRedInfo)
end

function OnDestroy()
    eventMgr:ClearListener();
end

function SetRedInfo()
    local redInfo=RedPointMgr:GetData(RedPointType.Collaboration);
    local isRed=false;
    if redInfo and redInfo.bind==1 then
        isRed=true
    end
    UIUtil:SetRedPoint(content,isRed,-120,52);
end

function OnOpen()
    SetRedInfo();
    Refresh();
end

function Refresh()
    CSAPI.SetGOActive(iOnObj,state==1);
    CSAPI.SetGOActive(cOnObj,state==2);
end

function OnClickInvitation()
    state=1;
    Refresh();
end

function OnClickCode()
    state=2;
    Refresh();
end

function OnClickOK()
    if state==1 then
        CSAPI.OpenView("CollaborationInvition");
    elseif state==2 then
        CSAPI.OpenView("CollaborationCode");
    end
    Close();
end

function OnClickCancel()
    Close();
end

function Close()
    if IsNil(gameObject) or IsNil(view) then
        do return end
    end
    view:Close();
end