local timer = 0
local curTime = 0
local calTime = false

function OnInit()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Player_HotChange, OnOpen)
end

function OnDestroy()
    eventMgr:ClearListener()
end

function Update()
    if (calTime and Time.time > timer) then
        timer = Time.time + 0.2
        curTime = TimeUtil:GetTime()
        if (nextTime1 >= curTime) then
            SetTime1(nextTime1 - curTime)
        end
        if (nextTime2 >= curTime) then
            SetTime2(nextTime2 - curTime)
        else
            calTime = false
            SetTips()
        end
    end
end

function OnOpen()
    calTime = false

    local cfg = Cfgs.CfgPlrHot:GetByID(PlayerClient:GetLv())
    -- hot
    local cur = PlayerClient:Hot()
    local max1, max2 = PlayerClient:MaxHot()
    CSAPI.SetText(txtHot, string.format("%s/%s", StringUtil:SetByColor(cur, "ffc146"), max1))
    -- time1
    nextTime1 = PlayerClient:THot()
    if (nextTime1 <= 0) then
        SetTime1(0)
    end
    -- time2
    nextTime2 = PlayerClient:MaxTHot()
    if (nextTime2 <= 0) then
        SetTime2(0)
    end
    -- grids
    datas = datas or g_PhysicalStrengthList
    items = items or {}
    ItemUtil.AddItems("Hot/HotItem", items, datas, grids)

    if (nextTime1 > 0 or nextTime2 > 0) then
        calTime = true
    end
    -- tips 
    SetTips()
end

function SetTips()
    CSAPI.SetGOActive(txtTips, calTime and PlayerClient:Hot() >= PlayerClient:MaxHot() and true or false)
end

function SetTime1(time)
    CSAPI.SetText(txtNext2, TimeUtil:GetTimeStr(time))
end

function SetTime2(time)
    CSAPI.SetText(txtMax2, TimeUtil:GetTimeStr(time))
end

function OnClickMask()
    view:Close()
end
