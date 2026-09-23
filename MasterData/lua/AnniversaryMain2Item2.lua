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
    CSAPI.SetGOActive(imgFinish,maskType == 2)
    CSAPI.SetGOActive(imgLock,maskType == 1)
    CSAPI.SetGOAlpha(node,maskType == 2 and 0.5 or 1)
    CSAPI.SetGOAlpha(iconParent,maskType == 1 and 0.7 or 1)
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

