local time, timer, refreshTime = 0, 0, 0
function Awake()
    CSAPI.SetGOActive(clickMask, false)

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.RedPoint_Refresh, SetRed)
    eventMgr:AddListener(EventType.Activity_Open_Refresh, OnPanelRefresh)
    eventMgr:AddListener(EventType.Trials2_Panel_Refresh, OnPanelRefresh)
end

function SetRed()
    local _, isRed1, isRed2 = TrialsMgr:CheckRed()
    if not isRed1 then
        isRed1 = MissionMgr:CheckRed2(eTaskType.ChainFront, TrialsMgr:GetCurSectionId())
    end
    UIUtil:SetRedPoint(redParent, isRed1)
    if not isRed2 then
        isRed2 = MissionMgr:CheckRed({eTaskType.DupLiZhan})
    end
    UIUtil:SetRedPoint(redParent2, isRed2)
end

function OnPanelRefresh()
    SetState()
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnInit()
    UIUtil:AddTop2("TrialsMenu", topObj, OnClickReturn);
end

function Update()
    if time > 0 and Time.time > timer then
        timer = Time.time + 1
        time = refreshTime - TimeUtil:GetTime()
        if time <= 0 then
            SetState()
        end
    end
end

function OnOpen()
    SetState()
    SetRed()
end

function SetState()
    local isOpen, lockStr = MenuMgr:CheckModelOpen(OpenViewType.main, "Trials2")
    if isOpen then
        isOpen = TrialsMgr:GetStartTime() <= TimeUtil:GetTime() and TrialsMgr:GetEndTime() > TimeUtil:GetTime()
        refreshTime = isOpen and TrialsMgr:GetEndTime() or TrialsMgr:GetStartTime()
        time = refreshTime - TimeUtil:GetTime()
        CSAPI.SetGOActive(left, isOpen)
        CSAPI.SetAnchor(right, isOpen and 373 or 0, 0)
    else
        CSAPI.SetGOActive(left, false)
        CSAPI.SetAnchor(right, 0, 0)
    end

    CSAPI.SetGOActive(eLockImg, not isOpen)
    CSAPI.SetGOActive(eLockObj, not isOpen)
    if not isOpen then
        LanguageMgr:SetText(txt_eLock1, 1035)
        CSAPI.SetText(txt_eLock2, lockStr)
    end
    CSAPI.SetGOActive(eLockImg2, false)
    CSAPI.SetGOActive(eLockObj2, false)
end

function OnClickItem(go)
    if go.name == "btnItem" .. 1 then
        CSAPI.OpenView("Trials2", {
            id = TrialsMgr:GetCurSectionId()
        })
    elseif go.name == "btnItem" .. 2 then
        CSAPI.OpenView("TrialsView")
    end
    TrialsMgr:SaveClickInfo(go.name == "btnItem1")
end

function OnClickReturn()
    view:Close()
end
