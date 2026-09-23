local cfg = nil
local time, timer = 0, 0
local items = nil
local targetTime = 0

function Awake()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Hot_Supply_Refresh, SetItems)
end

function OnDestroy()
    eventMgr:ClearListener()
    eventMgr = nil
end

function Update()
    if time > 0 and Time.time > timer then
        timer = Time.time + 1
        time = targetTime - TimeUtil:GetTime()
        local tab = TimeUtil:GetTimeTab(time)
        LanguageMgr:SetText(txtTime, 55002, tab[1], tab[2], tab[3])
        if time <= 0 then
            CSAPI.SetText(txtTime, "")
        end
    end
end

function Refresh(info, elseData)
    targetTime = elseData
    cfg = Cfgs.CfgResupply:GetByID(info)
    if cfg then
        SetTime()
        SetItems()
    end
end

function SetTime()
    time = targetTime - TimeUtil:GetTime()
end

function SetItems()
    items = items or {}
    ItemUtil.AddItems("RegressionActivity6/RegressionSupplyItem", items, {cfg}, itemParent, nil, 1)
end
