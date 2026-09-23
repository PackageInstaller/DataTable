local endTime1, endTime2 = nil, nil
local timer = nil
function Awake()
    sd_slider = ComUtil.GetCom(sd, "Slider")
    sr_sv = ComUtil.GetCom(sv, "ScrollRect")
end

function Update()
    if (timer and Time.time >= timer) then
        timer = Time.time + 1
        SetTime()
    end
end

function Refresh(_AccuChargeDataS, _cb)
    data = _AccuChargeDataS
    cb = _cb

    isActive = AccuChargeMgr:IsActive2()

    -- desc
    CSAPI.SetText(txtDesc, data:GetCfg().sDescription)
    -- slider 
    local cur, max = data:GetNums()
    sd_slider.value = cur / max
    CSAPI.SetText(txtSlider, string.format("%s/%s", cur, max))
    -- btns 
    sortType = data:GetSortType()
    CSAPI.SetGOActive(objSuccess, isActive and sortType == 0)
    CSAPI.SetGOActive(btnFinish, sortType == 2)
    CSAPI.SetGOActive(btnGo, isActive and sortType == 1)
    CSAPI.SetGOActive(mask, sortType == 0)
    -- items 
    items = items or {}
    ItemUtil.AddItems("AccuCharge/AccuChargeGridItemS", items, data:GetCfg().jAwardId, itemParent)
    sr_sv.enabled = #data:GetCfg().jAwardId >= 5
    -- red 
    UIUtil:SetRedPoint(node, sortType == 2, 458, 76, 0)
    --
    local b = false
    if(sortType ~= 2 and not isActive) then
        b = true 
    end 
    CSAPI.SetGOActive(objEnd, b)
    --
    InitTime()
end

function InitTime()
    endTime1, endTime2 = nil, nil
    local _endTime1, _endTime2 = AccuChargeMgr:GetEndTime2()
    if (_endTime1 == nil) then
        CSAPI.SetGOActive(objTime, false)
        return
    end
    CSAPI.SetGOActive(objTime, true)
    local curTime = TimeUtil:GetTime()
    if (curTime < _endTime1) then
        endTime1 = _endTime1
        LanguageMgr:SetText(txtTime0, 22075)
    else
        LanguageMgr:SetText(txtTime0, 22076)
    end
    endTime2 = _endTime2
    timer = Time.time
    SetTime()
end

function SetTime()
    local needTime = 0
    if (endTime1) then
        if (endTime1 >= TimeUtil:GetTime()) then
            needTime = endTime1 - TimeUtil:GetTime()
        else
            endTime1 = nil
            LanguageMgr:SetText(txtTime0, 22075)
        end
    elseif (endTime2) then

        if (endTime2 >= TimeUtil:GetTime()) then
            needTime = endTime2 - TimeUtil:GetTime()
        else
            endTime2 = nil
        end
    end
    needTime = needTime <= 0 and 0 or needTime
    local tab = TimeUtil:GetTimeTab(needTime)
    LanguageMgr:SetText(txtTime, 22078, tab[1], tab[2], tab[3], tab[4])
end

function OnClickFinish()
    if (sortType == 2 and cb) then
        CSAPI.SetGOActive(btnFinish, false)
        cb(this)
    end
end

function OnClickGO()
    JumpMgr:Jump(140004)
end
