local maskType = 0
local info = nil
local isClose = false
local isStart = false
local group = nil

function SetIndex(idx)
    index = idx
end

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_data,_elseData)
    info = _data
    group = _elseData and _elseData.group
    if info then
        SetIcon()
        SetTitle()
        SetTime()
        SetState()
    end
end

function SetIcon()
    if info.iconType and info.icon then
        if info.iconType == 1 and group then
            ResUtil.Summary:Load(icon,group .. "/" .. info.icon)
        end
    end
end

function SetTitle()
    CSAPI.SetText(txtName, info.name)
    CSAPI.SetText(txtIndex1, index < 10 and "0" .. index or index .. "")
end

function SetTime()
    local sTime, eTime = TimeUtil:GetTimeStampBySplit(info.sTime), TimeUtil:GetTimeStampBySplit(info.eTime)
    isStart = sTime <= TimeUtil:GetTime()
    isClose = isStart and eTime <= TimeUtil:GetTime()
    CSAPI.SetText(txtTime1, TimeUtil:GetTimeHMS(sTime, "%m/%d"))
    CSAPI.SetText(txtTime2, TimeUtil:GetTimeHMS(sTime, "%H:%M"))
    CSAPI.SetText(txtTime3, TimeUtil:GetTimeHMS(eTime, "%m/%d"))
    CSAPI.SetText(txtTime4, TimeUtil:GetTimeHMS(eTime, "%H:%M"))
    if TimeUtil:GetTime() < sTime then
        maskType = 1
    elseif TimeUtil:GetTime() > eTime then
        maskType = 2
    end
end

function SetState()
    CSAPI.SetGOActive(maskObj, maskType > 0)
    CSAPI.SetGOActive(nol,maskType~= 2)
    CSAPI.SetGOActive(lock,maskType== 2)
    if maskType == 1 then
        CSAPI.SetGOAlpha(timeObj, 0.5)
        CSAPI.SetGOAlpha(txtName, 0.5)
        CSAPI.SetGOAlpha(indexObj, 0.5)
        LanguageMgr:SetText(txtFinish,15028)
    elseif maskType == 2 then
        CSAPI.SetTextColorByCode(txtIndex1, "757575")
        CSAPI.SetTextColorByCode(txtIndex2, "757575")
        CSAPI.SetTextColorByCode(txtName, "757575")
        CSAPI.SetGOAlpha(timeObj, 0.5)
        LanguageMgr:SetText(txtFinish,39002)
    else
        CSAPI.SetGOAlpha(timeObj, 1)
        CSAPI.SetGOAlpha(txtName, 1)
        CSAPI.SetGOAlpha(indexObj, 1)
    end
end

function OnClick()
    if isClose or not isStart then
        return
    end
    if cb then
        cb(this)
    end
end

function GetJumpId()
    return info and info.jumpId
end

