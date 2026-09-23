local resetTime = -1
local info = nil
function Awake()
    CSAPI.SetGOActive(scale1, false)
    CSAPI.SetGOActive(scale2, false)
end

function Update()
    if info == nil then
        return
    end
    if info.keepTime then
        local tab = TimeUtil:GetDiffHMS(RegressionMgr:GetActivityEndTime(info.type),TimeUtil:GetTime())
        tab.day = tab.day < 10 and "0" .. tab.day or tab.day
        tab.hour = tab.hour < 10 and "0" .. tab.hour or tab.hour
        tab.minute = tab.minute < 10 and "0" .. tab.minute or tab.minute
        tab.second = tab.second < 10 and "0" .. tab.second or tab.second
        LanguageMgr:SetText(txtTime,22031,tab.day,tab.hour,tab.minute,tab.second)
    end
end

function Refresh(_info)
    info = _info
    ShowAnim()
    if info then
        SetRed()
    end
end

function SetRed()
    local isRed = RegressionMgr:CheckRed(info.type, info.activityId)
    UIUtil:SetRedPoint(redParent,isRed)
end

function OnClickJump()
    SetRed()
    JumpMgr:Jump(10301)
end

function ShowAnim()
    CSAPI.SetGOActive(scale1, false)
    CSAPI.SetGOActive(scale1, true)
    FuncUtil:Call(function ()
        CSAPI.SetGOActive(scale2, false)
        CSAPI.SetGOActive(scale2, true)
    end,this,500)
end