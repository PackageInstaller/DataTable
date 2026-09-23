local cfg = nil
local data = nil
local sectionData = nil

local time = 0
local timer = 0

function Update()
    if time > 0 and timer < Time.time then
        timer = Time.time + 1
        time = GlobalBossMgr:GetActiveTime()
        if time > 0 then
            local tab = TimeUtil:GetTimeTab(time)
            LanguageMgr:SetText(txtTime,13020,tab[1],string.format("%s:%s:%s",tab[2],tab[3],tab[4]))
        else
            CSAPI.SetText(txtTime,LanguageMgr:GetTips(47001))
        end
    end
end

function Refresh(tab)
    cfg = tab.cfg
    data = tab.data
    sectionData = tab.sectionData
    if cfg then
        SetTime()
    end
end

function SetTime()
    time = GlobalBossMgr:GetActiveTime()
    if time <= 0 then
        CSAPI.SetText(txtTime,LanguageMgr:GetTips(47001))
    end
end