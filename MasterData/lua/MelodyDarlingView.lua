local time,timer = 0,0
local openInfo = nil

function Awake()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.RedPoint_Refresh,SetRed)
end

function SetRed()
    UIUtil:SetRedPoint(redParent,MissionMgr:CheckRed({eTaskType.SONICO}))
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnInit()
    UIUtil:AddTop2("MelodyDarling", topObj, OnClickReturn);
end

function Update()
    if time > 0 and timer < Time.time then
        timer = Time.time + 1
        time = openInfo:GetEndTime() - TimeUtil:GetTime()
        local timeTab = TimeUtil:GetTimeTab(time)
        LanguageMgr:SetText(txtTime,190101,timeTab[1],timeTab[2])
        if time <= 0 then
            OnClickReturn()
        end
    end
end

function OnOpen()
    openInfo = DungeonMgr:GetActiveOpenInfo(54)
    if openInfo then
        SetTime()
        SetRed()
    end
end

function SetTime()
    time = openInfo:GetEndTime() - TimeUtil:GetTime()
end

function OnClickMission()
    CSAPI.OpenView("MelodyDarlingMission",54)
end

function OnClickJump()
    JumpMgr:Jump(61063)
end

function OnClickReturn()
    view:Close()
end