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
        SetPos()
        SetIcon()
        SetTitle()
        SetTime()
        SetState()
    end
end

function SetPos()
    CSAPI.SetLocalPos(pos,0,index%2 == 0 and 27 or -27)
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
    CSAPI.SetGOAlpha(timeObj,maskType == 2 and 0.5 or 1)
    CSAPI.SetGOActive(imgState1,maskType < 1)
    CSAPI.SetGOActive(imgState2,maskType > 0)
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

