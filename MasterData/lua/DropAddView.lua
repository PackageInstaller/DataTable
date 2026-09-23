local resetTime = -1
local cfg = nil
function Awake()
    CSAPI.SetGOActive(scale1, false)
    CSAPI.SetGOActive(scale2, false)
end

function Update()
    if cfg == nil then
        return
    end
    if cfg.eTime then
        local endTime = TimeUtil:GetTimeStampBySplit(cfg.eTime)
        local tab = TimeUtil:GetDiffHMS(endTime,TimeUtil:GetTime())
        tab.day = tab.day < 10 and "0" .. tab.day or tab.day
        tab.hour = tab.hour < 10 and "0" .. tab.hour or tab.hour
        tab.minute = tab.minute < 10 and "0" .. tab.minute or tab.minute
        tab.second = tab.second < 10 and "0" .. tab.second or tab.second
        LanguageMgr:SetText(txtTime,22031,tab.day,tab.hour,tab.minute,tab.second)
    end
end

function Refresh(_data,elseData)
    ShowAnim()
    cfg = elseData and elseData.cfg or nil
    SetRed()
    PlayerPrefs.SetInt(PlayerClient:GetUid() .."_Activity_Red_" .. cfg.id, 1)
end

function SetRed()
    local isRed = ActivityMgr:CheckRed(cfg.id)
    UIUtil:SetRedPoint(redParent,isRed)
end

function OnClickJump()
    SetRed()
    JumpMgr:Jump(10301)
end

function PlayFade(isFade,cb)
    if cb then
        cb()
    end
end

function ShowAnim()
    CSAPI.SetGOActive(scale1, false)
    CSAPI.SetGOActive(scale1, true)
    FuncUtil:Call(function ()
        CSAPI.SetGOActive(scale2, false)
        CSAPI.SetGOActive(scale2, true)
    end,this,500)
end