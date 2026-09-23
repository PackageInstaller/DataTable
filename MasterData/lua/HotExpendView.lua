local cfg = nil
local targetTime = 0
local timer = 0

function Update()
    if targetTime > 0 and Time.time > timer then
        timer = Time.time + 1
        local tab = TimeUtil:GetDiffHMS(targetTime, TimeUtil:GetTime())
        tab.day = tab.day < 10 and "0" .. tab.day or tab.day
        tab.hour = tab.hour < 10 and "0" .. tab.hour or tab.hour
        tab.minute = tab.minute < 10 and "0" .. tab.minute or tab.minute
        tab.second = tab.second < 10 and "0" .. tab.second or tab.second
        LanguageMgr:SetText(txtTime,22031,tab.day,tab.hour,tab.minute,tab.second)
    end
end

function Refresh(_cfgId,_endTime)
    cfg = Cfgs.CfgDupConsumeReduce:GetByID(_cfgId)
    targetTime = _endTime
    timer = 0
    if cfg then
        SetDesc()
    end
end

function SetDesc()
    LanguageMgr:SetText(txtDesc,60502,cfg.consumeReduce .. "%")
end

function OnClickJump()
    JumpMgr:Jump(10301)
end