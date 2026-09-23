local cfg = nil
local group = 0
local isClose = false
local isStart = false
local isTop = false

function SetIndex(idx)
    index = idx
end

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_data,_elseData)
    cfg = _data
    group = _elseData and _elseData.group or 2
    isTop = _elseData and _elseData.posType == 1
    if cfg then
        SetName()
        SetIcon()
        SetTime()
        SetState()
    end
end

function SetName()
    local textIndex = isTop and index * 2 - 1 or index * 2
    CSAPI.SetText(txtIndex, (textIndex < 10 and "0" .. textIndex or textIndex)  .. "")
    CSAPI.SetText(txtName, cfg.name)
    local code = "ffffff"
    if not isTop then
        code = "8b2c34"
    end
    CSAPI.SetTextColorByCode(txtIndex,code)
end

function SetIcon()
    local iconName = cfg.icon
    if iconName and iconName ~= "" then
        ResUtil.Summary:Load(icon,group .."/" .. iconName)
    end
end

function SetTime()
    if cfg.sTime and cfg.eTime then
        local sTime, eTime = TimeUtil:GetTimeStampBySplit(cfg.sTime), TimeUtil:GetTimeStampBySplit(cfg.eTime)
        isStart = sTime <= TimeUtil:GetTime()
        isClose = isStart and eTime <= TimeUtil:GetTime()
        local str = TimeUtil:GetTimeHMS(sTime, "%m/%d")
        CSAPI.SetText(txtTime1, str)
        CSAPI.SetText(txtLock, str)
        str = TimeUtil:GetTimeHMS(sTime, "%H:%M")
        CSAPI.SetText(txtTime2, str)
        str = TimeUtil:GetTimeHMS(eTime, "%m/%d")
        CSAPI.SetText(txtTime3, str)
        str = TimeUtil:GetTimeHMS(eTime, "%H:%M")
        CSAPI.SetText(txtTime4, str)
        CSAPI.SetGOActive(timeObj, isStart and not isClose)
    end
end

function SetState()
    CSAPI.SetGOActive(topObj, isTop)
    CSAPI.SetGOActive(downObj, not isTop)
    CSAPI.SetGOAlpha(iconParent, (not isStart or isClose) and 0.3 or 1)
    CSAPI.SetGOActive(txt_lock, not isStart)
    CSAPI.SetGOActive(txt_close, isClose)

    local bgName = "img_05_01"
    local code = "3d3d3d"
    if isClose then
        bgName = "img_05_02"
        code = "ffffff"
    elseif not isStart then
        bgName = "img_05_03"
        code = "ffffff"
    end
    CSAPI.LoadImg(bg,"UIs/Anniversary1/" .. bgName .. ".png",true,nil,true)
    CSAPI.SetTextColorByCode(txtName,code)
end

function GetJumpId()
    return cfg.jumpId
end

function OnClick()
    if isClose or not isStart then
        return
    end
    if cb then
        cb(this)
    end
end
